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

#include <google/protobuf/compiler/ada/ada_enum_field.h>
#include <google/protobuf/compiler/ada/ada_helpers.h>
#include <google/protobuf/io/printer.h>
#include <google/protobuf/wire_format.h>
#include <google/protobuf/stubs/strutil.h>

namespace google {
namespace protobuf {
namespace compiler {
namespace ada {

namespace {

void SetEnumVariables(const FieldDescriptor* descriptor,
                      std::map<string, string>* variables,
                      const Options& options) {
  SetCommonFieldVariables(descriptor, variables, options);
  const EnumValueDescriptor* default_value = descriptor->default_value_enum();
  (*variables)["type"] = ClassName(descriptor->enum_type(), true);
  (*variables)["default"] = Int32ToString(default_value->number());
  (*variables)["full_name"] = descriptor->full_name();
}

}  // namespace

// ===================================================================

EnumFieldGenerator::EnumFieldGenerator(const FieldDescriptor* descriptor,
                                       const Options& options)
    : FieldGenerator(options), descriptor_(descriptor) {
  SetEnumVariables(descriptor, &variables_, options);
}

EnumFieldGenerator::~EnumFieldGenerator() {}

void EnumFieldGenerator::
GeneratePrivateMembers(io::Printer* printer) const {
  printer->Print("--TODO: EnumFieldGenerator::GeneratePrivateMembers\n");
}

void EnumFieldGenerator::
GenerateAccessorDeclarations(io::Printer* printer) const {
  printer->Print("--TODO: EnumFieldGenerator::GenerateAccessorDeclarations\n");
}

void EnumFieldGenerator::
GenerateInlineAccessorDefinitions(io::Printer* printer,
                                  bool is_inline) const {
  printer->Print("--TODO: EnumFieldGenerator::GenerateInlineAccessorDefinitions\n");
}

void EnumFieldGenerator::
GenerateClearingCode(io::Printer* printer) const {
  printer->Print("--TODO: EnumFieldGenerator::GenerateClearingCode\n");
}

void EnumFieldGenerator::
GenerateMergingCode(io::Printer* printer) const {
  printer->Print("--TODO: EnumFieldGenerator::GenerateMergingCode\n");
}

void EnumFieldGenerator::
GenerateSwappingCode(io::Printer* printer) const {
  printer->Print("--TODO: EnumFieldGenerator::GenerateSwappingCode\n");
}

void EnumFieldGenerator::
GenerateConstructorCode(io::Printer* printer) const {
  printer->Print("--TODO: EnumFieldGenerator::GenerateConstructorCode\n");
}

void EnumFieldGenerator::
GenerateCopyConstructorCode(io::Printer* printer) const {
  printer->Print("--TODO: EnumFieldGenerator::GenerateCopyConstructorCode\n");
}

void EnumFieldGenerator::
GenerateMergeFromCodedStream(io::Printer* printer) const {
  printer->Print("--TODO: EnumFieldGenerator::GenerateMergeFromCodedStream\n");
}

void EnumFieldGenerator::
GenerateSerializeWithCachedSizes(io::Printer* printer) const {
  printer->Print("--TODO: EnumFieldGenerator::GenerateSerializeWithCachedSizes\n");
}

void EnumFieldGenerator::
GenerateSerializeWithCachedSizesToArray(io::Printer* printer) const {
  printer->Print("--TODO: EnumFieldGenerator::GenerateSerializeWithCachedSizesToArray\n");
}

void EnumFieldGenerator::
GenerateByteSize(io::Printer* printer) const {
  printer->Print("--TODO: EnumFieldGenerator::GenerateByteSize\n");
}

// ===================================================================

EnumOneofFieldGenerator::
EnumOneofFieldGenerator(const FieldDescriptor* descriptor,
                        const Options& options)
  : EnumFieldGenerator(descriptor, options) {
  SetCommonOneofFieldVariables(descriptor, &variables_);
}

EnumOneofFieldGenerator::~EnumOneofFieldGenerator() {}

void EnumOneofFieldGenerator::
GenerateInlineAccessorDefinitions(io::Printer* printer,
                                  bool is_inline) const {
  printer->Print("--TODO: EnumOneofFieldGenerator::GenerateInlineAccessorDefinitions\n");
}

void EnumOneofFieldGenerator::
GenerateClearingCode(io::Printer* printer) const {
  printer->Print("--TODO: EnumOneofFieldGenerator::GenerateClearingCode\n");
}

void EnumOneofFieldGenerator::
GenerateSwappingCode(io::Printer* printer) const {
  // Don't print any swapping code. Swapping the union will swap this field.
}

void EnumOneofFieldGenerator::
GenerateConstructorCode(io::Printer* printer) const {
  printer->Print("--TODO: EnumOneofFieldGenerator::GenerateConstructorCode\n");
}

// ===================================================================

RepeatedEnumFieldGenerator::RepeatedEnumFieldGenerator(
    const FieldDescriptor* descriptor, const Options& options)
    : FieldGenerator(options), descriptor_(descriptor) {
  SetEnumVariables(descriptor, &variables_, options);
}

RepeatedEnumFieldGenerator::~RepeatedEnumFieldGenerator() {}

void RepeatedEnumFieldGenerator::
GeneratePrivateMembers(io::Printer* printer) const {
  printer->Print("--TODO: RepeatedEnumFieldGenerator::GeneratePrivateMembers\n");
}

void RepeatedEnumFieldGenerator::
GenerateAccessorDeclarations(io::Printer* printer) const {
  printer->Print("--TODO: RepeatedEnumFieldGenerator::GenerateAccessorDeclarations\n");
}

void RepeatedEnumFieldGenerator::
GenerateInlineAccessorDefinitions(io::Printer* printer,
                                  bool is_inline) const {
  printer->Print("--TODO: RepeatedEnumFieldGenerator::GenerateInlineAccessorDefinitions\n");
}

void RepeatedEnumFieldGenerator::
GenerateClearingCode(io::Printer* printer) const {
  printer->Print("--TODO: RepeatedEnumFieldGenerator::GenerateClearingCode\n");
}

void RepeatedEnumFieldGenerator::
GenerateMergingCode(io::Printer* printer) const {
  printer->Print("--TODO: RepeatedEnumFieldGenerator::GenerateMergingCode\n");
}

void RepeatedEnumFieldGenerator::
GenerateSwappingCode(io::Printer* printer) const {
  printer->Print("--TODO: RepeatedEnumFieldGenerator::GenerateSwappingCode\n");
}

void RepeatedEnumFieldGenerator::
GenerateConstructorCode(io::Printer* printer) const {
  // Not needed for repeated fields.
}

void RepeatedEnumFieldGenerator::
GenerateMergeFromCodedStream(io::Printer* printer) const {
  printer->Print("--TODO: RepeatedEnumFieldGenerator::GenerateMergeFromCodedStream\n");
}

void RepeatedEnumFieldGenerator::
GenerateMergeFromCodedStreamWithPacking(io::Printer* printer) const {
  printer->Print("--TODO: RepeatedEnumFieldGenerator::GenerateMergeFromCodedStreamWithPacking\n");
}

void RepeatedEnumFieldGenerator::
GenerateSerializeWithCachedSizes(io::Printer* printer) const {
  printer->Print("--TODO: RepeatedEnumFieldGenerator::GenerateSerializeWithCachedSizes\n");
}

void RepeatedEnumFieldGenerator::
GenerateSerializeWithCachedSizesToArray(io::Printer* printer) const {
  printer->Print("--TODO: RepeatedEnumFieldGenerator::GenerateSerializeWithCachedSizesToArray\n");
}

void RepeatedEnumFieldGenerator::
GenerateByteSize(io::Printer* printer) const {
  printer->Print("--TODO: RepeatedEnumFieldGenerator::GenerateByteSize\n");
}

}  // namespace ada
}  // namespace compiler
}  // namespace protobuf
}  // namespace google
