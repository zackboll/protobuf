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

#include <google/protobuf/compiler/ada/ada_primitive_field.h>
#include <google/protobuf/compiler/ada/ada_helpers.h>
#include <google/protobuf/io/printer.h>
#include <google/protobuf/wire_format.h>
#include <google/protobuf/stubs/strutil.h>

// TODO: This file was copy/pasted from C++ implementation as placeholder
// and will need work for Ada implementation

namespace google {
namespace protobuf {
namespace compiler {
namespace ada {

using internal::WireFormatLite;

namespace {

// For encodings with fixed sizes, returns that size in bytes.  Otherwise
// returns -1.
int FixedSize(FieldDescriptor::Type type) {
  switch (type) {
    case FieldDescriptor::TYPE_INT32   : return -1;
    case FieldDescriptor::TYPE_INT64   : return -1;
    case FieldDescriptor::TYPE_UINT32  : return -1;
    case FieldDescriptor::TYPE_UINT64  : return -1;
    case FieldDescriptor::TYPE_SINT32  : return -1;
    case FieldDescriptor::TYPE_SINT64  : return -1;
    case FieldDescriptor::TYPE_FIXED32 : return WireFormatLite::kFixed32Size;
    case FieldDescriptor::TYPE_FIXED64 : return WireFormatLite::kFixed64Size;
    case FieldDescriptor::TYPE_SFIXED32: return WireFormatLite::kSFixed32Size;
    case FieldDescriptor::TYPE_SFIXED64: return WireFormatLite::kSFixed64Size;
    case FieldDescriptor::TYPE_FLOAT   : return WireFormatLite::kFloatSize;
    case FieldDescriptor::TYPE_DOUBLE  : return WireFormatLite::kDoubleSize;

    case FieldDescriptor::TYPE_BOOL    : return WireFormatLite::kBoolSize;
    case FieldDescriptor::TYPE_ENUM    : return -1;

    case FieldDescriptor::TYPE_STRING  : return -1;
    case FieldDescriptor::TYPE_BYTES   : return -1;
    case FieldDescriptor::TYPE_GROUP   : return -1;
    case FieldDescriptor::TYPE_MESSAGE : return -1;

    // No default because we want the compiler to complain if any new
    // types are added.
  }
  GOOGLE_LOG(FATAL) << "Can't get here.";
  return -1;
}

void SetPrimitiveVariables(const FieldDescriptor* descriptor,
                           std::map<string, string>* variables,
                           const Options& options) {
  SetCommonFieldVariables(descriptor, variables, options);
  (*variables)["type"] = PrimitiveTypeName(descriptor->cpp_type());
  (*variables)["default"] = DefaultValue(descriptor);
  (*variables)["tag"] = SimpleItoa(internal::WireFormat::MakeTag(descriptor));
  int fixed_size = FixedSize(descriptor->type());
  if (fixed_size != -1) {
    (*variables)["fixed_size"] = SimpleItoa(fixed_size);
  }
  (*variables)["wire_format_field_type"] =
      "::google::protobuf::internal::WireFormatLite::" + FieldDescriptorProto_Type_Name(
          static_cast<FieldDescriptorProto_Type>(descriptor->type()));
  (*variables)["full_name"] = descriptor->full_name();
}

}  // namespace

// ===================================================================

PrimitiveFieldGenerator::PrimitiveFieldGenerator(
    const FieldDescriptor* descriptor, const Options& options)
    : FieldGenerator(options), descriptor_(descriptor) {
  SetPrimitiveVariables(descriptor, &variables_, options);
}

PrimitiveFieldGenerator::~PrimitiveFieldGenerator() {}

void PrimitiveFieldGenerator::
GeneratePrivateMembers(io::Printer* printer) const {
  printer->Print("--TODO: PrimitiveFieldGenerator::GeneratePrivateMembers");
}

void PrimitiveFieldGenerator::
GenerateAccessorDeclarations(io::Printer* printer) const {
  printer->Print("--TODO: PrimitiveFieldGenerator::GenerateAccessorDeclarations");
}

void PrimitiveFieldGenerator::
GenerateInlineAccessorDefinitions(io::Printer* printer, bool is_inline) const {
  printer->Print("--TODO: PrimitiveFieldGenerator::GenerateInlineAccessorDefinitions");
}

void PrimitiveFieldGenerator::
GenerateClearingCode(io::Printer* printer) const {
  printer->Print("--TODO: PrimitiveFieldGenerator::GenerateClearingCode");
}

void PrimitiveFieldGenerator::
GenerateMergingCode(io::Printer* printer) const {
  printer->Print("--TODO: PrimitiveFieldGenerator::GenerateMergingCode");
}

void PrimitiveFieldGenerator::
GenerateSwappingCode(io::Printer* printer) const {
  printer->Print("--TODO: PrimitiveFieldGenerator::GenerateSwappingCode");
}

void PrimitiveFieldGenerator::
GenerateConstructorCode(io::Printer* printer) const {
  printer->Print("--TODO: PrimitiveFieldGenerator::GenerateConstructorCode");
}

void PrimitiveFieldGenerator::
GenerateCopyConstructorCode(io::Printer* printer) const {
  printer->Print("--TODO: PrimitiveFieldGenerator::GenerateCopyConstructorCode");
}

void PrimitiveFieldGenerator::
GenerateMergeFromCodedStream(io::Printer* printer) const {
  printer->Print("--TODO: PrimitiveFieldGenerator::GenerateMergeFromCodedStream");
}

void PrimitiveFieldGenerator::
GenerateSerializeWithCachedSizes(io::Printer* printer) const {
  printer->Print("--TODO: PrimitiveFieldGenerator::GenerateSerializeWithCachedSizes");
}

void PrimitiveFieldGenerator::
GenerateSerializeWithCachedSizesToArray(io::Printer* printer) const {
  printer->Print("--TODO: PrimitiveFieldGenerator::GenerateSerializeWithCachedSizesToArray");
}

void PrimitiveFieldGenerator::
GenerateByteSize(io::Printer* printer) const {
  printer->Print("--TODO: PrimitiveFieldGenerator::GenerateByteSize");
}

// ===================================================================

PrimitiveOneofFieldGenerator::
PrimitiveOneofFieldGenerator(const FieldDescriptor* descriptor,
                             const Options& options)
  : PrimitiveFieldGenerator(descriptor, options) {
  SetCommonOneofFieldVariables(descriptor, &variables_);
}

PrimitiveOneofFieldGenerator::~PrimitiveOneofFieldGenerator() {}

void PrimitiveOneofFieldGenerator::
GenerateInlineAccessorDefinitions(io::Printer* printer, bool is_inline) const {
  printer->Print("--TODO: PrimitiveOneofFieldGenerator::GenerateInlineAccessorDefinitions");
}

void PrimitiveOneofFieldGenerator::
GenerateClearingCode(io::Printer* printer) const {
  printer->Print("--TODO: PrimitiveOneofFieldGenerator::GenerateClearingCode");
}

void PrimitiveOneofFieldGenerator::
GenerateSwappingCode(io::Printer* printer) const {
  // Don't print any swapping code. Swapping the union will swap this field.
}

void PrimitiveOneofFieldGenerator::
GenerateConstructorCode(io::Printer* printer) const {
  printer->Print("--TODO: PrimitiveOneofFieldGenerator::GenerateConstructorCode");
}

void PrimitiveOneofFieldGenerator::
GenerateMergeFromCodedStream(io::Printer* printer) const {
  printer->Print("--TODO: PrimitiveOneofFieldGenerator::GenerateMergeFromCodedStream");
}

// ===================================================================

RepeatedPrimitiveFieldGenerator::RepeatedPrimitiveFieldGenerator(
    const FieldDescriptor* descriptor, const Options& options)
    : FieldGenerator(options), descriptor_(descriptor) {
  SetPrimitiveVariables(descriptor, &variables_, options);

  if (descriptor->is_packed()) {
    variables_["packed_reader"] = "ReadPackedPrimitive";
    variables_["repeated_reader"] = "ReadRepeatedPrimitiveNoInline";
  } else {
    variables_["packed_reader"] = "ReadPackedPrimitiveNoInline";
    variables_["repeated_reader"] = "ReadRepeatedPrimitive";
  }
}

RepeatedPrimitiveFieldGenerator::~RepeatedPrimitiveFieldGenerator() {}

void RepeatedPrimitiveFieldGenerator::
GeneratePrivateMembers(io::Printer* printer) const {
  printer->Print("--TODO: RepeatedPrimitiveFieldGenerator::GeneratePrivateMembers");
}

void RepeatedPrimitiveFieldGenerator::
GenerateAccessorDeclarations(io::Printer* printer) const {
  printer->Print("--TODO: RepeatedPrimitiveFieldGenerator::GenerateAccessorDeclarations");
}

void RepeatedPrimitiveFieldGenerator::
GenerateInlineAccessorDefinitions(io::Printer* printer, bool is_inline) const {
  printer->Print("--TODO: RepeatedPrimitiveFieldGenerator::GenerateInlineAccessorDefinitions");
}

void RepeatedPrimitiveFieldGenerator::
GenerateClearingCode(io::Printer* printer) const {
  printer->Print("--TODO: RepeatedPrimitiveFieldGenerator::GenerateClearingCode");
}

void RepeatedPrimitiveFieldGenerator::
GenerateMergingCode(io::Printer* printer) const {
  printer->Print("--TODO: RepeatedPrimitiveFieldGenerator::GenerateMergingCode");
}

void RepeatedPrimitiveFieldGenerator::
GenerateSwappingCode(io::Printer* printer) const {
  printer->Print("--TODO: RepeatedPrimitiveFieldGenerator::GenerateSwappingCode");
}

void RepeatedPrimitiveFieldGenerator::
GenerateConstructorCode(io::Printer* printer) const {
  // Not needed for repeated fields.
}

void RepeatedPrimitiveFieldGenerator::
GenerateCopyConstructorCode(io::Printer* printer) const {
  printer->Print("--TODO: RepeatedPrimitiveFieldGenerator::GenerateCopyConstructorCode");
}

void RepeatedPrimitiveFieldGenerator::
GenerateMergeFromCodedStream(io::Printer* printer) const {
  printer->Print("--TODO: RepeatedPrimitiveFieldGenerator::GenerateMergeFromCodedStream");
}

void RepeatedPrimitiveFieldGenerator::
GenerateMergeFromCodedStreamWithPacking(io::Printer* printer) const {
  printer->Print("--TODO: RepeatedPrimitiveFieldGenerator::GenerateMergeFromCodedStreamWithPacking");
}

void RepeatedPrimitiveFieldGenerator::
GenerateSerializeWithCachedSizes(io::Printer* printer) const {
  printer->Print("--TODO: RepeatedPrimitiveFieldGenerator::GenerateSerializeWithCachedSizes");
}

void RepeatedPrimitiveFieldGenerator::
GenerateSerializeWithCachedSizesToArray(io::Printer* printer) const {
  printer->Print("--TODO: RepeatedPrimitiveFieldGenerator::GenerateSerializeWithCachedSizesToArray");
}

void RepeatedPrimitiveFieldGenerator::
GenerateByteSize(io::Printer* printer) const {
  printer->Print("--TODO: RepeatedPrimitiveFieldGenerator::GenerateByteSize");
}

}  // namespace ada
}  // namespace compiler
}  // namespace protobuf
}  // namespace google
