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

#include <google/protobuf/compiler/ada/ada_file.h>
#include <map>
#include <memory>
#ifndef _SHARED_PTR_H
#include <google/protobuf/stubs/shared_ptr.h>
#endif
#include <set>

#include <google/protobuf/compiler/ada/ada_enum.h>
#include <google/protobuf/compiler/ada/ada_service.h>
#include <google/protobuf/compiler/ada/ada_extension.h>
#include <google/protobuf/compiler/ada/ada_helpers.h>
#include <google/protobuf/compiler/ada/ada_message.h>
#include <google/protobuf/compiler/ada/ada_field.h>
#include <google/protobuf/io/printer.h>
#include <google/protobuf/descriptor.pb.h>
#include <google/protobuf/stubs/strutil.h>

namespace google {
namespace protobuf {
namespace compiler {
namespace ada {
namespace {
// The list of names that are defined as macros on some platforms. We need to
// #undef them for the generated code to compile.
const char* kMacroNames[] = {"major", "minor"};

bool IsMacroName(const string& name) {
  // Just do a linear search as the number of elements is very small.
  for (int i = 0; i < GOOGLE_ARRAYSIZE(kMacroNames); ++i) {
    if (name == kMacroNames[i]) return true;
  }
  return false;
}

void CollectMacroNames(const Descriptor* message, vector<string>* names) {
  for (int i = 0; i < message->field_count(); ++i) {
    const FieldDescriptor* field = message->field(i);
    if (IsMacroName(field->name())) {
      names->push_back(field->name());
    }
  }
  for (int i = 0; i < message->nested_type_count(); ++i) {
    CollectMacroNames(message->nested_type(i), names);
  }
}

void CollectMacroNames(const FileDescriptor* file, vector<string>* names) {
  for (int i = 0; i < file->message_type_count(); ++i) {
    CollectMacroNames(file->message_type(i), names);
  }
}


}  // namespace

// ===================================================================

FileGenerator::FileGenerator(const FileDescriptor* file, const Options& options)
    : file_(file),
      options_(options),
      message_generators_owner_(
          new google::protobuf::scoped_ptr<MessageGenerator>[ file->message_type_count() ]),
      enum_generators_owner_(
          new google::protobuf::scoped_ptr<EnumGenerator>[ file->enum_type_count() ]),
      service_generators_owner_(
          new google::protobuf::scoped_ptr<ServiceGenerator>[ file->service_count() ]),
      extension_generators_owner_(
          new google::protobuf::scoped_ptr<ExtensionGenerator>[ file->extension_count() ]) {

  for (int i = 0; i < file->message_type_count(); i++) {
    message_generators_owner_[i].reset(
        new MessageGenerator(file->message_type(i), options));
    message_generators_owner_[i]->Flatten(&message_generators_);
  }

  for (int i = 0; i < message_generators_.size(); i++) {
    message_generators_[i]->AddGenerators(&enum_generators_,
                                          &extension_generators_);
  }

  for (int i = 0; i < file->enum_type_count(); i++) {
    enum_generators_owner_[i].reset(
        new EnumGenerator(file->enum_type(i), options));
    enum_generators_.push_back(enum_generators_owner_[i].get());
  }

  for (int i = 0; i < file->service_count(); i++) {
    service_generators_owner_[i].reset(
        new ServiceGenerator(file->service(i), options));
    service_generators_.push_back(service_generators_owner_[i].get());
  }

  for (int i = 0; i < file->extension_count(); i++) {
    extension_generators_owner_[i].reset(
        new ExtensionGenerator(file->extension(i), options));
    extension_generators_.push_back(extension_generators_owner_[i].get());
  }

  package_parts_ = Split(file_->package(), ".", true);
}

FileGenerator::~FileGenerator() {}

void FileGenerator::GenerateMacroUndefs(io::Printer* printer) {
  printer->Print("--TODO: FileGenerator::GenerateMacroUndefs\n");
}

void FileGenerator::GenerateHeader(io::Printer* printer) {
  printer->Print("--TODO: FileGenerator::GenerateHeader\n");
}

void FileGenerator::GeneratePBHeader(io::Printer* printer,
                                     const string& info_path) {

  string filename_identifier = FilenameIdentifier(file_->name());
  GenerateTopHeaderGuard(printer, filename_identifier);

  GenerateLibraryIncludes(printer);

  GenerateDependencyIncludes(printer);

  GenerateMetadataPragma(printer, info_path);

  GenerateBottomHeaderGuard(printer, filename_identifier);
}

void FileGenerator::GenerateSource(io::Printer* printer) {
  printer->Print("--TODO: FileGenerator::GenerateSource\n");
}

class FileGenerator::ForwardDeclarations {
 public:
  ~ForwardDeclarations() {
    for (std::map<string, ForwardDeclarations*>::iterator
             it = namespaces_.begin(),
             end = namespaces_.end();
         it != end; ++it) {
      delete it->second;
    }
    namespaces_.clear();
  }

