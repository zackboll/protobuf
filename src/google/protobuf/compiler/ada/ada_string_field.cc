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

// Author: zackboll@gmail.com (Zack Boll)
//  Based on original Protocol Buffers design by
//  Sanjay Ghemawat, Jeff Dean, and others.

#include <google/protobuf/compiler/ada/ada_string_field.h>
#include <google/protobuf/compiler/ada/ada_helpers.h>
#include <google/protobuf/io/printer.h>
#include <google/protobuf/descriptor.pb.h>
#include <google/protobuf/stubs/strutil.h>

namespace google {
namespace protobuf {
namespace compiler {
namespace ada {

namespace {

// TODO: Copy/pasted from C++ implementation, need to update for
//       Ada implementation

void SetStringVariables(const FieldDescriptor* descriptor,
                        std::map<string, string>* variables,
                        const Options& options) {
  SetCommonFieldVariables(descriptor, variables, options);
  (*variables)["default"] = DefaultValue(descriptor);
  (*variables)["default_length"] =
    SimpleItoa(descriptor->default_value_string().length());
  string default_variable_string = "_default_" + FieldName(descriptor) + "_";
  (*variables)["default_variable_name"] = default_variable_string;
  (*variables)["default_variable"] =
      descriptor->default_value_string().empty()
          ? "&::google::protobuf::internal::GetEmptyStringAlreadyInited()"
          : "&" + (*variables)["classname"] + "::" + default_variable_string +
                ".get()";
  (*variables)["pointer_type"] =
      descriptor->type() == FieldDescriptor::TYPE_BYTES ? "void" : "char";
  // NOTE: Escaped here to unblock proto1->proto2 migration.
  // TODO(liujisi): Extend this to apply for other conflicting methods.
  (*variables)["release_name"] =
      SafeFunctionName(descriptor->containing_type(),
                       descriptor, "release_");
  (*variables)["full_name"] = descriptor->full_name();

  (*variables)["string_piece"] = "::std::string";
}


}  // namespace

// ===================================================================

StringFieldGenerator::StringFieldGenerator(const FieldDescriptor* descriptor,
                                           const Options& options)
    : FieldGenerator(options), descriptor_(descriptor) {
  SetStringVariables(descriptor, &variables_, options);
}

StringFieldGenerator::~StringFieldGenerator() {}

void StringFieldGenerator::
GeneratePrivateMembers(io::Printer* printer) const {
  // N.B. that we continue to use |ArenaStringPtr| instead of |string*| for
  // string fields, even when SupportArenas(descriptor_) == false. Why?
  // The simple answer is to avoid unmaintainable complexity. The reflection
  // code assumes ArenaStringPtrs. These are *almost* in-memory-compatible with
  // string*, except for the pointer tags and related ownership semantics. We
  // could modify the runtime code to use string* for the not-supporting-arenas
  // case, but this would require a way to detect which type of class was
  // generated (adding overhead and complexity to GeneratedMessageReflection)
  // and littering the runtime code paths with conditionals. It's simpler to
  // stick with this but use lightweight accessors that assume arena == NULL.
  // There should be very little overhead anyway because it's just a tagged
  // pointer in-memory.

  printer->Print("--TODO: StringFieldGenerator::GeneratePrivateMembers");
}

void StringFieldGenerator::
GenerateStaticMembers(io::Printer* printer) const {
  if (!descriptor_->default_value_string().empty()) {
    printer->Print("--TODO: StringFieldGenerator::GenerateStaticMembers");
  }
}

void StringFieldGenerator::
GenerateAccessorDeclarations(io::Printer* printer) const {
  // If we're using StringFieldGenerator for a field with a ctype, it's
  // because that ctype isn't actually implemented.  In particular, this is
  // true of ctype=CORD and ctype=STRING_PIECE in the open source release.
  // We aren't releasing Cord because it has too many Google-specific
  // dependencies and we aren't releasing StringPiece because it's hardly
  // useful outside of Google and because it would get confusing to have
  // multiple instances of the StringPiece class in different libraries (PCRE
  // already includes it for their C++ bindings, which came from Google).
  //
  // In any case, we make all the accessors private while still actually
  // using a string to represent the field internally.  This way, we can
  // guarantee that if we do ever implement the ctype, it won't break any
  // existing users who might be -- for whatever reason -- already using .proto
  // files that applied the ctype.  The field can still be accessed via the
  // reflection interface since the reflection interface is independent of
  // the string's underlying representation.

  //TODO: Complete Ada implementation
  printer->Print("--TODO: StringFieldGenerator::GenerateAccessorDeclarations");
}

void StringFieldGenerator::
GenerateInlineAccessorDefinitions(io::Printer* printer,
                                  bool is_inline) const {
  //TODO: Complete Ada implementation
  printer->Print("--TODO: StringFieldGenerator::GenerateInlineAccessorDefinitions");
}

void StringFieldGenerator::
GenerateNonInlineAccessorDefinitions(io::Printer* printer) const {
  //TODO: Complete Ada implementation
  printer->Print("--TODO: StringFieldGenerator::GenerateNonInlineAccessorDefinitions");
}

void StringFieldGenerator::
GenerateClearingCode(io::Printer* printer) const {
  // Two-dimension specialization here: supporting arenas or not, and default
  // value is the empty string or not. Complexity here ensures the minimal
  // number of branches / amount of extraneous code at runtime (given that the
  // below methods are inlined one-liners)!

  // TODO: Complete Ada implementation
  printer->Print("--TODO: StringFieldGenerator::GenerateClearingCode");
}

void StringFieldGenerator::
GenerateMessageClearingCode(io::Printer* printer) const {
  // Two-dimension specialization here: supporting arenas, field presence, or
  // not, and default value is the empty string or not. Complexity here ensures
  // the minimal number of branches / amount of extraneous code at runtime
  // (given that the below methods are inlined one-liners)!

  // If we have field presence, then the Clear() method of the protocol buffer
  // will have checked that this field is set.  If so, we can avoid redundant
  // checks against default_variable.

  printer->Print("--TODO: StringFieldGenerator::GenerateMessageClearingCode");
}

void StringFieldGenerator::
GenerateMergingCode(io::Printer* printer) const {
  printer->Print("--TODO: StringFieldGenerator::GenerateMergingCode");
}

void StringFieldGenerator::
GenerateSwappingCode(io::Printer* printer) const {
  printer->Print("--TODO: StringFieldGenerator::GenerateSwappingCode");
}

void StringFieldGenerator::
GenerateConstructorCode(io::Printer* printer) const {
  printer->Print("--TODO: StringFieldGenerator::GenerateConstructorCode");
}

void StringFieldGenerator::
GenerateCopyConstructorCode(io::Printer* printer) const {
  GenerateConstructorCode(printer);
  printer->Print("--TODO: StringFieldGenerator::GenerateCopyConstructorCode");
}

void StringFieldGenerator::
GenerateDestructorCode(io::Printer* printer) const {
  printer->Print("--TODO: StringFieldGenerator::GenerateDestructorCode");
}

void StringFieldGenerator::
GenerateDefaultInstanceAllocator(io::Printer* printer) const {
  printer->Print("--TODO: StringFieldGenerator::GenerateDefaultInstanceAllocator");
}

void StringFieldGenerator::
GenerateShutdownCode(io::Printer* printer) const {
  printer->Print("--TODO: StringFieldGenerator::GenerateShutdownCode");
}

void StringFieldGenerator::
GenerateMergeFromCodedStream(io::Printer* printer) const {
  printer->Print("--TODO: StringFieldGenerator::GenerateMergeFromCodedStream");
}

void StringFieldGenerator::
GenerateSerializeWithCachedSizes(io::Printer* printer) const {
  printer->Print("--TODO: StringFieldGenerator::GenerateSerializeWithCachedSizes");
}

void StringFieldGenerator::
GenerateSerializeWithCachedSizesToArray(io::Printer* printer) const {
  printer->Print("--TODO: StringFieldGenerator::GenerateSerializeWithCachedSizesToArray");
}

void StringFieldGenerator::
GenerateByteSize(io::Printer* printer) const {
  printer->Print("--TODO: StringFieldGenerator::GenerateByteSize");
}

// ===================================================================

StringOneofFieldGenerator::
StringOneofFieldGenerator(const FieldDescriptor* descriptor,
                          const Options& options)
    : StringFieldGenerator(descriptor, options),
      dependent_field_(options.proto_h) {
  SetCommonOneofFieldVariables(descriptor, &variables_);
}

StringOneofFieldGenerator::~StringOneofFieldGenerator() {}

void StringOneofFieldGenerator::
GenerateInlineAccessorDefinitions(io::Printer* printer,
                                  bool is_inline) const {
  printer->Print("--TODO: StringOneofFieldGenerator::GenerateInlineAccessorDefinitions");
}

void StringOneofFieldGenerator::
GenerateClearingCode(io::Printer* printer) const {
  printer->Print("--TODO: StringOneofFieldGenerator::GenerateClearingCode");
}

void StringOneofFieldGenerator::
GenerateMessageClearingCode(io::Printer* printer) const {
  return GenerateClearingCode(printer);
}

void StringOneofFieldGenerator::
GenerateSwappingCode(io::Printer* printer) const {
  // Don't print any swapping code. Swapping the union will swap this field.
}

void StringOneofFieldGenerator::
GenerateConstructorCode(io::Printer* printer) const {
  printer->Print("--TODO: StringOneofFieldGenerator::GenerateConstructorCode");
}

void StringOneofFieldGenerator::
GenerateMergeFromCodedStream(io::Printer* printer) const {
  printer->Print("--TODO: StringOneofFieldGenerator::GenerateMergeFromCodedStream");
}

// ===================================================================

RepeatedStringFieldGenerator::RepeatedStringFieldGenerator(
    const FieldDescriptor* descriptor, const Options& options)
    : FieldGenerator(options), descriptor_(descriptor) {
  SetStringVariables(descriptor, &variables_, options);
}

RepeatedStringFieldGenerator::~RepeatedStringFieldGenerator() {}

void RepeatedStringFieldGenerator::
GeneratePrivateMembers(io::Printer* printer) const {
  printer->Print("--TODO: RepeatedStringFieldGenerator::GeneratePrivateMembers");
}

void RepeatedStringFieldGenerator::
GenerateAccessorDeclarations(io::Printer* printer) const {
  printer->Print("--TODO: RepeatedStringFieldGenerator::GenerateAccessorDeclarations");
}

void RepeatedStringFieldGenerator::
GenerateInlineAccessorDefinitions(io::Printer* printer,
                                  bool is_inline) const {
  printer->Print("--TODO: RepeatedStringFieldGenerator::GenerateInlineAccessorDefinitions");
}

void RepeatedStringFieldGenerator::
GenerateClearingCode(io::Printer* printer) const {
  printer->Print("--TODO: RepeatedStringFieldGenerator::GenerateClearingCode");
}

void RepeatedStringFieldGenerator::
GenerateMergingCode(io::Printer* printer) const {
  printer->Print("--TODO: RepeatedStringFieldGenerator::GenerateMergingCode");
}

void RepeatedStringFieldGenerator::
GenerateSwappingCode(io::Printer* printer) const {
  printer->Print("--TODO: RepeatedStringFieldGenerator::GenerateSwappingCode");
}

void RepeatedStringFieldGenerator::
GenerateConstructorCode(io::Printer* printer) const {
  // Not needed for repeated fields.
}

void RepeatedStringFieldGenerator::
GenerateCopyConstructorCode(io::Printer* printer) const {
  printer->Print("--TODO: RepeatedStringFieldGenerator::GenerateCopyConstructorCode");
}

void RepeatedStringFieldGenerator::
GenerateMergeFromCodedStream(io::Printer* printer) const {
  printer->Print("--TODO: RepeatedStringFieldGenerator::GenerateMergeFromCodedStream");
}

void RepeatedStringFieldGenerator::
GenerateSerializeWithCachedSizes(io::Printer* printer) const {
  printer->Print("--TODO: RepeatedStringFieldGenerator::GenerateSerializeWithCachedSizes");
}

void RepeatedStringFieldGenerator::
GenerateSerializeWithCachedSizesToArray(io::Printer* printer) const {
  printer->Print("--TODO: RepeatedStringFieldGenerator::GenerateSerializeWithCachedSizesToArray");
}

void RepeatedStringFieldGenerator::
GenerateByteSize(io::Printer* printer) const {
  printer->Print("--TODO: RepeatedStringFieldGenerator::GenerateByteSize");
}

}  // namespace ada
}  // namespace compiler
}  // namespace protobuf
}  // namespace google
