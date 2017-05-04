// Protocol Buffers - Google's data interchange format
// https://github.com/zackboll/protobuf
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are
// met:
//
//     * Redistributions of source code must retain the above copyright
// notice, this list of conditions and the following disclaimer.
//     * Redistributions in binary form must reproduce the above
// copyright notice, this list of conditions and the following disclaimer
// in the documentation and/or other materials provided with the
// distribution.
//     * Neither the name of Google Inc. nor the names of its
// contributors may be used to endorse or promote products derived from
// this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
// "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
// LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
// A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
// OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
// SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
// LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
// DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
// THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
// OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#include <algorithm>
#include <google/protobuf/stubs/hash.h>
#include <map>
#include <memory>
#ifndef _SHARED_PTR_H
#include <google/protobuf/stubs/shared_ptr.h>
#endif
#include <utility>
#include <vector>
#include <google/protobuf/compiler/ada/ada_message.h>
#include <google/protobuf/compiler/ada/ada_field.h>
#include <google/protobuf/compiler/ada/ada_enum.h>
#include <google/protobuf/compiler/ada/ada_extension.h>
#include <google/protobuf/compiler/ada/ada_helpers.h>
#include <google/protobuf/stubs/strutil.h>
#include <google/protobuf/io/printer.h>
#include <google/protobuf/io/coded_stream.h>
#include <google/protobuf/wire_format.h>
#include <google/protobuf/descriptor.pb.h>


namespace google {
namespace protobuf {
namespace compiler {
namespace ada {

using internal::WireFormat;
using internal::WireFormatLite;

namespace {

template <class T>
void PrintFieldComment(io::Printer* printer, const T* field) {
  // Print the field's (or oneof's) proto-syntax definition as a comment.
  // We don't want to print group bodies so we cut off after the first
  // line.
  DebugStringOptions options;
  options.elide_group_body = true;
  options.elide_oneof_body = true;
  string def = field->DebugStringWithOptions(options);
  printer->Print("// $def$\n",
    "def", def.substr(0, def.find_first_of('\n')));
}

struct FieldOrderingByNumber {
  inline bool operator()(const FieldDescriptor* a,
                         const FieldDescriptor* b) const {
    return a->number() < b->number();
  }
};

// Sort the fields of the given Descriptor by number into a new[]'d array
// and return it.
std::vector<const FieldDescriptor*> SortFieldsByNumber(
    const Descriptor* descriptor) {
  std::vector<const FieldDescriptor*> fields(descriptor->field_count());
  for (int i = 0; i < descriptor->field_count(); i++) {
    fields[i] = descriptor->field(i);
  }
  std::sort(fields.begin(), fields.end(), FieldOrderingByNumber());
  return fields;
}

// Functor for sorting extension ranges by their "start" field number.
struct ExtensionRangeSorter {
  bool operator()(const Descriptor::ExtensionRange* left,
                  const Descriptor::ExtensionRange* right) const {
    return left->start < right->start;
  }
};

// Returns true if the "required" restriction check should be ignored for the
// given field.
inline static bool ShouldIgnoreRequiredFieldCheck(const FieldDescriptor* field,
                                                  const Options& options) {
  return false;
}

// Returns true if the message type has any required fields.  If it doesn't,
// we can optimize out calls to its IsInitialized() method.
//
// already_seen is used to avoid checking the same type multiple times
// (and also to protect against recursion).
static bool HasRequiredFields(const Descriptor* type, const Options& options,
                              hash_set<const Descriptor*>* already_seen) {
  if (already_seen->count(type) > 0) {
    // Since the first occurrence of a required field causes the whole
    // function to return true, we can assume that if the type is already
    // in the cache it didn't have any required fields.
    return false;
  }
  already_seen->insert(type);

  // If the type has extensions, an extension with message type could contain
  // required fields, so we have to be conservative and assume such an
  // extension exists.
  if (type->extension_range_count() > 0) return true;

  for (int i = 0; i < type->field_count(); i++) {
    const FieldDescriptor* field = type->field(i);
    if (field->is_required()) {
      return true;
    }
    if (field->cpp_type() == FieldDescriptor::CPPTYPE_MESSAGE &&
        !ShouldIgnoreRequiredFieldCheck(field, options)) {
      if (HasRequiredFields(field->message_type(), options, already_seen)) {
        return true;
      }
    }
  }

  return false;
}

static bool HasRequiredFields(const Descriptor* type, const Options& options) {
  hash_set<const Descriptor*> already_seen;
  return HasRequiredFields(type, options, &already_seen);
}

// This returns an estimate of the compiler's alignment for the field.  This
// can't guarantee to be correct because the generated code could be compiled on
// different systems with different alignment rules.  The estimates below assume
// 64-bit pointers.
int EstimateAlignmentSize(const FieldDescriptor* field) {
  if (field == NULL) return 0;
  if (field->is_repeated()) return 8;
  switch (field->cpp_type()) {
    case FieldDescriptor::CPPTYPE_BOOL:
      return 1;

    case FieldDescriptor::CPPTYPE_INT32:
    case FieldDescriptor::CPPTYPE_UINT32:
    case FieldDescriptor::CPPTYPE_ENUM:
    case FieldDescriptor::CPPTYPE_FLOAT:
      return 4;

    case FieldDescriptor::CPPTYPE_INT64:
    case FieldDescriptor::CPPTYPE_UINT64:
    case FieldDescriptor::CPPTYPE_DOUBLE:
    case FieldDescriptor::CPPTYPE_STRING:
    case FieldDescriptor::CPPTYPE_MESSAGE:
      return 8;
  }
  GOOGLE_LOG(FATAL) << "Can't get here.";
  return -1;  // Make compiler happy.
}

// FieldGroup is just a helper for OptimizePadding below.  It holds a vector of
// fields that are grouped together because they have compatible alignment, and
// a preferred location in the final field ordering.
class FieldGroup {
 public:
  FieldGroup()
      : preferred_location_(0) {}