  ForwardDeclarations* AddOrGetNamespace(const string& ns_name) {
    ForwardDeclarations*& ns = namespaces_[ns_name];
    if (ns == NULL) {
      ns = new ForwardDeclarations;
    }
    return ns;
  }

  std::map<string, const Descriptor*>& classes() { return classes_; }
  std::map<string, const EnumDescriptor*>& enums() { return enums_; }

  void Print(io::Printer* printer, const Options& options) const {
    for (std::map<string, const EnumDescriptor *>::const_iterator
             it = enums_.begin(),
             end = enums_.end();
         it != end; ++it) {
      printer->Print("enum $enumname$ : int;\n", "enumname", it->first);
      printer->Annotate("enumname", it->second);
      printer->Print("bool $enumname$_IsValid(int value);\n", "enumname",
                     it->first);
    }
    for (std::map<string, const Descriptor*>::const_iterator
             it = classes_.begin(),
             end = classes_.end();
         it != end; ++it) {
      printer->Print("class $classname$;\n", "classname", it->first);
      printer->Annotate("classname", it->second);

      printer->Print(
          "class $classname$DefaultTypeInternal;\n"
          "$dllexport_decl$"
          "extern $classname$DefaultTypeInternal "
          "_$classname$_default_instance_;\n",  // NOLINT
          "dllexport_decl",
          options.dllexport_decl.empty() ? "" : options.dllexport_decl + " ",
          "classname",
          it->first);
    }
    for (std::map<string, ForwardDeclarations *>::const_iterator
             it = namespaces_.begin(),
             end = namespaces_.end();
         it != end; ++it) {
      printer->Print("namespace $nsname$ {\n",
                     "nsname", it->first);
      it->second->Print(printer, options);
      printer->Print("}  // namespace $nsname$\n",
                     "nsname", it->first);
    }
  }


