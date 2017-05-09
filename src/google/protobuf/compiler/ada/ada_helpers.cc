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

#include <limits>
#include <map>
#include <vector>
#include <google/protobuf/stubs/hash.h>

#include <google/protobuf/compiler/ada/ada_helpers.h>
#include <google/protobuf/io/printer.h>
#include <google/protobuf/stubs/logging.h>
#include <google/protobuf/stubs/common.h>
#include <google/protobuf/stubs/strutil.h>
#include <google/protobuf/stubs/substitute.h>

namespace google {
namespace protobuf {
namespace compiler {
namespace ada {

namespace {

// Ada 2012 keyword list
const char* const kKeywordList[] = {
  "abort", "abs", "abstract", "accept", "access", "aliased", "all", "and",
  "array", "at", "begin", "body", "case", "constant", "declare", "delay",
  "delta", "digits", "do", "else", "elsif", "end", "entry", "exception",
  "exit", "for", "function", "generic", "goto", "if", "in", "interface",
  "is", "limited", "loop", "mod", "new", "not", "null", "of", "or",
  "others", "out", "overriding", "package", "pragma", "private", "procedure",
  "protected", "raise", "range", "record", "rem", "renames", "requeue",
  "return", "reverse", "select", "separate", "some", "subtype", "synchronized",
  "tagged", "task", "terminate", "then", "type", "until", "use", "when",
  "while", "with", "xor"
};

hash_set<string> MakeKeyWordsMap() {
  hash_set<string> result;
  for (int i = 0; i < GOOGLE_ARRAYSIZE(kKeywordList); i++) {
    result.insert(kKeywordList[i]);
  }
  return result;
}

hash_set<string> kKeywords = MakeKeyWordsMap();

// Returns whether the provided descriptor has an extension. This includes its
// nested types.
bool HasExtension(const Descriptor* descriptor) {
  if (descriptor->extension_count() > 0) {
    return true;
  }
  for (int i = 0; i < descriptor->nested_type_count(); ++i) {
    if (HasExtension(descriptor->nested_type(i))) {
      return true;
    }
  }
  return false;
}

}  // namespace

string UnderscoresToCamelCase(const string& input, bool cap_next_letter) {
  return google::protobuf::compiler::cpp::
    UnderscoresToCamelCase (input, cap_next_letter);
}

const char kThickSeparator[] =
  "-- ===================================================================\n";
const char kThinSeparator[] =
  "-- -------------------------------------------------------------------\n";

string ClassName(const Descriptor* descriptor, bool qualified) {
  // Find "outer", the descriptor of the top-level message in which
  // "descriptor" is embedded
  const Descriptor* outer = descriptor;
  while (outer->containing_type() != NULL) outer = outer->containing_type();

  const string& outer_name = outer->full_name();
  string inner_name = descriptor->full_name().substr(outer_name.size());

  // TODO: this will probably need to be fixed, figure out if qualified
  // boolean will be used, if not, remove parameter
  return outer_name + inner_name;
}

string ClassName(const EnumDescriptor* enum_descriptor, bool qualified) {
  // TODO: this will probably need to be fixed, figure out if qualified
  // boolean will be used, if not, remove parameter
  if (enum_descriptor->containing_type() == NULL) {
    if (qualified) {
      return enum_descriptor->full_name();
    } else {
      return enum_descriptor->name();
    }
  } else {
    string result = ClassName(enum_descriptor->containing_type(), qualified);
    result += "_";
    result += enum_descriptor->name();
    return result;
  }
}

string FieldName(const FieldDescriptor* field) {
  string result = field->name();
  LowerString(&result);
  if (kKeywords.count(result) > 0) {
    result.append("_");
  }
  return result;
}

string EnumValueName(const EnumValueDescriptor* enum_value) {
  string result = enum_value->name();
  if (kKeywords.count(result) > 0) {
    result.append("_");
  }
  return result;
}

string FieldConstantName(const FieldDescriptor *field) {
  return google::protobuf::compiler::cpp::FieldConstantName (field);
}

bool IsFieldDependent(const FieldDescriptor* field) {
  return google::protobuf::compiler::cpp::IsFieldDependent (field);
}

string DependentTypeName(const FieldDescriptor* field) {
  return google::protobuf::compiler::cpp::DependentTypeName (field);
}

string FieldMessageTypeName(const FieldDescriptor* field) {
  // Note:  The Google-internal version of Protocol Buffers uses this function
  //   as a hook point for hacks to support legacy code.
  return ClassName(field->message_type(), true);
}

string StripProto(const string& filename) {
  return google::protobuf::compiler::cpp::StripProto (filename);
}

const char* PrimitiveTypeName(FieldDescriptor::CppType type) {
  switch (type) {
    case FieldDescriptor::CPPTYPE_INT32  : return "Interfaces.Integer_32";
    case FieldDescriptor::CPPTYPE_INT64  : return "Interfaces.Integer_64";
    case FieldDescriptor::CPPTYPE_UINT32 : return "Interfaces.Unsigned_32";
    case FieldDescriptor::CPPTYPE_UINT64 : return "Interfaces.Unsigned_64";
    case FieldDescriptor::CPPTYPE_DOUBLE : return "Interfaces.IEEE_Float_64";
    case FieldDescriptor::CPPTYPE_FLOAT  : return "Interfaces.IEEE_Float_32";
    case FieldDescriptor::CPPTYPE_BOOL   : return "Boolean";
    case FieldDescriptor::CPPTYPE_ENUM   : return "Integer";
    case FieldDescriptor::CPPTYPE_STRING : return "String";
    case FieldDescriptor::CPPTYPE_MESSAGE: return NULL;
  }

  GOOGLE_LOG(FATAL) << "Can't get here.";
  return NULL;
}

const char* DeclaredTypeMethodName(FieldDescriptor::Type type) {
  return google::protobuf::compiler::cpp::DeclaredTypeMethodName (type);
}

// TODO: this will likely need updated for Ada compatible version, for now
// directly call C++ implementation
string Int32ToString(int number) {
  return google::protobuf::compiler::cpp::Int32ToString (number);
}

// TODO: this will likely need updated for Ada compatible version, for now
// directly call C++ implementation
string Int64ToString(int64 number) {
  return google::protobuf::compiler::cpp::Int64ToString (number);
}

// TODO: this code will definitely need an Ada implementation, for now,
// call C++ code as place holder
string DefaultValue(const FieldDescriptor* field) {
  return google::protobuf::compiler::cpp::DefaultValue (field);
}

// Convert a file name into a valid identifier.
string FilenameIdentifier(const string& filename) {
  return google::protobuf::compiler::cpp::FilenameIdentifier (filename);
}

string FileLevelNamespace(const string& filename) {
  return google::protobuf::compiler::cpp::FileLevelNamespace (filename);
}

// Return the qualified Ada name for a file level symbol.
string QualifiedFileLevelSymbol(const string& package, const string& name) {
  if (package.empty()) {
    return name;
  }
  return StrCat (package, ".", name);
}

// Escaped function name to eliminate naming conflict.
string SafeFunctionName(const Descriptor* descriptor,
                        const FieldDescriptor* field,
                        const string& prefix) {
  // Do not use FieldName() since it will escape keywords.
  string name = field->name();
  LowerString(&name);
  string function_name = prefix + name;
  if (descriptor->FindFieldByName(function_name)) {
    // Single underscore will also make it conflicting with the private data
    // member. We use double underscore to escape function names.
    function_name.append("__");
  } else if (kKeywords.count(name) > 0) {
    // If the field name is a keyword, we append the underscore back to keep it
    // consistent with other function names.
    function_name.append("_");
  }
  return function_name;
}

bool StaticInitializersForced(const FileDescriptor* file,
                              const Options& options) {
  if (HasDescriptorMethods(file, options) || file->extension_count() > 0) {
    return true;
  }
  for (int i = 0; i < file->message_type_count(); ++i) {
    if (HasExtension(file->message_type(i))) {
      return true;
    }
  }
  return false;
}


static bool HasMapFields(const Descriptor* descriptor) {
  for (int i = 0; i < descriptor->field_count(); ++i) {
    if (descriptor->field(i)->is_map()) {
      return true;
    }
  }
  for (int i = 0; i < descriptor->nested_type_count(); ++i) {
    if (HasMapFields(descriptor->nested_type(i))) return true;
  }
  return false;
}

bool HasMapFields(const FileDescriptor* file) {
  for (int i = 0; i < file->message_type_count(); ++i) {
    if (HasMapFields(file->message_type(i))) return true;
  }
  return false;
}

static bool HasEnumDefinitions(const Descriptor* message_type) {
  if (message_type->enum_type_count() > 0) return true;
  for (int i = 0; i < message_type->nested_type_count(); ++i) {
    if (HasEnumDefinitions(message_type->nested_type(i))) return true;
  }
  return false;
}

bool HasEnumDefinitions(const FileDescriptor* file) {
  if (file->enum_type_count() > 0) return true;
  for (int i = 0; i < file->message_type_count(); ++i) {
    if (HasEnumDefinitions(file->message_type(i))) return true;
  }
  return false;
}

bool IsStringOrMessage(const FieldDescriptor* field) {
  switch (field->cpp_type()) {
    case FieldDescriptor::CPPTYPE_INT32:
    case FieldDescriptor::CPPTYPE_INT64:
    case FieldDescriptor::CPPTYPE_UINT32:
    case FieldDescriptor::CPPTYPE_UINT64:
    case FieldDescriptor::CPPTYPE_DOUBLE:
    case FieldDescriptor::CPPTYPE_FLOAT:
    case FieldDescriptor::CPPTYPE_BOOL:
    case FieldDescriptor::CPPTYPE_ENUM:
      return false;
    case FieldDescriptor::CPPTYPE_STRING:
    case FieldDescriptor::CPPTYPE_MESSAGE:
      return true;
  }

  GOOGLE_LOG(FATAL) << "Can't get here.";
  return false;
}

FieldOptions::CType EffectiveStringCType(const FieldDescriptor* field) {
  GOOGLE_DCHECK(field->cpp_type() == FieldDescriptor::CPPTYPE_STRING);
  // Open-source protobuf release only supports STRING ctype.
  return FieldOptions::STRING;

}

bool IsAnyMessage(const FileDescriptor* descriptor) {
  return google::protobuf::compiler::cpp::IsAnyMessage (descriptor);
}

bool IsAnyMessage(const Descriptor* descriptor) {
  return google::protobuf::compiler::cpp::IsAnyMessage (descriptor);
}

bool IsWellKnownMessage(const FileDescriptor* descriptor) {
  return google::protobuf::compiler::cpp::IsWellKnownMessage (descriptor);
}

enum Utf8CheckMode {
  STRICT = 0,  // Parsing will fail if non UTF-8 data is in string fields.
  VERIFY = 1,  // Only log an error but parsing will succeed.
  NONE = 2,  // No UTF-8 check.
};

// Which level of UTF-8 enforcemant is placed on this file.
static Utf8CheckMode GetUtf8CheckMode(const FieldDescriptor* field,
                                      const Options& options) {
  if (field->file()->syntax() == FileDescriptor::SYNTAX_PROTO3) {
    return STRICT;
  } else if (GetOptimizeFor(field->file(), options) !=
             FileOptions::LITE_RUNTIME) {
    return VERIFY;
  } else {
    return NONE;
  }
}

// TODO: This will generate malformed Ada code and will need to be fixed
static void GenerateUtf8CheckCode(const FieldDescriptor* field,
                                  const Options& options, bool for_parse,
                                  const std::map<string, string>& variables,
                                  const char* parameters,
                                  const char* strict_function,
                                  const char* verify_function,
                                  io::Printer* printer) {
  switch (GetUtf8CheckMode(field, options)) {
    case STRICT: {
      if (for_parse) {
        printer->Print("DO_(");
      }
      printer->Print(
          "::google::protobuf::internal::WireFormatLite::$function$(\n",
          "function", strict_function);
      printer->Indent();
      printer->Print(variables, parameters);
      if (for_parse) {
        printer->Print("::google::protobuf::internal::WireFormatLite::PARSE,\n");
      } else {
        printer->Print("::google::protobuf::internal::WireFormatLite::SERIALIZE,\n");
      }
      printer->Print("\"$full_name$\")", "full_name", field->full_name());
      if (for_parse) {
        printer->Print(")");
      }
      printer->Print(";\n");
      printer->Outdent();
      break;
    }
    case VERIFY: {
      printer->Print(
          "::google::protobuf::internal::WireFormat::$function$(\n",
          "function", verify_function);
      printer->Indent();
      printer->Print(variables, parameters);
      if (for_parse) {
        printer->Print("::google::protobuf::internal::WireFormat::PARSE,\n");
      } else {
        printer->Print("::google::protobuf::internal::WireFormat::SERIALIZE,\n");
      }
      printer->Print("\"$full_name$\");\n", "full_name", field->full_name());
      printer->Outdent();
      break;
    }
    case NONE:
      break;
  }
}

void GenerateUtf8CheckCodeForString(const FieldDescriptor* field,
                                    const Options& options, bool for_parse,
                                    const std::map<string, string>& variables,
                                    const char* parameters,
                                    io::Printer* printer) {
  GenerateUtf8CheckCode(field, options, for_parse, variables, parameters,
                        "VerifyUtf8String", "VerifyUTF8StringNamedField",
                        printer);
}

void GenerateUtf8CheckCodeForCord(const FieldDescriptor* field,
                                  const Options& options, bool for_parse,
                                  const std::map<string, string>& variables,
                                  const char* parameters,
                                  io::Printer* printer) {
  GenerateUtf8CheckCode(field, options, for_parse, variables, parameters,
                        "VerifyUtf8Cord", "VerifyUTF8CordNamedField", printer);
}

string AdaPackageName (const FileDescriptor *file) {
  string basename = StripProto(file->name());
  string package = file->package();
  if (package != "") {
    basename = package + "." + basename;
  }
  return basename;
}

}  // namespace ada
}  // namespace compiler
}  // namespace protobuf
}  // namespace google
