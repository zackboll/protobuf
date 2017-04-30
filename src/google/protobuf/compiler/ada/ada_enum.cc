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

#include <map>

#include <google/protobuf/compiler/ada/ada_enum.h>
#include <google/protobuf/compiler/ada/ada_helpers.h>
#include <google/protobuf/io/printer.h>
#include <google/protobuf/stubs/strutil.h>

namespace google {
namespace protobuf {
namespace compiler {
namespace ada {

namespace {
// The GOOGLE_ARRAYSIZE constant is the max enum value plus 1. If the max enum
// value is ::google::protobuf::kint32max, GOOGLE_ARRAYSIZE will overflow. In
// such cases we should omit the generation of the GOOGLE_ARRAYSIZE constant.
bool ShouldGenerateArraySize(const EnumDescriptor* descriptor) {
  int32 max_value = descriptor->value(0)->number();
  for (int i = 0; i < descriptor->value_count(); i++) {
    if (descriptor->value(i)->number() > max_value) {
      max_value = descriptor->value(i)->number();
    }
  }
  return max_value != ::google::protobuf::kint32max;
}
}  // namespace

EnumGenerator::EnumGenerator(const EnumDescriptor* descriptor,
                             const Options& options)
  : descriptor_(descriptor),
    classname_(ClassName(descriptor, false)),
    options_(options),
    generate_array_size_(ShouldGenerateArraySize(descriptor)) {
}

EnumGenerator::~EnumGenerator() {}

void EnumGenerator::FillForwardDeclaration(
    std::map<string, const EnumDescriptor*>* enum_names) {
  if (!options_.proto_h) {
    return;
  }
  (*enum_names)[classname_] = descriptor_;
}

void EnumGenerator::GenerateDefinition(io::Printer* printer) {
  std::map<string, string> vars;
  vars["classname"] = classname_;
  vars["short_name"] = descriptor_->name();
  vars["enumbase"] = classname_ + (options_.proto_h ? " : int" : "");

  printer->Print(vars, "type $enumbase$ is (\n");
  printer->Annotate("enumbase", descriptor_);
  printer->Indent();

  const EnumValueDescriptor* min_value = descriptor_->value(0);
  const EnumValueDescriptor* max_value = descriptor_->value(0);

  // Generate type definition for Ada enumeration type
  for (int i = 0; i < descriptor_->value_count(); i++) {
    vars["name"] = EnumValueName(descriptor_->value(i));
    vars["prefix"] = (descriptor_->containing_type() == NULL) ?
      "" : classname_ + "_";
    vars["deprecation"] = descriptor_->value(i)->options().deprecated() ?
       " PROTOBUF_DEPRECATED" : "";

    if (i > 0) printer->Print(",\n");
    printer->Print(vars, "$prefix$$name$$deprecation$");

    if (descriptor_->value(i)->number() < min_value->number()) {
      min_value = descriptor_->value(i);
    }
    if (descriptor_->value(i)->number() > max_value->number()) {
      max_value = descriptor_->value(i);
    }
  }

  printer->Print(");");
  printer->Outdent();
  printer->Print("\n");

  // Now in second loop, generate representation clause for Ada enumeration type
  printer->Print(vars, "for $enumbase$ use (\n");
  printer->Annotate("enumbase", descriptor_);
  printer->Indent();

  for (int i = 0; i < descriptor_->value_count(); i++) {
    vars["name"] = EnumValueName(descriptor_->value(i));
    vars["prefix"] = (descriptor_->containing_type() == NULL) ?
      "" : classname_ + "_";
    vars["number"] = Int32ToString(descriptor_->value(i)->number());
    vars["deprecation"] = descriptor_->value(i)->options().deprecated() ?
       " PROTOBUF_DEPRECATED" : "";

    if (i > 0) printer->Print(",\n");
    printer->Print(vars, "$prefix$$name$$deprecation$ = $number$");
  }

  printer->Print(");");
  printer->Outdent();
  printer->Print("\n");

  // Specify the size of enumeration to be 4 bytes, verify that this is
  // correct and consistent with C++ standard
  printer->Print(vars, "for $enumbase$'size use 32;");
  printer->Annotate("enumbase", descriptor_);
  printer->Print("\n");
}

void EnumGenerator::
GenerateGetEnumDescriptorSpecializations(io::Printer* printer) {
  printer->Print("--TODO: EnumGenerator::GenerateGetEnumDescriptorSpecializations\n");
}

void EnumGenerator::GenerateSymbolImports(io::Printer* printer) {
  printer->Print("--TODO: EnumGenerator::GenerateSymbolImports\n");
}

void EnumGenerator::GenerateDescriptorInitializer(io::Printer* printer) {
  printer->Print("--TODO: EnumGenerator::GenerateDescriptorInitializer\n");
}

void EnumGenerator::GenerateMethods(io::Printer* printer) {
  printer->Print("--TODO: EnumGenerator::GenerateMethods\n");
}

}  // namespace ada
}  // namespace compiler
}  // namespace protobuf
}  // namespace google