  // A group with a single field.
  FieldGroup(float preferred_location, const FieldDescriptor* field)
      : preferred_location_(preferred_location),
        fields_(1, field) {}

  // Append the fields in 'other' to this group.
  void Append(const FieldGroup& other) {
    if (other.fields_.empty()) {
      return;
    }
    // Preferred location is the average among all the fields, so we weight by
    // the number of fields on each FieldGroup object.
    preferred_location_ =
        (preferred_location_ * fields_.size() +
         (other.preferred_location_ * other.fields_.size())) /
        (fields_.size() + other.fields_.size());
    fields_.insert(fields_.end(), other.fields_.begin(), other.fields_.end());
  }

  void SetPreferredLocation(float location) { preferred_location_ = location; }
  const std::vector<const FieldDescriptor*>& fields() const { return fields_; }

  // FieldGroup objects sort by their preferred location.
  bool operator<(const FieldGroup& other) const {
    return preferred_location_ < other.preferred_location_;
  }

 private:
  // "preferred_location_" is an estimate of where this group should go in the
  // final list of fields.  We compute this by taking the average index of each
  // field in this group in the original ordering of fields.  This is very
  // approximate, but should put this group close to where its member fields
  // originally went.
  float preferred_location_;
  std::vector<const FieldDescriptor*> fields_;
  // We rely on the default copy constructor and operator= so this type can be
  // used in a vector.
};

// Helper for the code that emits the Clear() method.
bool CanInitializeByZeroing(const FieldDescriptor* field) {
  if (field->is_repeated() || field->is_extension()) return false;
  switch (field->cpp_type()) {
    case internal::WireFormatLite::CPPTYPE_ENUM:
      return field->default_value_enum()->number() == 0;
    case internal::WireFormatLite::CPPTYPE_INT32:
      return field->default_value_int32() == 0;
    case internal::WireFormatLite::CPPTYPE_INT64:
      return field->default_value_int64() == 0;
    case internal::WireFormatLite::CPPTYPE_UINT32:
      return field->default_value_uint32() == 0;
    case internal::WireFormatLite::CPPTYPE_UINT64:
      return field->default_value_uint64() == 0;
    case internal::WireFormatLite::CPPTYPE_FLOAT:
      return field->default_value_float() == 0;
    case internal::WireFormatLite::CPPTYPE_DOUBLE:
      return field->default_value_double() == 0;
    case internal::WireFormatLite::CPPTYPE_BOOL:
      return field->default_value_bool() == false;
    default:
      return false;
  }
}

bool IsPOD(const FieldDescriptor* field) {
  if (field->is_repeated() || field->is_extension()) return false;
  switch (field->cpp_type()) {
    case internal::WireFormatLite::CPPTYPE_ENUM:
    case internal::WireFormatLite::CPPTYPE_INT32:
    case internal::WireFormatLite::CPPTYPE_INT64:
    case internal::WireFormatLite::CPPTYPE_UINT32:
    case internal::WireFormatLite::CPPTYPE_UINT64:
    case internal::WireFormatLite::CPPTYPE_FLOAT:
    case internal::WireFormatLite::CPPTYPE_DOUBLE:
    case internal::WireFormatLite::CPPTYPE_BOOL:
      return true;
    case internal::WireFormatLite::CPPTYPE_STRING:
      return false;
    default:
      return false;
  }
}

// Helper for the code that emits the SharedCtor() method.
bool CanConstructByZeroing(const FieldDescriptor* field,
                           const Options& options) {
  bool ret = CanInitializeByZeroing(field);

  // Non-repeated, non-lazy message fields are simply raw pointers, so we can
  // use memset to initialize these in SharedCtor.  We cannot use this in
  // Clear, as we need to potentially delete the existing value.
  ret = ret ||
      (!field->is_repeated() &&
       field->cpp_type() == FieldDescriptor::CPPTYPE_MESSAGE);
  return ret;
}

// Reorder 'fields' so that if the fields are output into a c++ class in the new
// order, fields of similiar family (see below) are together and within each
// family, alignment padding is minimized.
//
// We try to do this while keeping each field as close as possible to its
// declaration order (from the .proto file) so that we don't reduce cache
// locality much for function that access each field in order.  This is also the
// only (weak) signal we have for author intent concerning field layout.
//
// TODO(ckennelly):  If/when we have profiles available for the compiler, use
// those rather than respect declaration order.
//
// We classify each field into a particular "family" of fields, that we perform
// the same operation on in our generated functions.
//
// REPEATED is placed first, as the C++ compiler automatically initializes
// these fields in layout order.
//
// STRING is grouped next, as our Clear/SharedCtor/SharedDtor walks it and
// calls ArenaStringPtr::Destroy on each.
//
//
// MESSAGE is grouped next, as our Clear/SharedDtor code walks it and calls
// delete on each.  We initialize these fields with a NULL pointer (see
// MessageFieldGenerator::GenerateConstructorCode), which allows them to be
// memset.
//
// ZERO_INITIALIZABLE is memset in Clear/SharedCtor
//
// OTHER these fields are initialized one-by-one.
void OptimizePadding(std::vector<const FieldDescriptor*>* fields,
                     const Options& options) {
  // The sorted numeric order of Family determines the declaration order in the
  // memory layout.
  enum Family {
    REPEATED = 0,
    STRING = 1,
    MESSAGE = 2,
    ZERO_INITIALIZABLE = 4,
    OTHER = 5,
    kMaxFamily
  };

  // First divide fields into those that align to 1 byte, 4 bytes or 8 bytes.
  std::vector<FieldGroup> aligned_to_1[kMaxFamily];
  std::vector<FieldGroup> aligned_to_4[kMaxFamily];
  std::vector<FieldGroup> aligned_to_8[kMaxFamily];
  for (int i = 0; i < fields->size(); ++i) {
    const FieldDescriptor* field = (*fields)[i];

    Family f = OTHER;
    if (field->is_repeated()) {
      f = REPEATED;
    } else if (field->cpp_type() == FieldDescriptor::CPPTYPE_STRING) {
      f = STRING;
    } else if (field->cpp_type() == FieldDescriptor::CPPTYPE_MESSAGE) {
      f = MESSAGE;

    } else if (CanInitializeByZeroing(field)) {
      f = ZERO_INITIALIZABLE;
    }

    switch (EstimateAlignmentSize(field)) {
      case 1: aligned_to_1[f].push_back(FieldGroup(i, field)); break;
      case 4: aligned_to_4[f].push_back(FieldGroup(i, field)); break;
      case 8: aligned_to_8[f].push_back(FieldGroup(i, field)); break;
      default:
        GOOGLE_LOG(FATAL) << "Unknown alignment size.";
    }
  }

  // For each family, group fields to optimize padding.
  for (int f = 0; f < kMaxFamily; f++) {
    // Now group fields aligned to 1 byte into sets of 4, and treat those like a
    // single field aligned to 4 bytes.
    for (int i = 0; i < aligned_to_1[f].size(); i += 4) {
      FieldGroup field_group;
      for (int j = i; j < aligned_to_1[f].size() && j < i + 4; ++j) {
        field_group.Append(aligned_to_1[f][j]);
      }
      aligned_to_4[f].push_back(field_group);
    }
    // Sort by preferred location to keep fields as close to their declaration
    // order as possible.  Using stable_sort ensures that the output is
    // consistent across runs.
    std::stable_sort(aligned_to_4[f].begin(), aligned_to_4[f].end());

    // Now group fields aligned to 4 bytes (or the 4-field groups created above)
    // into pairs, and treat those like a single field aligned to 8 bytes.
    for (int i = 0; i < aligned_to_4[f].size(); i += 2) {
      FieldGroup field_group;
      for (int j = i; j < aligned_to_4[f].size() && j < i + 2; ++j) {
        field_group.Append(aligned_to_4[f][j]);
      }
      if (i == aligned_to_4[f].size() - 1) {
        if (f == OTHER) {
          // Move incomplete 4-byte block to the beginning.  This is done to
          // pair with the (possible) leftover blocks from the
          // ZERO_INITIALIZABLE family.
          field_group.SetPreferredLocation(-1);
        } else {
          // Move incomplete 4-byte block to the end.
          field_group.SetPreferredLocation(fields->size() + 1);
        }
      }
      aligned_to_8[f].push_back(field_group);
    }
    // Sort by preferred location.
    std::stable_sort(aligned_to_8[f].begin(), aligned_to_8[f].end());
  }

  // Now pull out all the FieldDescriptors in order.
  fields->clear();
  for (int f = 0; f < kMaxFamily; ++f) {
    for (int i = 0; i < aligned_to_8[f].size(); ++i) {
      fields->insert(fields->end(),
                     aligned_to_8[f][i].fields().begin(),
                     aligned_to_8[f][i].fields().end());
    }
  }
}

string MessageTypeProtoName(const FieldDescriptor* field) {
  return field->message_type()->full_name();
}

// Emits an if-statement with a condition that evaluates to true if |field| is
// considered non-default (will be sent over the wire), for message types
// without true field presence. Should only be called if
// !HasFieldPresence(message_descriptor).
bool EmitFieldNonDefaultCondition(io::Printer* printer,
                                  const string& prefix,
                                  const FieldDescriptor* field) {
  // Merge and serialize semantics: primitive fields are merged/serialized only
  // if non-zero (numeric) or non-empty (string).
  if (!field->is_repeated() && !field->containing_oneof()) {
    if (field->cpp_type() == FieldDescriptor::CPPTYPE_STRING) {
      printer->Print(
          "if ($prefix$$name$().size() > 0) {\n",
          "prefix", prefix,
          "name", FieldName(field));
    } else if (field->cpp_type() == FieldDescriptor::CPPTYPE_MESSAGE) {
      // Message fields still have has_$name$() methods.
      printer->Print(
          "if ($prefix$has_$name$()) {\n",
          "prefix", prefix,
          "name", FieldName(field));
    } else {
      printer->Print(
          "if ($prefix$$name$() != 0) {\n",
          "prefix", prefix,
          "name", FieldName(field));
    }
    printer->Indent();
    return true;
  } else if (field->containing_oneof()) {
    printer->Print(
        "if (has_$name$()) {\n",
        "name", FieldName(field));
    printer->Indent();
    return true;
  }
  return false;
}

// Does the given field have a has_$name$() method?
bool HasHasMethod(const FieldDescriptor* field) {
  if (HasFieldPresence(field->file())) {
    // In proto1/proto2, every field has a has_$name$() method.
    return true;
  }
  // For message types without true field presence, only fields with a message
  // type have a has_$name$() method.
  return field->cpp_type() == FieldDescriptor::CPPTYPE_MESSAGE;
}

// Collects map entry message type information.
void CollectMapInfo(const Descriptor* descriptor,
                    std::map<string, string>* variables) {
  GOOGLE_CHECK(IsMapEntryMessage(descriptor));
  const FieldDescriptor* key = descriptor->FindFieldByName("key");
  const FieldDescriptor* val = descriptor->FindFieldByName("value");
  (*variables)["key"] = PrimitiveTypeName(key->cpp_type());
  switch (val->cpp_type()) {
    case FieldDescriptor::CPPTYPE_MESSAGE:
      (*variables)["val"] = FieldMessageTypeName(val);
      break;
    case FieldDescriptor::CPPTYPE_ENUM:
      (*variables)["val"] = ClassName(val->enum_type(), true);
      break;
    default:
      (*variables)["val"] = PrimitiveTypeName(val->cpp_type());
  }
  (*variables)["key_wire_type"] =
      "::google::protobuf::internal::WireFormatLite::TYPE_" +
      ToUpper(DeclaredTypeMethodName(key->type()));
  (*variables)["val_wire_type"] =
      "::google::protobuf::internal::WireFormatLite::TYPE_" +
      ToUpper(DeclaredTypeMethodName(val->type()));
}

// Does the given field have a private (internal helper only) has_$name$()
// method?
bool HasPrivateHasMethod(const FieldDescriptor* field) {
  // Only for oneofs in message types with no field presence. has_$name$(),
  // based on the oneof case, is still useful internally for generated code.
  return (!HasFieldPresence(field->file()) &&
          field->containing_oneof() != NULL);
}


}  // anonymous namespace

// ===================================================================

MessageGenerator::MessageGenerator(const Descriptor* descriptor,
                                   const Options& options)
    : descriptor_(descriptor),
      classname_(ClassName(descriptor, false)),
      options_(options),
      field_generators_(descriptor, options),
      max_has_bit_index_(0),
      nested_generators_(new google::protobuf::scoped_ptr<
          MessageGenerator>[descriptor->nested_type_count()]),
      enum_generators_(
          new google::protobuf::scoped_ptr<EnumGenerator>[descriptor->enum_type_count()]),
      extension_generators_(new google::protobuf::scoped_ptr<
          ExtensionGenerator>[descriptor->extension_count()]),
      use_dependent_base_(false) {

  // Compute optimized field order to be used for layout and initialization
  // purposes.
  for (int i = 0; i < descriptor_->field_count(); i++) {
    if (!descriptor_->field(i)->containing_oneof()) {
      optimized_order_.push_back(descriptor_->field(i));
    }
  }
  OptimizePadding(&optimized_order_, options_);

  if (HasFieldPresence(descriptor_->file())) {
    // We use -1 as a sentinel.
    has_bit_indices_.resize(descriptor_->field_count(), -1);
    for (int i = 0; i < optimized_order_.size(); i++) {
      const FieldDescriptor* field = optimized_order_[i];
      // Skip fields that do not have has bits.
      if (field->is_repeated()) {
        continue;
      }

      has_bit_indices_[field->index()] = max_has_bit_index_++;
    }
  }

  for (int i = 0; i < descriptor->nested_type_count(); i++) {
    nested_generators_[i].reset(
      new MessageGenerator(descriptor->nested_type(i), options));
  }

  for (int i = 0; i < descriptor->enum_type_count(); i++) {
    enum_generators_[i].reset(
      new EnumGenerator(descriptor->enum_type(i), options));
  }

  for (int i = 0; i < descriptor->extension_count(); i++) {
    extension_generators_[i].reset(
      new ExtensionGenerator(descriptor->extension(i), options));
  }

  num_required_fields_ = 0;
  for (int i = 0; i < descriptor->field_count(); i++) {
    if (descriptor->field(i)->is_required()) {
      ++num_required_fields_;
    }
  }
}

MessageGenerator::~MessageGenerator() {}

size_t MessageGenerator::HasBitsSize() const {
  size_t sizeof_has_bits = (max_has_bit_index_ + 31) / 32 * 4;
  if (sizeof_has_bits == 0) {
    // Zero-size arrays aren't technically allowed, and MSVC in particular
    // doesn't like them.  We still need to declare these arrays to make
    // other code compile.  Since this is an uncommon case, we'll just declare
    // them with size 1 and waste some space.  Oh well.
    sizeof_has_bits = 4;
  }

  return sizeof_has_bits;
}

void MessageGenerator::Flatten(std::vector<MessageGenerator*>* list) {
  for (int i = 0; i < descriptor_->nested_type_count(); i++) {
    nested_generators_[i]->Flatten(list);
  }
  list->push_back(this);
}

void MessageGenerator::AddGenerators(
    std::vector<EnumGenerator*>* enum_generators,
    std::vector<ExtensionGenerator*>* extension_generators) {
  for (int i = 0; i < descriptor_->enum_type_count(); i++) {
    enum_generators->push_back(enum_generators_[i].get());
  }
  for (int i = 0; i < descriptor_->extension_count(); i++) {
    extension_generators->push_back(extension_generators_[i].get());
  }
}

void MessageGenerator::FillMessageForwardDeclarations(
    std::map<string, const Descriptor*>* class_names) {
  if (IsMapEntryMessage(descriptor_)) return;
  (*class_names)[classname_] = descriptor_;
}

void MessageGenerator::
GenerateDependentFieldAccessorDeclarations(io::Printer* printer) {
  printer->Print("--TODO: MessageGenerator::GenerateFieldAccessorDeclarations\n");
}

void MessageGenerator::
GenerateFieldAccessorDeclarations(io::Printer* printer) {
  printer->Print("--TODO: MessageGenerator::GenerateFieldAccessorDeclarations\n");
}

void MessageGenerator::
GenerateDependentFieldAccessorDefinitions(io::Printer* printer) {
  printer->Print("--TODO: MessageGenerator::GenerateDependentFieldAccessorDefinitions\n");
}

void MessageGenerator::
GenerateSingularFieldHasBits(const FieldDescriptor* field,
                             std::map<string, string> vars,
                             io::Printer* printer) {
  printer->Print("--TODO: MessageGenerator::GenerateSingularFieldHasBits\n");
}

void MessageGenerator::
GenerateOneofHasBits(io::Printer* printer, bool is_inline) {
  printer->Print("--TODO: MessageGenerator::GenerateOneofHasBits\n");
}

void MessageGenerator::
GenerateOneofMemberHasBits(const FieldDescriptor* field,
                           const std::map<string, string>& vars,
                           io::Printer* printer) {
  printer->Print("--TODO: MessageGenerator::GenerateOneofMemberHasBits\n");
}

void MessageGenerator::
GenerateFieldClear(const FieldDescriptor* field,
                   const std::map<string, string>& vars,
                   io::Printer* printer) {
  printer->Print("--TODO: MessageGenerator::GenerateFieldClear\n");
}

void MessageGenerator::
GenerateFieldAccessorDefinitions(io::Printer* printer, bool is_inline) {
  printer->Print("--TODO: MessageGenerator::GenerateFieldAccessorDefinitions\n");
}

void MessageGenerator::
GenerateDependentBaseClassDefinition(io::Printer* printer) {
  printer->Print("--TODO: MessageGenerator::GenerateDependentBaseClassDefinition\n");
}

void MessageGenerator::
GenerateClassDefinition(io::Printer* printer) {
  printer->Print("--TODO: MessageGenerator::GenerateClassDefinition\n");
}

void MessageGenerator::
GenerateDependentInlineMethods(io::Printer* printer) {
  if (IsMapEntryMessage(descriptor_)) return;
  for (int i = 0; i < descriptor_->field_count(); i++) {
    if (descriptor_->field(i)->options().weak()) {
      field_generators_.get(descriptor_->field(i))
          .GenerateDependentInlineAccessorDefinitions(printer);
    }
  }
  GenerateDependentFieldAccessorDefinitions(printer);
}

void MessageGenerator::
GenerateInlineMethods(io::Printer* printer, bool is_inline) {
  printer->Print("--TODO: MessageGenerator::GenerateInlineMethods\n");
}

void MessageGenerator::
GenerateExtraDefaultFields(io::Printer* printer) {
  printer->Print("--TODO: MessageGenerator::GenerateExtraDefaultFields\n");
}

void MessageGenerator::GenerateSchema(io::Printer* printer, int offset,
                                      int has_offset) {
  printer->Print("--TODO: MessageGenerator::GenerateSchema\n");
}

void MessageGenerator::
GenerateTypeRegistrations(io::Printer* printer) {
  printer->Print("--TODO: MessageGenerator::GenerateTypeRegistrations\n");
}

void MessageGenerator::
GenerateDefaultInstanceAllocator(io::Printer* printer) {
  printer->Print("--TODO: MessageGenerator::GenerateDefaultInstanceAllocator\n");
}

void MessageGenerator::
GenerateDefaultInstanceInitializer(io::Printer* printer) {
  printer->Print("--TODO: MessageGenerator::GenerateDefaultInstanceInitializer\n");
}

void MessageGenerator::
GenerateShutdownCode(io::Printer* printer) {
  printer->Print("--TODO: MessageGenerator::GenerateShutdownCode\n");
}

void MessageGenerator::
GenerateClassMethods(io::Printer* printer) {
  printer->Print("--TODO: MessageGenerator::GenerateClassMethods\n");
}

std::pair<size_t, size_t> MessageGenerator::GenerateOffsets(
    io::Printer* printer) {
  printer->Print("--TODO: MessageGenerator::GenerateOffsets\n");

  const int kNumGenericOffsets = 4;  // the number of fixed offsets above
  const size_t offsets = kNumGenericOffsets +
                         descriptor_->field_count() +
                         descriptor_->oneof_decl_count();
  size_t entries = offsets;

  return std::make_pair(entries, offsets);
}

void MessageGenerator::
GenerateSharedConstructorCode(io::Printer* printer) {
  printer->Print("--TODO: MessageGenerator::GenerateSharedDestructorCode\n");
}

void MessageGenerator::
GenerateSharedDestructorCode(io::Printer* printer) {
  printer->Print("--TODO: MessageGenerator::GenerateSharedDestructorCode\n");
}

void MessageGenerator::
GenerateArenaDestructorCode(io::Printer* printer) {
  printer->Print("--TODO: MessageGenerator::GenerateArenaDestructorCode\n");
}

void MessageGenerator::GenerateConstructorBody(io::Printer* printer,
                                               std::vector<bool> processed,
                                               bool copy_constructor) const {
  printer->Print("--TODO: MessageGenerator::GenerateConstructorBody\n");
}

void MessageGenerator::
GenerateStructors(io::Printer* printer) {
  printer->Print("--TODO: MessageGenerator::GenerateStructors\n");
}

// Return the number of bits set in n, a non-negative integer.
static int popcnt(uint32 n) {
  int result = 0;
  while (n != 0) {
    result += (n & 1);
    n = n / 2;
  }
  return result;
}

void MessageGenerator::
GenerateClear(io::Printer* printer) {
  printer->Print("--TODO: MessageGenerator::GenerateMergeFrom\n");
}

void MessageGenerator::
GenerateOneofClear(io::Printer* printer) {
  printer->Print("--TODO: MessageGenerator::GenerateMergeFrom\n");
}

void MessageGenerator::
GenerateSwap(io::Printer* printer) {
  printer->Print("--TODO: MessageGenerator::GenerateMergeFrom\n");
}

void MessageGenerator::
GenerateMergeFrom(io::Printer* printer) {
  printer->Print("--TODO: MessageGenerator::GenerateMergeFrom\n");
}

void MessageGenerator::
GenerateCopyFrom(io::Printer* printer) {
  printer->Print("--TODO: MessageGenerator::GenerateCopyFrom\n");
}

void MessageGenerator::
GenerateMergeFromCodedStream(io::Printer* printer) {
  printer->Print("--TODO: MessageGenerator::GenerateMergeFromCodedStream\n");
}

void MessageGenerator::GenerateSerializeOneofFields(
    io::Printer* printer, const std::vector<const FieldDescriptor*>& fields,
    bool to_array) {
  printer->Print("--TODO: MessageGenerator::GenerateSerializeOneofFields\n");
}

void MessageGenerator::GenerateSerializeOneField(
    io::Printer* printer, const FieldDescriptor* field, bool to_array) {
  printer->Print("--TODO: MessageGenerator::GenerateSerializeOneField\n");
}

void MessageGenerator::GenerateSerializeOneExtensionRange(
    io::Printer* printer, const Descriptor::ExtensionRange* range,
    bool to_array) {
  printer->Print("--TODO: MessageGenerator::GenerateSerializeOneExtensionRange\n");
}

void MessageGenerator::
GenerateSerializeWithCachedSizes(io::Printer* printer) {
  printer->Print("--TODO: MessageGenerator::GenerateSerializeWithCachedSizes\n");
}

void MessageGenerator::
GenerateSerializeWithCachedSizesToArray(io::Printer* printer) {
  printer->Print("--TODO: MessageGenerator::GenerateSerializeWithCachedSizesToArray\n");
}

void MessageGenerator::
GenerateSerializeWithCachedSizesBody(io::Printer* printer, bool to_array) {
  printer->Print("--TODO: MessageGenerator::GenerateSerializeWithCachedSizesBody\n");
}

std::vector<uint32> MessageGenerator::RequiredFieldsBitMask() const {
  const int array_size = HasBitsSize();
  std::vector<uint32> masks(array_size, 0);

  for (int i = 0; i < descriptor_->field_count(); i++) {
    const FieldDescriptor* field = descriptor_->field(i);
    if (!field->is_required()) {
      continue;
    }

    const int has_bit_index = has_bit_indices_[field->index()];
    masks[has_bit_index / 32] |=
        static_cast<uint32>(1) << (has_bit_index % 32);
  }
  return masks;
}

// Create an expression that evaluates to
//  "for all i, (_has_bits_[i] & masks[i]) == masks[i]"
// masks is allowed to be shorter than _has_bits_, but at least one element of
// masks must be non-zero.
static string ConditionalToCheckBitmasks(const std::vector<uint32>& masks) {
  std::vector<string> parts;
  for (int i = 0; i < masks.size(); i++) {
    if (masks[i] == 0) continue;
    string m = StrCat("0x", strings::Hex(masks[i], strings::ZERO_PAD_8));
    // Each xor evaluates to 0 if the expected bits are present.
    parts.push_back(StrCat("((_has_bits_[", i, "] & ", m, ") ^ ", m, ")"));
  }
  GOOGLE_CHECK(!parts.empty());
  // If we have multiple parts, each expected to be 0, then bitwise-or them.
  string result = parts.size() == 1 ? parts[0] :
      StrCat("(", Join(parts, "\n       | "), ")");
  return result + " == 0";
}

void MessageGenerator::
GenerateByteSize(io::Printer* printer) {
  printer->Print("--TODO: MessageGenerator::GenerateByteSize\n");
}

void MessageGenerator::
GenerateIsInitialized(io::Printer* printer) {
  printer->Print("--TODO: MessageGenerator::GenerateIsInitialized\n");
}


}  // namespace ada
}  // namespace compiler
}  // namespace protobuf
}  // namespace google
