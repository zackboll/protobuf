pragma Ada_2005;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with Interfaces.C.Extensions;
with Interfaces.C.Strings;
with Interfaces_CPP.Strings;
with System;
with google.protobuf.binding.once_h;

limited with google.protobuf.binding.descriptor_h;
limited with google.protobuf.binding.enum_descriptor_h;
limited with google.protobuf.binding.field_descriptor_h;

package google.protobuf.binding.file_descriptor_h is

    package Class_FileDescriptor is

   subtype Syntax is unsigned;
   SYNTAX_UNKNOWN : constant Syntax := 0;
   SYNTAX_PROTO2 : constant Syntax := 2;
   SYNTAX_PROTO3 : constant Syntax := 3;

      type FileDescriptor is limited record
         name_u : Interfaces_CPP.Strings.CPP_String_External;--access constant google.protobuf.binding.cpp_6_2_1_bits_stringfwd_h.Class_string.string;  -- ../../../src/google/protobuf/descriptor.h:1360
         package_u : Interfaces_CPP.Strings.CPP_String_External;--access constant google.protobuf.binding.cpp_6_2_1_bits_stringfwd_h.Class_string.string;  -- ../../../src/google/protobuf/descriptor.h:1361
         pool_u : System.Address;  -- ../../../src/google/protobuf/descriptor.h:1362
         dependency_count_u : aliased int;  -- ../../../src/google/protobuf/descriptor.h:1363
         dependencies_u : System.Address;  -- ../../../src/google/protobuf/descriptor.h:1364
         dependencies_names_u : System.Address;  -- ../../../src/google/protobuf/descriptor.h:1365
         dependencies_once_u : access google.protobuf.binding.once_h.Class_GoogleOnceDynamic.GoogleOnceDynamic;  -- ../../../src/google/protobuf/descriptor.h:1366
         public_dependency_count_u : aliased int;  -- ../../../src/google/protobuf/descriptor.h:1369
         public_dependencies_u : access int;  -- ../../../src/google/protobuf/descriptor.h:1370
         weak_dependency_count_u : aliased int;  -- ../../../src/google/protobuf/descriptor.h:1371
         weak_dependencies_u : access int;  -- ../../../src/google/protobuf/descriptor.h:1372
         message_type_count_u : aliased int;  -- ../../../src/google/protobuf/descriptor.h:1373
         message_types_u : access google.protobuf.binding.descriptor_h.Class_Descriptor.Descriptor;  -- ../../../src/google/protobuf/descriptor.h:1374
         enum_type_count_u : aliased int;  -- ../../../src/google/protobuf/descriptor.h:1375
         enum_types_u : access google.protobuf.binding.enum_descriptor_h.Class_EnumDescriptor.EnumDescriptor;  -- ../../../src/google/protobuf/descriptor.h:1376
         service_count_u : aliased int;  -- ../../../src/google/protobuf/descriptor.h:1377
         services_u : access google.protobuf.binding.descriptor_h.Class_ServiceDescriptor.ServiceDescriptor;  -- ../../../src/google/protobuf/descriptor.h:1378
         extension_count_u : aliased int;  -- ../../../src/google/protobuf/descriptor.h:1379
         syntax_u : aliased Syntax;  -- ../../../src/google/protobuf/descriptor.h:1380
         is_placeholder_u : aliased Extensions.bool;  -- ../../../src/google/protobuf/descriptor.h:1381
         extensions_u : access google.protobuf.binding.field_descriptor_h.Class_FieldDescriptor.FieldDescriptor;  -- ../../../src/google/protobuf/descriptor.h:1382
         options_u : System.Address;  -- ../../../src/google/protobuf/descriptor.h:1383
         tables_u : System.Address;  -- ../../../src/google/protobuf/descriptor.h:1385
         source_code_info_u : System.Address;  -- ../../../src/google/protobuf/descriptor.h:1386
         finished_building_u : aliased Extensions.bool;  -- ../../../src/google/protobuf/descriptor.h:1391
      end record;
      pragma Import (CPP, FileDescriptor);

      function name (this : access constant FileDescriptor) return Interfaces_CPP.Strings.CPP_String_External;--access constant google.protobuf.binding.cpp_6_2_1_bits_stringfwd_h.Class_string.string;  -- ../../../src/google/protobuf/descriptor.h:1867
      pragma Import (CPP, name, "_ZNK6google8protobuf14FileDescriptor4nameB5cxx11Ev");

      function c_package (this : access constant FileDescriptor) return Interfaces_CPP.Strings.CPP_String_External;--access constant google.protobuf.binding.cpp_6_2_1_bits_stringfwd_h.Class_string.string;  -- ../../../src/google/protobuf/descriptor.h:1868
      pragma Import (CPP, c_package, "_ZNK6google8protobuf14FileDescriptor7packageB5cxx11Ev");

      function pool (this : access constant FileDescriptor) return System.Address;  -- ../../../src/google/protobuf/descriptor.h:1869
      pragma Import (CPP, pool, "_ZNK6google8protobuf14FileDescriptor4poolEv");

      function dependency_count (this : access constant FileDescriptor) return int;  -- ../../../src/google/protobuf/descriptor.h:1870
      pragma Import (CPP, dependency_count, "_ZNK6google8protobuf14FileDescriptor16dependency_countEv");

      function dependency (this : access constant FileDescriptor; index : int) return access constant FileDescriptor;  -- ../../../src/google/protobuf/descriptor.h:1243
      pragma Import (CPP, dependency, "_ZNK6google8protobuf14FileDescriptor10dependencyEi");

      function public_dependency_count (this : access constant FileDescriptor) return int;  -- ../../../src/google/protobuf/descriptor.h:1871
      pragma Import (CPP, public_dependency_count, "_ZNK6google8protobuf14FileDescriptor23public_dependency_countEv");

      function public_dependency (this : access constant FileDescriptor; index : int) return access constant FileDescriptor;  -- ../../../src/google/protobuf/descriptor.h:2007
      pragma Import (CPP, public_dependency, "_ZNK6google8protobuf14FileDescriptor17public_dependencyEi");

      function weak_dependency_count (this : access constant FileDescriptor) return int;  -- ../../../src/google/protobuf/descriptor.h:1872
      pragma Import (CPP, weak_dependency_count, "_ZNK6google8protobuf14FileDescriptor21weak_dependency_countEv");

      function weak_dependency (this : access constant FileDescriptor; index : int) return access constant FileDescriptor;  -- ../../../src/google/protobuf/descriptor.h:2012
      pragma Import (CPP, weak_dependency, "_ZNK6google8protobuf14FileDescriptor15weak_dependencyEi");

      function message_type_count (this : access constant FileDescriptor) return int;  -- ../../../src/google/protobuf/descriptor.h:1873
      pragma Import (CPP, message_type_count, "_ZNK6google8protobuf14FileDescriptor18message_type_countEv");

      function message_type (this : access constant FileDescriptor; index : int) return access constant google.protobuf.binding.descriptor_h.Class_Descriptor.Descriptor;  -- ../../../src/google/protobuf/descriptor.h:1880
      pragma Import (CPP, message_type, "_ZNK6google8protobuf14FileDescriptor12message_typeEi");

      function enum_type_count (this : access constant FileDescriptor) return int;  -- ../../../src/google/protobuf/descriptor.h:1874
      pragma Import (CPP, enum_type_count, "_ZNK6google8protobuf14FileDescriptor15enum_type_countEv");

      function enum_type (this : access constant FileDescriptor; index : int) return access constant google.protobuf.binding.enum_descriptor_h.Class_EnumDescriptor.EnumDescriptor;  -- ../../../src/google/protobuf/descriptor.h:1881
      pragma Import (CPP, enum_type, "_ZNK6google8protobuf14FileDescriptor9enum_typeEi");

      function service_count (this : access constant FileDescriptor) return int;  -- ../../../src/google/protobuf/descriptor.h:1875
      pragma Import (CPP, service_count, "_ZNK6google8protobuf14FileDescriptor13service_countEv");

      function service (this : access constant FileDescriptor; index : int) return access constant google.protobuf.binding.descriptor_h.Class_ServiceDescriptor.ServiceDescriptor;  -- ../../../src/google/protobuf/descriptor.h:1882
      pragma Import (CPP, service, "_ZNK6google8protobuf14FileDescriptor7serviceEi");

      function extension_count (this : access constant FileDescriptor) return int;  -- ../../../src/google/protobuf/descriptor.h:1876
      pragma Import (CPP, extension_count, "_ZNK6google8protobuf14FileDescriptor15extension_countEv");

      function extension (this : access constant FileDescriptor; index : int) return access constant google.protobuf.binding.field_descriptor_h.Class_FieldDescriptor.FieldDescriptor;  -- ../../../src/google/protobuf/descriptor.h:1884
      pragma Import (CPP, extension, "_ZNK6google8protobuf14FileDescriptor9extensionEi");

      function options (this : access constant FileDescriptor) return System.Address;  -- ../../../src/google/protobuf/descriptor.h:1877
      pragma Import (CPP, options, "_ZNK6google8protobuf14FileDescriptor7optionsEv");

      function get_syntax (this : access constant FileDescriptor) return Syntax;  -- ../../../src/google/protobuf/descriptor.h:2017
      pragma Import (CPP, get_syntax, "_ZNK6google8protobuf14FileDescriptor6syntaxEv");

      function FindMessageTypeByName (this : Interfaces_CPP.Strings.CPP_String_External) return access constant google.protobuf.binding.descriptor_h.Class_Descriptor.Descriptor;  -- ../../../src/google/protobuf/descriptor.h:1305
      pragma Import (CPP, FindMessageTypeByName, "_ZNK6google8protobuf14FileDescriptor21FindMessageTypeByNameERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE");

      function FindEnumTypeByName (this : access constant FileDescriptor; name : Interfaces_CPP.Strings.CPP_String_External) return access constant google.protobuf.binding.enum_descriptor_h.Class_EnumDescriptor.EnumDescriptor;  -- ../../../src/google/protobuf/descriptor.h:1307
      pragma Import (CPP, FindEnumTypeByName, "_ZNK6google8protobuf14FileDescriptor18FindEnumTypeByNameERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE");

      function FindEnumValueByName (this : access constant FileDescriptor; name : Interfaces_CPP.Strings.CPP_String_External) return access constant google.protobuf.binding.descriptor_h.Class_EnumValueDescriptor.EnumValueDescriptor;  -- ../../../src/google/protobuf/descriptor.h:1310
      pragma Import (CPP, FindEnumValueByName, "_ZNK6google8protobuf14FileDescriptor19FindEnumValueByNameERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE");

      function FindServiceByName (this : access constant FileDescriptor; name : Interfaces_CPP.Strings.CPP_String_External) return access constant google.protobuf.binding.descriptor_h.Class_ServiceDescriptor.ServiceDescriptor;  -- ../../../src/google/protobuf/descriptor.h:1312
      pragma Import (CPP, FindServiceByName, "_ZNK6google8protobuf14FileDescriptor17FindServiceByNameERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE");

      function FindExtensionByName (this : access constant FileDescriptor; name : Interfaces_CPP.Strings.CPP_String_External) return access constant google.protobuf.binding.field_descriptor_h.Class_FieldDescriptor.FieldDescriptor;  -- ../../../src/google/protobuf/descriptor.h:1314
      pragma Import (CPP, FindExtensionByName, "_ZNK6google8protobuf14FileDescriptor19FindExtensionByNameERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE");

      function FindExtensionByLowercaseName (this : access constant FileDescriptor; name : Interfaces_CPP.Strings.CPP_String_External) return access constant google.protobuf.binding.field_descriptor_h.Class_FieldDescriptor.FieldDescriptor;  -- ../../../src/google/protobuf/descriptor.h:1317
      pragma Import (CPP, FindExtensionByLowercaseName, "_ZNK6google8protobuf14FileDescriptor28FindExtensionByLowercaseNameERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE");

      function FindExtensionByCamelcaseName (this : access constant FileDescriptor; name : Interfaces_CPP.Strings.CPP_String_External) return access constant google.protobuf.binding.field_descriptor_h.Class_FieldDescriptor.FieldDescriptor;  -- ../../../src/google/protobuf/descriptor.h:1320
      pragma Import (CPP, FindExtensionByCamelcaseName, "_ZNK6google8protobuf14FileDescriptor28FindExtensionByCamelcaseNameERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE");

      procedure CopyTo (this : access constant FileDescriptor; proto : System.Address);  -- ../../../src/google/protobuf/descriptor.h:1326
      pragma Import (CPP, CopyTo, "_ZNK6google8protobuf14FileDescriptor6CopyToEPNS0_19FileDescriptorProtoE");

      procedure CopySourceCodeInfoTo (this : access constant FileDescriptor; proto : System.Address);  -- ../../../src/google/protobuf/descriptor.h:1329
      pragma Import (CPP, CopySourceCodeInfoTo, "_ZNK6google8protobuf14FileDescriptor20CopySourceCodeInfoToEPNS0_19FileDescriptorProtoE");

      procedure CopyJsonNameTo (this : access constant FileDescriptor; proto : System.Address);  -- ../../../src/google/protobuf/descriptor.h:1332
      pragma Import (CPP, CopyJsonNameTo, "_ZNK6google8protobuf14FileDescriptor14CopyJsonNameToEPNS0_19FileDescriptorProtoE");

      function DebugString (this : access constant FileDescriptor) return Interfaces_CPP.Strings.CPP_String_External;  -- ../../../src/google/protobuf/descriptor.h:1335
      pragma Import (CPP, DebugString, "_ZNK6google8protobuf14FileDescriptor11DebugStringB5cxx11Ev");

      function DebugStringWithOptions (this : access constant FileDescriptor; options : access constant google.protobuf.binding.descriptor_h.Class_DebugStringOptions.DebugStringOptions) return Interfaces_CPP.Strings.CPP_String_External;  -- ../../../src/google/protobuf/descriptor.h:1338
      pragma Import (CPP, DebugStringWithOptions, "_ZNK6google8protobuf14FileDescriptor22DebugStringWithOptionsB5cxx11ERKNS0_18DebugStringOptionsE");

      function is_placeholder (this : access constant FileDescriptor) return Extensions.bool;  -- ../../../src/google/protobuf/descriptor.h:1878
      pragma Import (CPP, is_placeholder, "_ZNK6google8protobuf14FileDescriptor14is_placeholderEv");

      function GetSourceLocation (this : access constant FileDescriptor; out_location : access google.protobuf.binding.descriptor_h.Class_SourceLocation.SourceLocation) return Extensions.bool;  -- ../../../src/google/protobuf/descriptor.h:1347
      pragma Import (CPP, GetSourceLocation, "_ZNK6google8protobuf14FileDescriptor17GetSourceLocationEPNS0_14SourceLocationE");

      function GetSourceLocation2
        (this : access constant FileDescriptor;
         path : System.Address;
         out_location : access google.protobuf.binding.descriptor_h.Class_SourceLocation.SourceLocation) return Extensions.bool;  -- ../../../src/google/protobuf/descriptor.h:1354
      pragma Import (CPP, GetSourceLocation2, "_ZNK6google8protobuf14FileDescriptor17GetSourceLocationERKSt6vectorIiSaIiEEPNS0_14SourceLocationE");

      procedure InternalDependenciesOnceInit (this : access constant FileDescriptor);  -- ../../../src/google/protobuf/descriptor.h:1368
      pragma Import (CPP, InternalDependenciesOnceInit, "_ZNK6google8protobuf14FileDescriptor28InternalDependenciesOnceInitEv");

      function New_FileDescriptor return FileDescriptor;  -- ../../../src/google/protobuf/descriptor.h:1397
      pragma CPP_Constructor (New_FileDescriptor, "_ZN6google8protobuf14FileDescriptorC1Ev");

      procedure operator_as (this : access FileDescriptor; arg2 : access constant FileDescriptor);  -- ../../../src/google/protobuf/descriptor.h:1408
      pragma Import (CPP, operator_as, "_ZN6google8protobuf14FileDescriptoraSERKS1_");

      package Static is
         function SyntaxName (the_syntax : Syntax) return Interfaces.C.Strings.chars_ptr;  -- ../../../src/google/protobuf/descriptor.h:1302
         pragma Import (CPP, SyntaxName, "_ZN6google8protobuf14FileDescriptor10SyntaxNameENS1_6SyntaxE");

         procedure DependenciesOnceInit (to_init : access constant FileDescriptor);  -- ../../../src/google/protobuf/descriptor.h:1367
         pragma Import (CPP, DependenciesOnceInit, "_ZN6google8protobuf14FileDescriptor20DependenciesOnceInitEPKS1_");
      end;

      function SyntaxName (the_syntax : Syntax) return Interfaces.C.Strings.chars_ptr renames Static.SyntaxName;

      procedure DependenciesOnceInit (to_init : access constant FileDescriptor) renames Static.DependenciesOnceInit;
   end;
   use Class_FileDescriptor;

end google.protobuf.binding.file_descriptor_h;
