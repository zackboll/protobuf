pragma Ada_2005;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with Interfaces.C.Extensions;
with Interfaces.C.Strings;
with Interfaces_CPP.Strings;
with System;

with google.protobuf.binding.once_h;
with google.protobuf.binding.port_h;

limited with google.protobuf.binding.descriptor_h;
limited with google.protobuf.binding.enum_descriptor_h;
limited with google.protobuf.binding.file_descriptor_h;

package google.protobuf.binding.field_descriptor_h is

   type anon_122 (discr : unsigned := 0) is record
      case discr is
         when 0 =>
            default_value_int32_u : aliased google.protobuf.binding.port_h.int32;  -- ../../../src/google/protobuf/descriptor.h:768
         when 1 =>
            default_value_int64_u : aliased google.protobuf.binding.port_h.int64;  -- ../../../src/google/protobuf/descriptor.h:769
         when 2 =>
            default_value_uint32_u : aliased google.protobuf.binding.port_h.uint32;  -- ../../../src/google/protobuf/descriptor.h:770
         when 3 =>
            default_value_uint64_u : aliased google.protobuf.binding.port_h.uint64;  -- ../../../src/google/protobuf/descriptor.h:771
         when 4 =>
            default_value_float_u : aliased float;  -- ../../../src/google/protobuf/descriptor.h:772
         when 5 =>
            default_value_double_u : aliased double;  -- ../../../src/google/protobuf/descriptor.h:773
         when 6 =>
            default_value_bool_u : aliased Extensions.bool;  -- ../../../src/google/protobuf/descriptor.h:774
         when 7 =>
            default_value_enum_u : access constant google.protobuf.binding.descriptor_h.Class_EnumValueDescriptor.EnumValueDescriptor;  -- ../../../src/google/protobuf/descriptor.h:776
         when others =>
            default_value_string_u : Interfaces_CPP.Strings.CPP_String_External;  -- ../../../src/google/protobuf/descriptor.h:777
      end case;
   end record;
   pragma Convention (C_Pass_By_Copy, anon_122);
  pragma Unchecked_Union (anon_122);

   subtype c_Type is unsigned;
   TYPE_DOUBLE : constant c_Type := 1;
   TYPE_FLOAT : constant c_Type := 2;
   TYPE_INT64 : constant c_Type := 3;
   TYPE_UINT64 : constant c_Type := 4;
   TYPE_INT32 : constant c_Type := 5;
   TYPE_FIXED64 : constant c_Type := 6;
   TYPE_FIXED32 : constant c_Type := 7;
   TYPE_BOOL : constant c_Type := 8;
   TYPE_STRING : constant c_Type := 9;
   TYPE_GROUP : constant c_Type := 10;
   TYPE_MESSAGE : constant c_Type := 11;
   TYPE_BYTES : constant c_Type := 12;
   TYPE_UINT32 : constant c_Type := 13;
   TYPE_ENUM : constant c_Type := 14;
   TYPE_SFIXED32 : constant c_Type := 15;
   TYPE_SFIXED64 : constant c_Type := 16;
   TYPE_SINT32 : constant c_Type := 17;
   TYPE_SINT64 : constant c_Type := 18;
   MAX_TYPE : constant c_Type := 18;

   subtype CppType is unsigned;
   CPPTYPE_INT32 : constant CppType := 1;
   CPPTYPE_INT64 : constant CppType := 2;
   CPPTYPE_UINT32 : constant CppType := 3;
   CPPTYPE_UINT64 : constant CppType := 4;
   CPPTYPE_DOUBLE : constant CppType := 5;
   CPPTYPE_FLOAT : constant CppType := 6;
   CPPTYPE_BOOL : constant CppType := 7;
   CPPTYPE_ENUM : constant CppType := 8;
   CPPTYPE_STRING : constant CppType := 9;
   CPPTYPE_MESSAGE : constant CppType := 10;
   MAX_CPPTYPE : constant CppType := 10;

   subtype Label is unsigned;
   LABEL_OPTIONAL : constant Label := 1;
   LABEL_REQUIRED : constant Label := 2;
   LABEL_REPEATED : constant Label := 3;
   MAX_LABEL : constant Label := 3;

   type PrintLabelFlag is
     (PRINT_LABEL,
      OMIT_LABEL);
  pragma Convention (C, PrintLabelFlag);

   type FieldDescriptor_kTypeToCppTypeMap_array is array (0 .. 18) of aliased CppType;
   type FieldDescriptor_kTypeToName_array is array (0 .. 18) of Interfaces.C.Strings.chars_ptr;
   type FieldDescriptor_kCppTypeToName_array is array (0 .. 10) of Interfaces.C.Strings.chars_ptr;
   type FieldDescriptor_kLabelToName_array is array (0 .. 3) of Interfaces.C.Strings.chars_ptr;

   package Class_FieldDescriptor is
      type FieldDescriptor is limited record
         name_u : Interfaces_CPP.Strings.CPP_String_External;  -- ../../../src/google/protobuf/descriptor.h:735
         full_name_u : Interfaces_CPP.Strings.CPP_String_External;  -- ../../../src/google/protobuf/descriptor.h:736
         lowercase_name_u : Interfaces_CPP.Strings.CPP_String_External;  -- ../../../src/google/protobuf/descriptor.h:737
         camelcase_name_u : Interfaces_CPP.Strings.CPP_String_External;  -- ../../../src/google/protobuf/descriptor.h:738
         has_json_name_u : aliased Extensions.bool;  -- ../../../src/google/protobuf/descriptor.h:741
         json_name_u : Interfaces_CPP.Strings.CPP_String_External;  -- ../../../src/google/protobuf/descriptor.h:744
         file_u : access constant google.protobuf.binding.file_descriptor_h.Class_FileDescriptor.FileDescriptor;  -- ../../../src/google/protobuf/descriptor.h:745
         number_u : aliased int;  -- ../../../src/google/protobuf/descriptor.h:746
         type_once_u : access google.protobuf.binding.once_h.Class_GoogleOnceDynamic.GoogleOnceDynamic;  -- ../../../src/google/protobuf/descriptor.h:747
         type_u : aliased c_Type;  -- ../../../src/google/protobuf/descriptor.h:750
         label_u : aliased Label;  -- ../../../src/google/protobuf/descriptor.h:751
         is_extension_u : aliased Extensions.bool;  -- ../../../src/google/protobuf/descriptor.h:752
         index_in_oneof_u : aliased int;  -- ../../../src/google/protobuf/descriptor.h:753
         containing_type_u : access constant google.protobuf.binding.descriptor_h.Class_Descriptor.Descriptor;  -- ../../../src/google/protobuf/descriptor.h:754
         containing_oneof_u : access constant google.protobuf.binding.descriptor_h.Class_OneofDescriptor.OneofDescriptor;  -- ../../../src/google/protobuf/descriptor.h:755
         extension_scope_u : access constant google.protobuf.binding.descriptor_h.Class_Descriptor.Descriptor;  -- ../../../src/google/protobuf/descriptor.h:756
         message_type_u : access constant google.protobuf.binding.descriptor_h.Class_Descriptor.Descriptor;  -- ../../../src/google/protobuf/descriptor.h:757
         enum_type_u : access constant google.protobuf.binding.enum_descriptor_h.Class_EnumDescriptor.EnumDescriptor;  -- ../../../src/google/protobuf/descriptor.h:758
         options_u : System.Address;  -- ../../../src/google/protobuf/descriptor.h:759
         type_name_u : Interfaces_CPP.Strings.CPP_String_External;  -- ../../../src/google/protobuf/descriptor.h:760
         default_value_enum_name_u : Interfaces_CPP.Strings.CPP_String_External;  -- ../../../src/google/protobuf/descriptor.h:761
         has_default_value_u : aliased Extensions.bool;  -- ../../../src/google/protobuf/descriptor.h:766
         field_23 : aliased anon_122;
      end record;
      pragma Import (CPP, FieldDescriptor);

      function name (this : access constant FieldDescriptor) return Interfaces_CPP.Strings.CPP_String_External;  -- ../../../src/google/protobuf/descriptor.h:1804
      pragma Import (CPP, name, "_ZNK6google8protobuf15FieldDescriptor4nameB5cxx11Ev");

      function full_name (this : access constant FieldDescriptor) return Interfaces_CPP.Strings.CPP_String_External;  -- ../../../src/google/protobuf/descriptor.h:1805
      pragma Import (CPP, full_name, "_ZNK6google8protobuf15FieldDescriptor9full_nameB5cxx11Ev");

      function json_name (this : access constant FieldDescriptor) return Interfaces_CPP.Strings.CPP_String_External;  -- ../../../src/google/protobuf/descriptor.h:1806
      pragma Import (CPP, json_name, "_ZNK6google8protobuf15FieldDescriptor9json_nameB5cxx11Ev");

      function file (this : access constant FieldDescriptor) return access constant google.protobuf.binding.file_descriptor_h.Class_FileDescriptor.FileDescriptor;  -- ../../../src/google/protobuf/descriptor.h:1809
      pragma Import (CPP, file, "_ZNK6google8protobuf15FieldDescriptor4fileEv");

      function is_extension (this : access constant FieldDescriptor) return Extensions.bool;  -- ../../../src/google/protobuf/descriptor.h:1811
      pragma Import (CPP, is_extension, "_ZNK6google8protobuf15FieldDescriptor12is_extensionEv");

      function number (this : access constant FieldDescriptor) return int;  -- ../../../src/google/protobuf/descriptor.h:1810
      pragma Import (CPP, number, "_ZNK6google8protobuf15FieldDescriptor6numberEv");

      function lowercase_name (this : access constant FieldDescriptor) return Interfaces_CPP.Strings.CPP_String_External;  -- ../../../src/google/protobuf/descriptor.h:1807
      pragma Import (CPP, lowercase_name, "_ZNK6google8protobuf15FieldDescriptor14lowercase_nameB5cxx11Ev");

      function camelcase_name (this : access constant FieldDescriptor) return Interfaces_CPP.Strings.CPP_String_External;  -- ../../../src/google/protobuf/descriptor.h:1808
      pragma Import (CPP, camelcase_name, "_ZNK6google8protobuf15FieldDescriptor14camelcase_nameB5cxx11Ev");

      function c_type2 (this : access constant FieldDescriptor) return c_Type;  -- ../../../src/google/protobuf/descriptor.h:591
      pragma Import (CPP, c_type2, "_ZNK6google8protobuf15FieldDescriptor4typeEv");

      function type_name (this : access constant FieldDescriptor) return Interfaces.C.Strings.chars_ptr;  -- ../../../src/google/protobuf/descriptor.h:1976
      pragma Import (CPP, type_name, "_ZNK6google8protobuf15FieldDescriptor9type_nameEv");

      function cpp_type (this : access constant FieldDescriptor) return CppType;  -- ../../../src/google/protobuf/descriptor.h:1980
      pragma Import (CPP, cpp_type, "_ZNK6google8protobuf15FieldDescriptor8cpp_typeEv");

      function cpp_type_name (this : access constant FieldDescriptor) return Interfaces.C.Strings.chars_ptr;  -- ../../../src/google/protobuf/descriptor.h:1984
      pragma Import (CPP, cpp_type_name, "_ZNK6google8protobuf15FieldDescriptor13cpp_type_nameEv");

      function label (this : access constant FieldDescriptor) return Label;  -- ../../../src/google/protobuf/descriptor.h:1812
      pragma Import (CPP, label, "_ZNK6google8protobuf15FieldDescriptor5labelEv");

      function is_required (this : access constant FieldDescriptor) return Extensions.bool;  -- ../../../src/google/protobuf/descriptor.h:1916
      pragma Import (CPP, is_required, "_ZNK6google8protobuf15FieldDescriptor11is_requiredEv");

      function is_optional (this : access constant FieldDescriptor) return Extensions.bool;  -- ../../../src/google/protobuf/descriptor.h:1920
      pragma Import (CPP, is_optional, "_ZNK6google8protobuf15FieldDescriptor11is_optionalEv");

      function is_repeated (this : access constant FieldDescriptor) return Extensions.bool;  -- ../../../src/google/protobuf/descriptor.h:1924
      pragma Import (CPP, is_repeated, "_ZNK6google8protobuf15FieldDescriptor11is_repeatedEv");

      function is_packable (this : access constant FieldDescriptor) return Extensions.bool;  -- ../../../src/google/protobuf/descriptor.h:1928
      pragma Import (CPP, is_packable, "_ZNK6google8protobuf15FieldDescriptor11is_packableEv");

      function is_packed (this : access constant FieldDescriptor) return Extensions.bool;  -- ../../../src/google/protobuf/descriptor.h:602
      pragma Import (CPP, is_packed, "_ZNK6google8protobuf15FieldDescriptor9is_packedEv");

      function is_map (this : access constant FieldDescriptor) return Extensions.bool;  -- ../../../src/google/protobuf/descriptor.h:604
      pragma Import (CPP, is_map, "_ZNK6google8protobuf15FieldDescriptor6is_mapEv");

      function index (this : access constant FieldDescriptor) return int;  -- ../../../src/google/protobuf/descriptor.h:1934
      pragma Import (CPP, index, "_ZNK6google8protobuf15FieldDescriptor5indexEv");

      function has_default_value (this : access constant FieldDescriptor) return Extensions.bool;  -- ../../../src/google/protobuf/descriptor.h:1819
      pragma Import (CPP, has_default_value, "_ZNK6google8protobuf15FieldDescriptor17has_default_valueEv");

      function has_json_name (this : access constant FieldDescriptor) return Extensions.bool;  -- ../../../src/google/protobuf/descriptor.h:1820
      pragma Import (CPP, has_json_name, "_ZNK6google8protobuf15FieldDescriptor13has_json_nameEv");

      function default_value_int32 (this : access constant FieldDescriptor) return google.protobuf.binding.port_h.int32;  -- ../../../src/google/protobuf/descriptor.h:1821
      pragma Import (CPP, default_value_int32, "_ZNK6google8protobuf15FieldDescriptor19default_value_int32Ev");

      function default_value_int64 (this : access constant FieldDescriptor) return google.protobuf.binding.port_h.int64;  -- ../../../src/google/protobuf/descriptor.h:1822
      pragma Import (CPP, default_value_int64, "_ZNK6google8protobuf15FieldDescriptor19default_value_int64Ev");

      function default_value_uint32 (this : access constant FieldDescriptor) return google.protobuf.binding.port_h.uint32;  -- ../../../src/google/protobuf/descriptor.h:1823
      pragma Import (CPP, default_value_uint32, "_ZNK6google8protobuf15FieldDescriptor20default_value_uint32Ev");

      function default_value_uint64 (this : access constant FieldDescriptor) return google.protobuf.binding.port_h.uint64;  -- ../../../src/google/protobuf/descriptor.h:1824
      pragma Import (CPP, default_value_uint64, "_ZNK6google8protobuf15FieldDescriptor20default_value_uint64Ev");

      function default_value_float (this : access constant FieldDescriptor) return float;  -- ../../../src/google/protobuf/descriptor.h:1825
      pragma Import (CPP, default_value_float, "_ZNK6google8protobuf15FieldDescriptor19default_value_floatEv");

      function default_value_double (this : access constant FieldDescriptor) return double;  -- ../../../src/google/protobuf/descriptor.h:1826
      pragma Import (CPP, default_value_double, "_ZNK6google8protobuf15FieldDescriptor20default_value_doubleEv");

      function default_value_bool (this : access constant FieldDescriptor) return Extensions.bool;  -- ../../../src/google/protobuf/descriptor.h:1827
      pragma Import (CPP, default_value_bool, "_ZNK6google8protobuf15FieldDescriptor18default_value_boolEv");

      function default_value_enum (this : access constant FieldDescriptor) return access constant google.protobuf.binding.descriptor_h.Class_EnumValueDescriptor.EnumValueDescriptor;  -- ../../../src/google/protobuf/descriptor.h:643
      pragma Import (CPP, default_value_enum, "_ZNK6google8protobuf15FieldDescriptor18default_value_enumEv");

      function default_value_string (this : access constant FieldDescriptor) return Interfaces_CPP.Strings.CPP_String_External;  -- ../../../src/google/protobuf/descriptor.h:1828
      pragma Import (CPP, default_value_string, "_ZNK6google8protobuf15FieldDescriptor20default_value_stringB5cxx11Ev");

      function containing_type (this : access constant FieldDescriptor) return access constant google.protobuf.binding.descriptor_h.Class_Descriptor.Descriptor;  -- ../../../src/google/protobuf/descriptor.h:1813
      pragma Import (CPP, containing_type, "_ZNK6google8protobuf15FieldDescriptor15containing_typeEv");

      function containing_oneof (this : access constant FieldDescriptor) return access constant google.protobuf.binding.descriptor_h.Class_OneofDescriptor.OneofDescriptor;  -- ../../../src/google/protobuf/descriptor.h:1814
      pragma Import (CPP, containing_oneof, "_ZNK6google8protobuf15FieldDescriptor16containing_oneofEv");

      function index_in_oneof (this : access constant FieldDescriptor) return int;  -- ../../../src/google/protobuf/descriptor.h:1816
      pragma Import (CPP, index_in_oneof, "_ZNK6google8protobuf15FieldDescriptor14index_in_oneofEv");

      function extension_scope (this : access constant FieldDescriptor) return access constant google.protobuf.binding.descriptor_h.Class_Descriptor.Descriptor;  -- ../../../src/google/protobuf/descriptor.h:1817
      pragma Import (CPP, extension_scope, "_ZNK6google8protobuf15FieldDescriptor15extension_scopeEv");

      function message_type (this : access constant FieldDescriptor) return access constant google.protobuf.binding.descriptor_h.Class_Descriptor.Descriptor;  -- ../../../src/google/protobuf/descriptor.h:668
      pragma Import (CPP, message_type, "_ZNK6google8protobuf15FieldDescriptor12message_typeEv");

      function enum_type (this : access constant FieldDescriptor) return access constant google.protobuf.binding.enum_descriptor_h.Class_EnumDescriptor.EnumDescriptor;  -- ../../../src/google/protobuf/descriptor.h:671
      pragma Import (CPP, enum_type, "_ZNK6google8protobuf15FieldDescriptor9enum_typeEv");

      function options (this : access constant FieldDescriptor) return System.Address;  -- ../../../src/google/protobuf/descriptor.h:1818
      pragma Import (CPP, options, "_ZNK6google8protobuf15FieldDescriptor7optionsEv");

      procedure CopyTo (this : access constant FieldDescriptor; proto : System.Address);  -- ../../../src/google/protobuf/descriptor.h:682
      pragma Import (CPP, CopyTo, "_ZNK6google8protobuf15FieldDescriptor6CopyToEPNS0_20FieldDescriptorProtoE");

      function DebugString (this : access constant FieldDescriptor) return Interfaces_CPP.Strings.CPP_String_External;  -- ../../../src/google/protobuf/descriptor.h:685
      pragma Import (CPP, DebugString, "_ZNK6google8protobuf15FieldDescriptor11DebugStringB5cxx11Ev");

    function DebugStringWithOptions (this : access constant FieldDescriptor;
                                     options : access constant google.protobuf.binding.descriptor_h.Class_DebugStringOptions.DebugStringOptions)
                                     return Interfaces_CPP.Strings.CPP_String_External;  -- ../../../src/google/protobuf/descriptor.h:688
      pragma Import (CPP, DebugStringWithOptions, "_ZNK6google8protobuf15FieldDescriptor22DebugStringWithOptionsB5cxx11ERKNS0_18DebugStringOptionsE");

    function GetSourceLocation (this : access constant FieldDescriptor;
                                out_location : access google.protobuf.binding.descriptor_h.Class_SourceLocation.SourceLocation)
                                return Extensions.bool;  -- ../../../src/google/protobuf/descriptor.h:707
      pragma Import (CPP, GetSourceLocation, "_ZNK6google8protobuf15FieldDescriptor17GetSourceLocationEPNS0_14SourceLocationE");

      procedure CopyJsonNameTo (this : access constant FieldDescriptor; proto : System.Address);  -- ../../../src/google/protobuf/descriptor.h:716
      pragma Import (CPP, CopyJsonNameTo, "_ZNK6google8protobuf15FieldDescriptor14CopyJsonNameToEPNS0_20FieldDescriptorProtoE");

      procedure DebugString2
        (this : access constant FieldDescriptor;
         depth : int;
         print_label_flag : PrintLabelFlag;
         contents : Interfaces_CPP.Strings.CPP_String_External;
         options : access constant google.protobuf.binding.descriptor_h.Class_DebugStringOptions.DebugStringOptions);  -- ../../../src/google/protobuf/descriptor.h:720
      pragma Import (CPP, DebugString2, "_ZNK6google8protobuf15FieldDescriptor11DebugStringEiNS1_14PrintLabelFlagEPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEERKNS0_18DebugStringOptionsE");

      function DefaultValueAsString (this : access constant FieldDescriptor; quote_string_type : Extensions.bool) return Interfaces_CPP.Strings.CPP_String_External;  -- ../../../src/google/protobuf/descriptor.h:726
      pragma Import (CPP, DefaultValueAsString, "_ZNK6google8protobuf15FieldDescriptor20DefaultValueAsStringB5cxx11Eb");

      function FieldTypeNameDebugString (this : access constant FieldDescriptor) return Interfaces_CPP.Strings.CPP_String_External;  -- ../../../src/google/protobuf/descriptor.h:729
      pragma Import (CPP, FieldTypeNameDebugString, "_ZNK6google8protobuf15FieldDescriptor24FieldTypeNameDebugStringB5cxx11Ev");

      procedure GetLocationPath (this : access constant FieldDescriptor; output : System.Address);  -- ../../../src/google/protobuf/descriptor.h:733
      pragma Import (CPP, GetLocationPath, "_ZNK6google8protobuf15FieldDescriptor15GetLocationPathEPSt6vectorIiSaIiEE");

      procedure InternalTypeOnceInit (this : access constant FieldDescriptor);  -- ../../../src/google/protobuf/descriptor.h:749
      pragma Import (CPP, InternalTypeOnceInit, "_ZNK6google8protobuf15FieldDescriptor20InternalTypeOnceInitEv");

      function New_FieldDescriptor return FieldDescriptor;  -- ../../../src/google/protobuf/descriptor.h:789
      pragma CPP_Constructor (New_FieldDescriptor, "_ZN6google8protobuf15FieldDescriptorC1Ev");

      procedure operator_as (this : access FieldDescriptor; arg2 : access constant FieldDescriptor);  -- ../../../src/google/protobuf/descriptor.h:794
      pragma Import (CPP, operator_as, "_ZN6google8protobuf15FieldDescriptoraSERKS1_");

      package Static is
         function TypeToCppType (the_c_type : c_Type) return CppType;  -- ../../../src/google/protobuf/descriptor.h:1988
         pragma Import (CPP, TypeToCppType, "_ZN6google8protobuf15FieldDescriptor13TypeToCppTypeENS1_4TypeE");

         function TypeName (the_c_type : c_Type) return Interfaces.C.Strings.chars_ptr;  -- ../../../src/google/protobuf/descriptor.h:1992
         pragma Import (CPP, TypeName, "_ZN6google8protobuf15FieldDescriptor8TypeNameENS1_4TypeE");

         function CppTypeName (cpp_type : CppType) return Interfaces.C.Strings.chars_ptr;  -- ../../../src/google/protobuf/descriptor.h:1996
         pragma Import (CPP, CppTypeName, "_ZN6google8protobuf15FieldDescriptor11CppTypeNameENS1_7CppTypeE");

         function IsTypePackable (field_type : c_Type) return Extensions.bool;  -- ../../../src/google/protobuf/descriptor.h:2000
         pragma Import (CPP, IsTypePackable, "_ZN6google8protobuf15FieldDescriptor14IsTypePackableENS1_4TypeE");

         procedure TypeOnceInit (to_init : access constant FieldDescriptor);  -- ../../../src/google/protobuf/descriptor.h:748
         pragma Import (CPP, TypeOnceInit, "_ZN6google8protobuf15FieldDescriptor12TypeOnceInitEPKS1_");
      end;

      function TypeToCppType (the_c_type : c_Type) return CppType renames Static.TypeToCppType;

      function TypeName (the_c_type : c_Type) return Interfaces.C.Strings.chars_ptr renames Static.TypeName;

      function CppTypeName (cpp_type : CppType) return Interfaces.C.Strings.chars_ptr renames Static.CppTypeName;

      function IsTypePackable (field_type : c_Type) return Extensions.bool renames Static.IsTypePackable;

      procedure TypeOnceInit (to_init : access constant FieldDescriptor) renames Static.TypeOnceInit;

      kMaxNumber : aliased int;  -- ../../../src/google/protobuf/descriptor.h:556
      pragma Import (CPP, kMaxNumber, "_ZN6google8protobuf15FieldDescriptor10kMaxNumberE");

      kFirstReservedNumber : aliased int;  -- ../../../src/google/protobuf/descriptor.h:560
      pragma Import (CPP, kFirstReservedNumber, "_ZN6google8protobuf15FieldDescriptor20kFirstReservedNumberE");

      kLastReservedNumber : aliased int;  -- ../../../src/google/protobuf/descriptor.h:563
      pragma Import (CPP, kLastReservedNumber, "_ZN6google8protobuf15FieldDescriptor19kLastReservedNumberE");

      kTypeToCppTypeMap : aliased FieldDescriptor_kTypeToCppTypeMap_array;  -- ../../../src/google/protobuf/descriptor.h:780
      pragma Import (CPP, kTypeToCppTypeMap, "_ZN6google8protobuf15FieldDescriptor17kTypeToCppTypeMapE");

      kTypeToName : FieldDescriptor_kTypeToName_array;  -- ../../../src/google/protobuf/descriptor.h:782
      pragma Import (CPP, kTypeToName, "_ZN6google8protobuf15FieldDescriptor11kTypeToNameE");

      kCppTypeToName : FieldDescriptor_kCppTypeToName_array;  -- ../../../src/google/protobuf/descriptor.h:784
      pragma Import (CPP, kCppTypeToName, "_ZN6google8protobuf15FieldDescriptor14kCppTypeToNameE");

      kLabelToName : FieldDescriptor_kLabelToName_array;  -- ../../../src/google/protobuf/descriptor.h:786
      pragma Import (CPP, kLabelToName, "_ZN6google8protobuf15FieldDescriptor12kLabelToNameE");
   end;

end google.protobuf.binding.field_descriptor_h;