 private:
  std::map<string, ForwardDeclarations*> namespaces_;
  std::map<string, const Descriptor*> classes_;
  std::map<string, const EnumDescriptor*> enums_;
};

void FileGenerator::GenerateBuildDescriptors(io::Printer* printer) {
  printer->Print("--TODO: FileGenerator::GenerateBuildDescriptors\n");
}

void FileGenerator::GenerateNamespaceOpeners(io::Printer* printer) {
  printer->Print("--TODO: FileGenerator::GenerateNamespaceOpeners\n");
}

void FileGenerator::GenerateNamespaceClosers(io::Printer* printer) {
  printer->Print("--TODO: FileGenerator::GenerateNamespaceClosers\n");
}

void FileGenerator::GenerateForwardDeclarations(io::Printer* printer) {
  printer->Print("--TODO: FileGenerator::GenerateForwardDeclarations\n");
}

void FileGenerator::FillForwardDeclarations(ForwardDeclarations* decls) {
  for (int i = 0; i < file_->public_dependency_count(); i++) {
    FileGenerator dependency(file_->public_dependency(i), options_);
    dependency.FillForwardDeclarations(decls);
  }
  for (int i = 0; i < package_parts_.size(); i++) {
    decls = decls->AddOrGetNamespace(package_parts_[i]);
  }
  // Generate enum definitions.
  for (int i = 0; i < enum_generators_.size(); i++) {
    enum_generators_[i]->FillForwardDeclaration(&decls->enums());
  }
  // Generate forward declarations of classes.
  for (int i = 0; i < message_generators_.size(); i++) {
    message_generators_[i]->FillMessageForwardDeclarations(
        &decls->classes());
  }
}

void FileGenerator::GenerateTopHeaderGuard(io::Printer* printer,
                                           const string& filename_identifier) {
  // Generate top of Ada specification
  printer->Print(
      "-- Generated by the protocol buffer compiler.  DO NOT EDIT!\n"
      "-- source: $filename$\n"
      "\n",
      "filename", file_->name());

}

void FileGenerator::GenerateBottomHeaderGuard(
    io::Printer* printer, const string& filename_identifier) {
  printer->Print("--TODO: FileGenerator::GenerateBottomHeaderGuard\n");
}

void FileGenerator::GenerateLibraryIncludes(io::Printer* printer) {

  printer->Print(
    "with Google.Protobuf.Common;\n"
    "\n");

  // Verify the protobuf library header version is compatible with the protoc
  // version before going any further.
  printer->Print(
    "pragma Compile_Time_Error\n"
    "  (Google.Protobuf.Common.Google_Protobuf_Version < $min_header_version$,\n"
    "   \"This file was generated by a newer version of protoc which is\" &\n"
    "   \" incompatible with your Protocol Buffer headers.  Please update\" & \n"
    "   \" your headers.\");\n",
    "min_header_version",
      SimpleItoa(protobuf::internal::kMinHeaderVersionForProtoc));
  printer->Print(
    "pragma Compile_Time_Error\n"
    "  ($protoc_version$ < Google.Common.Google_Protobuf_Min_Protoc_Version,\n"
    "   \"This file was generated by an older version of protoc which is\" &\n"
    "   \" incompatible with your Protocol Buffer headers.  Please\" &\n"
    "   \" regenerate this file with a newer version of protoc.\");\n"
    "\n",
    "protoc_version", SimpleItoa(GOOGLE_PROTOBUF_VERSION));

  // Ok, its now safe to with other files
  printer->Print(
      "with Google.Protobuf.IO.Coded_Stream;\n"
      "with Google.Protobuf.Arena;\n"
      "with Google.Protobuf.Arena_String;\n"
      "with Google.Protobuf.Generated_Message_Table_Driven;\n"
      "with Google.Protobuf.Generated_Message_Util;\n");

  if (HasDescriptorMethods(file_, options_)) {
    printer->Print("with Google.Protobuf.Metadata;\n");
  } else {
    printer->Print("with Google.Protobuf.Metadata_Lite;\n");
  }

  if (!message_generators_.empty()) {
    if (HasDescriptorMethods(file_, options_)) {
      printer->Print("with Google.Protobuf.Message;\n");
    } else {
      printer->Print("with Google.Protobuf.Message_Lite;\n");
    }
  }

  printer->Print(
    "with Google.Protobuf.Repeated_Field;\n"
    "with Google.Protobuf.Extension_Set;\n");

  if (HasMapFields(file_)) {
    printer->Print("with Google.Protobuf.Map;\n");
    if (HasDescriptorMethods(file_, options_)) {
      printer->Print("with Google.Protobuf.Map.Field_Inl;\n");
    } else {
      printer->Print("with Google.Protobuf.Map.Field_Lite;\n");
    }
  }

  if (HasEnumDefinitions(file_)) {
    if (HasDescriptorMethods(file_, options_)) {
      printer->Print("with Google.Protobuf.Generated_Enum_Reflection;\n");
    } else {
      printer->Print("with Google.Protobuf.Generated_Enum_Util;\n");
    }
  }

  if (HasGenericServices(file_, options_)) {
    printer->Print("with Google.Protobuf.Service;\n");
  }

  if (UseUnknownFieldSet(file_, options_) && !message_generators_.empty()) {
    printer->Print("with Google.Protobuf.Unknown_Field_Set;\n");
  }

  if (IsAnyMessage(file_)) {
    printer->Print("with Google.Protobuf.Any;\n");
  }

}

void FileGenerator::GenerateMetadataPragma(io::Printer* printer,
                                           const string& info_path) {
  printer->Print("--TODO: FileGenerator::GenerateMetadataPragma\n");
}

void FileGenerator::GenerateDependencyIncludes(io::Printer* printer) {
  printer->Print("--TODO: FileGenerator::GenerateDependencyIncludes\n");
}

void FileGenerator::GenerateGlobalStateFunctionDeclarations(
    io::Printer* printer) {
  printer->Print("--TODO: FileGenerator::GenerateGlobalStateFunctionDeclarations\n");
}

void FileGenerator::GenerateMessageDefinitions(io::Printer* printer) {
  printer->Print("--TODO: FileGenerator::GenerateMessageDefinitions\n");
}

void FileGenerator::GenerateEnumDefinitions(io::Printer* printer) {
  printer->Print("--TODO: FileGenerator::GenerateEnumDefinitions\n");
}

void FileGenerator::GenerateServiceDefinitions(io::Printer* printer) {
  printer->Print("--TODO: FileGenerator::GenerateServiceDefinitions\n");
}

void FileGenerator::GenerateExtensionIdentifiers(io::Printer* printer) {
  printer->Print("--TODO: FileGenerator::GenerateExtensionIdentifiers\n");
}

void FileGenerator::GenerateInlineFunctionDefinitions(io::Printer* printer) {
  printer->Print("--TODO: FileGenerator::GenerateInlineFunctionDefinitions\n");
}

void FileGenerator::GenerateProto2NamespaceEnumSpecializations(
    io::Printer* printer) {
  printer->Print("--TODO: FileGenerator::GenerateProto2NamespaceEnumSpecializations\n");
}

}  // namespace ada
}  // namespace compiler
}  // namespace protobuf
}  // namespace google
