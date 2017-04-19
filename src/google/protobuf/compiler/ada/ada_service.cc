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

#include <google/protobuf/compiler/ada/ada_service.h>
#include <google/protobuf/compiler/ada/ada_helpers.h>
#include <google/protobuf/io/printer.h>
#include <google/protobuf/stubs/strutil.h>

namespace google {
namespace protobuf {
namespace compiler {
namespace ada {

ServiceGenerator::ServiceGenerator(const ServiceDescriptor* descriptor,
                                   const Options& options)
  : descriptor_(descriptor) {
  vars_["classname"] = descriptor_->name();
  vars_["file_namespace"] = FileLevelNamespace(descriptor_->file()->name());
  vars_["full_name"] = descriptor_->full_name();
  if (options.dllexport_decl.empty()) {
    vars_["dllexport"] = "";
  } else {
    vars_["dllexport"] = options.dllexport_decl + " ";
  }
}

ServiceGenerator::~ServiceGenerator() {}

void ServiceGenerator::GenerateDeclarations(io::Printer* printer) {
  printer->Print("--TODO: ServiceGenerator::GenerateDeclarations\n");
  // Forward-declare the stub type.

  GenerateInterface(printer);
  GenerateStubDefinition(printer);
}

void ServiceGenerator::GenerateInterface(io::Printer* printer) {
  printer->Print("--TODO: ServiceGenerator::GenerateInterface\n");
}

void ServiceGenerator::GenerateStubDefinition(io::Printer* printer) {
  printer->Print("--TODO: ServiceGenerator::GenerateStubDefinition\n");
}

void ServiceGenerator::GenerateMethodSignatures(
    VirtualOrNon virtual_or_non, io::Printer* printer) {
  printer->Print("--TODO: ServiceGenerator::GenerateMethodSignatures\n");
}

// ===================================================================

void ServiceGenerator::GenerateDescriptorInitializer(
    io::Printer* printer, int index) {
  printer->Print("--TODO: ServiceGenerator::GenerateDescriptorInitializer\n");
}

// ===================================================================

void ServiceGenerator::GenerateImplementation(io::Printer* printer) {
  printer->Print("--TODO: ServiceGenerator::GenerateImplementation\n");
}

void ServiceGenerator::GenerateNotImplementedMethods(io::Printer* printer) {
  printer->Print("--TODO: ServiceGenerator::GenerateImplementation\n");
}

void ServiceGenerator::GenerateCallMethod(io::Printer* printer) {
  printer->Print("--TODO: ServiceGenerator::GenerateCallMethod\n");
}

void ServiceGenerator::GenerateGetPrototype(RequestOrResponse which,
                                            io::Printer* printer) {
  printer->Print("--TODO: ServiceGenerator::GenerateGetPrototype\n");
}

void ServiceGenerator::GenerateStubMethods(io::Printer* printer) {
  printer->Print("--TODO: ServiceGenerator::GenerateStubMethods\n");
}

}  // namespace ada
}  // namespace compiler
}  // namespace protobuf
}  // namespace google
