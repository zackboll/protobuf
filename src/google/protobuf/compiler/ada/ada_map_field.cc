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

#include <google/protobuf/compiler/ada/ada_map_field.h>
#include <google/protobuf/compiler/ada/ada_helpers.h>
#include <google/protobuf/io/printer.h>
#include <google/protobuf/wire_format.h>
#include <google/protobuf/stubs/strutil.h>

namespace google {
namespace protobuf {
namespace compiler {
namespace ada {

bool IsProto3Field(const FieldDescriptor* field_descriptor) {
  const FileDescriptor* file_descriptor = field_descriptor->file();
  return file_descriptor->syntax() == FileDescriptor::SYNTAX_PROTO3;
}

void SetMessageVariables(const FieldDescriptor* descriptor,
                         std::map<string, string>* variables,
                         const Options& options) {
  SetCommonFieldVariables(descriptor, variables, options);
  (*variables)["type"] = ClassName(descriptor->message_type(), false);
  (*variables)["file_namespace"] =
      FileLevelNamespace(descriptor->file()->name());
  (*variables)["stream_writer"] =
      (*variables)["declared_type"] +
      (HasFastArraySerialization(descriptor->message_type()->file(), options)
           ? "MaybeToArray"
           : "");
  (*variables)["full_name"] = descriptor->full_name();

  const FieldDescriptor* key =
      descriptor->message_type()->FindFieldByName("key");
  const FieldDescriptor* val =
      descriptor->message_type()->FindFieldByName("value");
  (*variables)["key_cpp"] = PrimitiveTypeName(key->cpp_type());
  switch (val->cpp_type()) {
    case FieldDescriptor::CPPTYPE_MESSAGE:
      (*variables)["val_cpp"] = FieldMessageTypeName(val);
      (*variables)["wrapper"] = "EntryWrapper";
      break;
    case FieldDescriptor::CPPTYPE_ENUM:
      (*variables)["val_cpp"] = ClassName(val->enum_type(), true);
      (*variables)["wrapper"] = "EnumEntryWrapper";
      break;
    default:
      (*variables)["val_cpp"] = PrimitiveTypeName(val->cpp_type());
      (*variables)["wrapper"] = "EntryWrapper";
  }
  (*variables)["key_wire_type"] =
      "::google::protobuf::internal::WireFormatLite::TYPE_" +
      ToUpper(DeclaredTypeMethodName(key->type()));
  (*variables)["val_wire_type"] =
      "::google::protobuf::internal::WireFormatLite::TYPE_" +
      ToUpper(DeclaredTypeMethodName(val->type()));
  (*variables)["map_classname"] = ClassName(descriptor->message_type(), false);
  (*variables)["number"] = SimpleItoa(descriptor->number());
  (*variables)["tag"] = SimpleItoa(internal::WireFormat::MakeTag(descriptor));

  if (HasDescriptorMethods(descriptor->file(), options)) {
    (*variables)["lite"] = "";
  } else {
    (*variables)["lite"] = "Lite";
  }

  if (!IsProto3Field(descriptor) &&
      val->type() == FieldDescriptor::TYPE_ENUM) {
    const EnumValueDescriptor* default_value = val->default_value_enum();
    (*variables)["default_enum_value"] = Int32ToString(default_value->number());
  } else {
    (*variables)["default_enum_value"] = "0";
  }
}

MapFieldGenerator::MapFieldGenerator(const FieldDescriptor* descriptor,
                                     const Options& options)
    : FieldGenerator(options),
      descriptor_(descriptor),
      dependent_field_(IsFieldDependent(descriptor)) {
  SetMessageVariables(descriptor, &variables_, options);
}

MapFieldGenerator::~MapFieldGenerator() {}

void MapFieldGenerator::
GeneratePrivateMembers(io::Printer* printer) const {
  printer->Print("--TODO: MapFieldGenerator::GeneratePrivateMembers\n");
}

void MapFieldGenerator::
GenerateAccessorDeclarations(io::Printer* printer) const {
  printer->Print("--TODO: MapFieldGenerator::GenerateAccessorDeclarations\n");
}

void MapFieldGenerator::
GenerateInlineAccessorDefinitions(io::Printer* printer,
                                  bool is_inline) const {
  printer->Print("--TODO: MapFieldGenerator::GenerateInlineAccessorDefinitions\n");
}

void MapFieldGenerator::
GenerateClearingCode(io::Printer* printer) const {
  printer->Print("--TODO: MapFieldGenerator::GenerateClearingCode\n");
}

void MapFieldGenerator::
GenerateMergingCode(io::Printer* printer) const {
  printer->Print("--TODO: MapFieldGenerator::GenerateMergingCode\n");
}

void MapFieldGenerator::
GenerateSwappingCode(io::Printer* printer) const {
  printer->Print("--TODO: MapFieldGenerator::GenerateSwappingCode\n");
}

void MapFieldGenerator::
GenerateConstructorCode(io::Printer* printer) const {
  printer->Print("--TODO: MapFieldGenerator::GenerateConstructorCode\n");
}

void MapFieldGenerator::
GenerateCopyConstructorCode(io::Printer* printer) const {
  GenerateConstructorCode(printer);
  GenerateMergingCode(printer);
}

void MapFieldGenerator::
GenerateMergeFromCodedStream(io::Printer* printer) const {
  printer->Print("--TODO: MapFieldGenerator::GenerateMergeFromCodedStream\n");
}

static void GenerateSerializationLoop(io::Printer* printer,
                                      const std::map<string, string>& variables,
                                      bool supports_arenas,
                                      const string& utf8_check,
                                      const string& loop_header,
                                      const string& ptr,
                                      bool loop_via_iterators) {
  printer->Print("--TODO: GenerateSerializationLoop\n");
}

void MapFieldGenerator::
GenerateSerializeWithCachedSizes(io::Printer* printer) const {
  printer->Print("--TODO: MapFieldGenerator::GenerateSerializeWithCachedSizes\n");
}

void MapFieldGenerator::
GenerateSerializeWithCachedSizesToArray(io::Printer* printer) const {
  printer->Print("--TODO: MapFieldGenerator::GenerateSerializeWithCachedSizesToArray\n");
}

void MapFieldGenerator::GenerateSerializeWithCachedSizes(
    io::Printer* printer, const std::map<string, string>& variables) const {
  printer->Print("--TODO: MapFieldGenerator::GenerateSerializeWithCachedSizes\n");
}

void MapFieldGenerator::
GenerateByteSize(io::Printer* printer) const {
  printer->Print("--TODO: MapFieldGenerator::GenerateByteSize\n");
}

}  // namespace ada
}  // namespace compiler
}  // namespace protobuf
}  // namespace google
