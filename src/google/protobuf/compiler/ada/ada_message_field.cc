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

#include <google/protobuf/compiler/ada/ada_message_field.h>
#include <google/protobuf/compiler/ada/ada_helpers.h>
#include <google/protobuf/io/printer.h>
#include <google/protobuf/stubs/strutil.h>

namespace google {
namespace protobuf {
namespace compiler {
namespace ada {

namespace {

void SetMessageVariables(const FieldDescriptor* descriptor,
                         std::map<string, string>* variables,
                         const Options& options) {
  SetCommonFieldVariables(descriptor, variables, options);
  (*variables)["type"] = FieldMessageTypeName(descriptor);
  if (descriptor->options().weak() || !descriptor->containing_oneof()) {
    (*variables)["non_null_ptr_to_name"] =
        StrCat("this->", (*variables)["name"], "_");
  }
  (*variables)["stream_writer"] =
      (*variables)["declared_type"] +
      (HasFastArraySerialization(descriptor->message_type()->file(), options)
           ? "MaybeToArray"
           : "");
  // NOTE: Escaped here to unblock proto1->proto2 migration.
  // TODO(liujisi): Extend this to apply for other conflicting methods.
  (*variables)["release_name"] =
      SafeFunctionName(descriptor->containing_type(),
                       descriptor, "release_");
  (*variables)["full_name"] = descriptor->full_name();
  (*variables)["dependent_type"] = FieldMessageTypeName(descriptor);
  (*variables)["dependent_typename"] = FieldMessageTypeName(descriptor);
}

}  // namespace

// ===================================================================

MessageFieldGenerator::MessageFieldGenerator(const FieldDescriptor* descriptor,
                                             const Options& options)
    : FieldGenerator(options),
      descriptor_(descriptor)
{
  SetMessageVariables(descriptor, &variables_, options);
}

MessageFieldGenerator::~MessageFieldGenerator() {}

void MessageFieldGenerator::
GeneratePrivateMembers(io::Printer* printer) const {
  printer->Print("--TODO: MessageFieldGenerator::GeneratePrivateMembers\n");
}

void MessageFieldGenerator::
GenerateGetterDeclaration(io::Printer* printer) const {
  printer->Print("--TODO: MessageFieldGenerator::GenerateGetterDeclaration\n");
}

void MessageFieldGenerator::
GenerateDependentAccessorDeclarations(io::Printer* printer) const {
  printer->Print("--TODO: MessageFieldGenerator::GenerateDependentAccessorDeclarations\n");
}

void MessageFieldGenerator::
GenerateAccessorDeclarations(io::Printer* printer) const {
  printer->Print("--TODO: MessageFieldGenerator::GenerateAccessorDeclarations\n");
}

void MessageFieldGenerator::GenerateNonInlineAccessorDefinitions(
    io::Printer* printer) const {
  printer->Print("--TODO: MessageFieldGenerator::GenerateNonInlineAccessorDefinitions\n");
}

void MessageFieldGenerator::
GenerateDependentInlineAccessorDefinitions(io::Printer* printer) const {
  printer->Print("--TODO: MessageFieldGenerator::GenerateDependentInlineAccessorDefinitions\n");
}

void MessageFieldGenerator::
GenerateInlineAccessorDefinitions(io::Printer* printer,
                                  bool is_inline) const {
  printer->Print("--TODO: MessageFieldGenerator::GenerateInlineAccessorDefinitions\n");
}

void MessageFieldGenerator::
GenerateClearingCode(io::Printer* printer) const {
  printer->Print("--TODO: MessageFieldGenerator::GenerateClearingCode\n");
}

void MessageFieldGenerator::
GenerateMessageClearingCode(io::Printer* printer) const {
  printer->Print("--TODO: MessageFieldGenerator::GenerateMessageClearingCode\n");
}

void MessageFieldGenerator::
GenerateMergingCode(io::Printer* printer) const {
  printer->Print("--TODO: MessageFieldGenerator::GenerateMergingCode\n");
}

void MessageFieldGenerator::
GenerateSwappingCode(io::Printer* printer) const {
  printer->Print("--TODO: MessageFieldGenerator::GenerateSwappingCode\n");
}

void MessageFieldGenerator::
GenerateDestructorCode(io::Printer* printer) const {
  printer->Print("--TODO: MessageFieldGenerator::GenerateDestructorCode\n");
  // In google3 a default instance will never get deleted so we don't need to
  // worry about that but in opensource protobuf default instances are deleted
  // in shutdown process and we need to take special care when handling them.
}

void MessageFieldGenerator::
GenerateConstructorCode(io::Printer* printer) const {
  printer->Print("--TODO: MessageFieldGenerator::GenerateConstructorCode\n");
}

void MessageFieldGenerator::
GenerateCopyConstructorCode(io::Printer* printer) const {
  printer->Print("--TODO: MessageFieldGenerator::GenerateCopyConstructorCode\n");
  // For non-Arena enabled messages, everything always goes on the heap.
  //
  // For Arena enabled messages, the logic is a bit more convoluted.
  //
  // In the copy constructor, we call InternalMetadataWithArena::MergeFrom,
  // which does *not* copy the Arena pointer.  In the generated MergeFrom
  // (see MessageFieldGenerator::GenerateMergingCode), we:
  // -> copy the has bits (but this is done in bulk by a memcpy in the copy
  //    constructor)
  // -> check whether the destination field pointer is NULL (it will be, since
  //    we're initializing it and would have called SharedCtor) and if so:
  // -> call _slow_mutable_$name$(), which calls either
  //    ::google::protobuf::Arena::CreateMessage<>(GetArenaNoVirtual()), or
  //    ::google::protobuf::Arena::Create<>(GetArenaNoVirtual())
  //
  // At this point, GetArenaNoVirtual returns NULL since the Arena pointer
  // wasn't copied, so both of these methods allocate the submessage on the
  // heap.
}

void MessageFieldGenerator::
GenerateMergeFromCodedStream(io::Printer* printer) const {
  printer->Print("--TODO: MessageFieldGenerator::GenerateMergeFromCodedStream\n");
}

void MessageFieldGenerator::
GenerateSerializeWithCachedSizes(io::Printer* printer) const {
  printer->Print("--TODO: MessageFieldGenerator::GenerateSerializeWithCachedSizes\n");
}

void MessageFieldGenerator::
GenerateSerializeWithCachedSizesToArray(io::Printer* printer) const {
  printer->Print("--TODO: MessageFieldGenerator::GenerateSerializeWithCachedSizesToArray\n");
}

void MessageFieldGenerator::
GenerateByteSize(io::Printer* printer) const {
  printer->Print("--TODO: MessageFieldGenerator::GenerateByteSize\n");
}

// ===================================================================

MessageOneofFieldGenerator::
MessageOneofFieldGenerator(const FieldDescriptor* descriptor,
                           const Options& options)
  : MessageFieldGenerator(descriptor, options) {
  SetCommonOneofFieldVariables(descriptor, &variables_);
}

MessageOneofFieldGenerator::~MessageOneofFieldGenerator() {}


void MessageOneofFieldGenerator::
GenerateDependentAccessorDeclarations(io::Printer* printer) const {
  printer->Print("--TODO: MessageOneofFieldGenerator::GenerateDependentAccessorDeclarations\n");
  // Oneof field getters must be dependent as they call default_instance().
  // Otherwise, the logic is the same as MessageFields.
  MessageFieldGenerator::GenerateDependentAccessorDeclarations(printer);
}

void MessageOneofFieldGenerator::
GenerateGetterDeclaration(io::Printer* printer) const {
  printer->Print("--TODO: MessageOneofFieldGenerator::GenerateGetterDeclaration\n");
  // Oneof field getters must be dependent as they call default_instance().
  // Unlike MessageField, this means there is no (non-dependent) getter to
  // generate.
}

void MessageOneofFieldGenerator::
GenerateDependentInlineAccessorDefinitions(io::Printer* printer) const {
  printer->Print("--TODO: MessageOneofFieldGenerator::GenerateDependentInlineAccessorDefinitions\n");
}

void MessageOneofFieldGenerator::
GenerateInlineAccessorDefinitions(io::Printer* printer,
                                  bool is_inline) const {
  printer->Print("--TODO: MessageOneofFieldGenerator::GenerateInlineAccessorDefinitions\n");
}

void MessageOneofFieldGenerator::
GenerateNonInlineAccessorDefinitions(io::Printer* printer) const {
  printer->Print("--TODO: MessageOneofFieldGenerator::GenerateNonInlineAccessorDefinitions\n");
}

void MessageOneofFieldGenerator::InternalGenerateInlineAccessorDefinitions(
    const std::map<string, string>& variables, io::Printer* printer) const {
  printer->Print("--TODO: MessageOneofFieldGenerator::InternalGenerateInlineAccessorDefinitions\n");
}

void MessageOneofFieldGenerator::
GenerateClearingCode(io::Printer* printer) const {
  printer->Print("--TODO: MessageOneofFieldGenerator::GenerateClearingCode\n");
}

void MessageOneofFieldGenerator::
GenerateMessageClearingCode(io::Printer* printer) const {
  GenerateClearingCode(printer);
}

void MessageOneofFieldGenerator::
GenerateSwappingCode(io::Printer* printer) const {
  // Don't print any swapping code. Swapping the union will swap this field.
}

void MessageOneofFieldGenerator::
GenerateDestructorCode(io::Printer* printer) const {
  // We inherit from MessageFieldGenerator, so we need to override the default
  // behavior.
}

void MessageOneofFieldGenerator::
GenerateConstructorCode(io::Printer* printer) const {
  // Don't print any constructor code. The field is in a union. We allocate
  // space only when this field is used.
}

// ===================================================================

RepeatedMessageFieldGenerator::RepeatedMessageFieldGenerator(
    const FieldDescriptor* descriptor, const Options& options)
    : FieldGenerator(options),
      descriptor_(descriptor) {
  SetMessageVariables(descriptor, &variables_, options);
}

RepeatedMessageFieldGenerator::~RepeatedMessageFieldGenerator() {}

void RepeatedMessageFieldGenerator::
GeneratePrivateMembers(io::Printer* printer) const {
  printer->Print("--TODO: RepeatedMessageFieldGenerator::GeneratePrivateMembers\n");
}

void RepeatedMessageFieldGenerator::
InternalGenerateTypeDependentAccessorDeclarations(io::Printer* printer) const {
  printer->Print("--TODO: RepeatedMessageFieldGenerator::InternalGenerateTypeDependentAccessorDeclarations\n");
}

void RepeatedMessageFieldGenerator::
GenerateDependentAccessorDeclarations(io::Printer* printer) const {
  printer->Print("--TODO: RepeatedMessageFieldGenerator::GenerateDependentAccessorDeclarations\n");
}

void RepeatedMessageFieldGenerator::
GenerateAccessorDeclarations(io::Printer* printer) const {
  printer->Print("--TODO: RepeatedMessageFieldGenerator::GenerateAccessorDeclarations\n");
}

void RepeatedMessageFieldGenerator::
GenerateDependentInlineAccessorDefinitions(io::Printer* printer) const {
  printer->Print("--TODO: RepeatedMessageFieldGenerator::GenerateDependentInlineAccessorDefinitions\n");
}

void RepeatedMessageFieldGenerator::
GenerateInlineAccessorDefinitions(io::Printer* printer,
                                  bool is_inline) const {
  printer->Print("--TODO: RepeatedMessageFieldGenerator::GenerateInlineAccessorDefinitions\n");
}

void RepeatedMessageFieldGenerator::
GenerateClearingCode(io::Printer* printer) const {
  printer->Print("--TODO: RepeatedMessageFieldGenerator::GenerateClearingCode\n");
}

void RepeatedMessageFieldGenerator::
GenerateMergingCode(io::Printer* printer) const {
  printer->Print("--TODO: RepeatedMessageFieldGenerator::GenerateMergingCode\n");
}

void RepeatedMessageFieldGenerator::
GenerateSwappingCode(io::Printer* printer) const {
  printer->Print("--TODO: RepeatedMessageFieldGenerator::GenerateSwappingCode\n");
}

void RepeatedMessageFieldGenerator::
GenerateConstructorCode(io::Printer* printer) const {
  // Not needed for repeated fields.
}

void RepeatedMessageFieldGenerator::
GenerateMergeFromCodedStream(io::Printer* printer) const {
  printer->Print("--TODO: RepeatedMessageFieldGenerator::GenerateMergeFromCodedStream\n");
}

void RepeatedMessageFieldGenerator::
GenerateSerializeWithCachedSizes(io::Printer* printer) const {
  printer->Print("--TODO: RepeatedMessageFieldGenerator::GenerateSerializeWithCachedSizes\n");
}

void RepeatedMessageFieldGenerator::
GenerateSerializeWithCachedSizesToArray(io::Printer* printer) const {
  printer->Print("--TODO: RepeatedMessageFieldGenerator::GenerateSerializeWithCachedSizesToArray\n");
}

void RepeatedMessageFieldGenerator::
GenerateByteSize(io::Printer* printer) const {
  printer->Print("--TODO: RepeatedMessageFieldGenerator::GenerateByteSize\n");
}

}  // namespace ada
}  // namespace compiler
}  // namespace protobuf
}  // namespace google
