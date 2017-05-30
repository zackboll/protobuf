pragma Ada_2005;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
--  with google.protobuf.binding.cpp_6_2_1_bits_stringfwd_h;
--  with google.protobuf.binding.cpp_6_2_1_bits_stl_vector_h;
with Interfaces.C.Extensions;
with Interfaces_CPP.Strings;
--  limited with google.protobuf.binding.once_h;
with System;
--  with google.protobuf.binding.port_h;
--  with Interfaces.C.Strings;
limited with google.protobuf.binding.mutex_h;

with google.protobuf.binding.enum_descriptor_h;
with google.protobuf.binding.file_descriptor_h;
with google.protobuf.binding.field_descriptor_h;
with google.protobuf.binding.method_descriptor_h;
--  with google.protobuf.binding.scoped_ptr_h;
--  with google.protobuf.binding.cpp_6_2_1_bits_stl_set_h;

package google.protobuf.binding.descriptor_h is

  use google.protobuf.binding.file_descriptor_h.Class_FileDescriptor;
  use google.protobuf.binding.field_descriptor_h.Class_FieldDescriptor;
  use google.protobuf.binding.enum_descriptor_h.Class_EnumDescriptor;
  use google.protobuf.binding.method_descriptor_h.Class_MethodDescriptor;

   --  arg-macro: procedure PROTOBUF_DEFINE_OPTIONS_ACCESSOR inline const TYPEand CLASS.options() const { return *options_; }
   --    inline const TYPEand CLASS.options() const { return *options_; }
   --  skipped empty struct DescriptorDatabase

   --  skipped empty struct DescriptorProto

   --  skipped empty struct FieldDescriptorProto

   --  skipped empty struct OneofDescriptorProto

   --  skipped empty struct EnumDescriptorProto

   --  skipped empty struct EnumValueDescriptorProto

   --  skipped empty struct ServiceDescriptorProto

   --  skipped empty struct MethodDescriptorProto

   --  skipped empty struct FileDescriptorProto

   --  skipped empty struct MessageOptions

   --  skipped empty struct FieldOptions

   --  skipped empty struct OneofOptions

   --  skipped empty struct EnumOptions

   --  skipped empty struct EnumValueOptions

   --  skipped empty struct ServiceOptions

   --  skipped empty struct MethodOptions

   --  skipped empty struct FileOptions

   --  skipped empty struct UninterpretedOption

   --  skipped empty struct SourceCodeInfo

   --  skipped empty struct Message

   --  skipped empty struct DescriptorBuilder

   --  skipped empty struct FileDescriptorTables

   --  skipped empty struct Symbol

   --  skipped empty struct UnknownField

   --  skipped empty struct GeneratedMessageReflection

   --  skipped empty struct CommandLineInterface

   --  skipped empty struct DescriptorTest

  --  skipped empty struct Printer

  type Symbol is new System.Address;

   package Class_SourceLocation is
      type SourceLocation is limited record
         start_line : aliased int;  -- ../../../src/google/protobuf/descriptor.h:140
         end_line : aliased int;  -- ../../../src/google/protobuf/descriptor.h:141
         start_column : aliased int;  -- ../../../src/google/protobuf/descriptor.h:142
         end_column : aliased int;  -- ../../../src/google/protobuf/descriptor.h:143
         leading_comments : Interfaces_CPP.Strings.CPP_String_External;--aliased google.protobuf.binding.cpp_6_2_1_bits_stringfwd_h.Class_string.string;  -- ../../../src/google/protobuf/descriptor.h:147
         trailing_comments : Interfaces_CPP.Strings.CPP_String_External;--aliased google.protobuf.binding.cpp_6_2_1_bits_stringfwd_h.Class_string.string;  -- ../../../src/google/protobuf/descriptor.h:148
         leading_detached_comments : System.Address;--aliased google.protobuf.binding.cpp_6_2_1_bits_stl_vector_h.Class_vector.vector;  -- ../../../src/google/protobuf/descriptor.h:149
      end record;
      pragma Import (CPP, SourceLocation);
   end;
   use Class_SourceLocation;
   package Class_DebugStringOptions is
      type DebugStringOptions is limited record
         include_comments : aliased Extensions.bool;  -- ../../../src/google/protobuf/descriptor.h:159
         elide_group_body : aliased Extensions.bool;  -- ../../../src/google/protobuf/descriptor.h:161
         elide_oneof_body : aliased Extensions.bool;  -- ../../../src/google/protobuf/descriptor.h:162
      end record;
      pragma Import (CPP, DebugStringOptions);

      function New_DebugStringOptions return DebugStringOptions;  -- ../../../src/google/protobuf/descriptor.h:164
      pragma CPP_Constructor (New_DebugStringOptions, "_ZN6google8protobuf18DebugStringOptionsC1Ev");
   end;
  use Class_DebugStringOptions;



  package Class_Descriptor is
       type ExtensionRange is record
      start : aliased int;
      c_end : aliased int;
   end record;
    pragma Convention (C_Pass_By_Copy, ExtensionRange);

    type ReservedRange is record
      start : aliased int;
      c_end : aliased int;
   end record;
   pragma Convention (C_Pass_By_Copy, ReservedRange);

      type Descriptor is limited record
         name_u : Interfaces_CPP.Strings.CPP_String_External;--access constant google.protobuf.binding.cpp_6_2_1_bits_stringfwd_h.Class_string.string;  -- ../../../src/google/protobuf/descriptor.h:437
         full_name_u : Interfaces_CPP.Strings.CPP_String_External;--access constant google.protobuf.binding.cpp_6_2_1_bits_stringfwd_h.Class_string.string;  -- ../../../src/google/protobuf/descriptor.h:438
         file_u : access constant FileDescriptor;  -- ../../../src/google/protobuf/descriptor.h:439
         containing_type_u : access constant Descriptor;  -- ../../../src/google/protobuf/descriptor.h:440
         options_u : System.Address;  -- ../../../src/google/protobuf/descriptor.h:441
         is_placeholder_u : aliased Extensions.bool;  -- ../../../src/google/protobuf/descriptor.h:444
         is_unqualified_placeholder_u : aliased Extensions.bool;  -- ../../../src/google/protobuf/descriptor.h:446
         field_count_u : aliased int;  -- ../../../src/google/protobuf/descriptor.h:448
         fields_u : System.Address;  -- ../../../src/google/protobuf/descriptor.h:449
         oneof_decl_count_u : aliased int;  -- ../../../src/google/protobuf/descriptor.h:450
         oneof_decls_u : System.Address;  -- ../../../src/google/protobuf/descriptor.h:451
         nested_type_count_u : aliased int;  -- ../../../src/google/protobuf/descriptor.h:452
         nested_types_u : access Descriptor;  -- ../../../src/google/protobuf/descriptor.h:453
         enum_type_count_u : aliased int;  -- ../../../src/google/protobuf/descriptor.h:454
         enum_types_u : System.Address;  -- ../../../src/google/protobuf/descriptor.h:455
         extension_range_count_u : aliased int;  -- ../../../src/google/protobuf/descriptor.h:456
         extension_ranges_u : System.Address;  -- ../../../src/google/protobuf/descriptor.h:457
         extension_count_u : aliased int;  -- ../../../src/google/protobuf/descriptor.h:458
         extensions_u : System.Address;  -- ../../../src/google/protobuf/descriptor.h:459
         reserved_range_count_u : aliased int;  -- ../../../src/google/protobuf/descriptor.h:460
         reserved_ranges_u : System.Address;  -- ../../../src/google/protobuf/descriptor.h:461
         reserved_name_count_u : aliased int;  -- ../../../src/google/protobuf/descriptor.h:462
         reserved_names_u : System.Address;  -- ../../../src/google/protobuf/descriptor.h:463
      end record;
      pragma Import (CPP, Descriptor);

      function name (this : access constant Descriptor) return Interfaces_CPP.Strings.CPP_String_External;  -- ../../../src/google/protobuf/descriptor.h:1774
      pragma Import (CPP, name, "_ZNK6google8protobuf10Descriptor4nameB5cxx11Ev");

      function full_name (this : access constant Descriptor) return Interfaces_CPP.Strings.CPP_String_External;  -- ../../../src/google/protobuf/descriptor.h:1775
      pragma Import (CPP, full_name, "_ZNK6google8protobuf10Descriptor9full_nameB5cxx11Ev");

      function index (this : access constant Descriptor) return int;  -- ../../../src/google/protobuf/descriptor.h:1944
      pragma Import (CPP, index, "_ZNK6google8protobuf10Descriptor5indexEv");

      function file (this : access constant Descriptor) return access constant FileDescriptor;  -- ../../../src/google/protobuf/descriptor.h:1776
      pragma Import (CPP, file, "_ZNK6google8protobuf10Descriptor4fileEv");

      function containing_type (this : access constant Descriptor) return access constant Descriptor;  -- ../../../src/google/protobuf/descriptor.h:1777
      pragma Import (CPP, containing_type, "_ZNK6google8protobuf10Descriptor15containing_typeEv");

      function options (this : access constant Descriptor) return System.Address;  -- ../../../src/google/protobuf/descriptor.h:1801
      pragma Import (CPP, options, "_ZNK6google8protobuf10Descriptor7optionsEv");

      procedure CopyTo (this : access constant Descriptor; proto : System.Address);  -- ../../../src/google/protobuf/descriptor.h:257
      pragma Import (CPP, CopyTo, "_ZNK6google8protobuf10Descriptor6CopyToEPNS0_15DescriptorProtoE");

      function DebugString (this : access constant Descriptor) return Interfaces_CPP.Strings.CPP_String_External;  -- ../../../src/google/protobuf/descriptor.h:261
      pragma Import (CPP, DebugString, "_ZNK6google8protobuf10Descriptor11DebugStringB5cxx11Ev");

      function DebugStringWithOptions (this : access constant Descriptor; options : access constant DebugStringOptions) return Interfaces_CPP.Strings.CPP_String_External;  -- ../../../src/google/protobuf/descriptor.h:265
      pragma Import (CPP, DebugStringWithOptions, "_ZNK6google8protobuf10Descriptor22DebugStringWithOptionsB5cxx11ERKNS0_18DebugStringOptionsE");

      function is_placeholder (this : access constant Descriptor) return Extensions.bool;  -- ../../../src/google/protobuf/descriptor.h:1802
      pragma Import (CPP, is_placeholder, "_ZNK6google8protobuf10Descriptor14is_placeholderEv");

      function field_count (this : access constant Descriptor) return int;  -- ../../../src/google/protobuf/descriptor.h:1779
      pragma Import (CPP, field_count, "_ZNK6google8protobuf10Descriptor11field_countEv");

      function field (this : access constant Descriptor; index : int) return System.Address;  -- ../../../src/google/protobuf/descriptor.h:1784
      pragma Import (CPP, field, "_ZNK6google8protobuf10Descriptor5fieldEi");

      function FindFieldByNumber (this : access constant Descriptor; number : int) return System.Address;  -- ../../../src/google/protobuf/descriptor.h:282
      pragma Import (CPP, FindFieldByNumber, "_ZNK6google8protobuf10Descriptor17FindFieldByNumberEi");

      function FindFieldByName (this : access constant Descriptor; name : Interfaces_CPP.Strings.CPP_String_External) return System.Address;  -- ../../../src/google/protobuf/descriptor.h:284
      pragma Import (CPP, FindFieldByName, "_ZNK6google8protobuf10Descriptor15FindFieldByNameERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE");

      function FindFieldByLowercaseName (this : access constant Descriptor; lowercase_name : Interfaces_CPP.Strings.CPP_String_External) return System.Address;  -- ../../../src/google/protobuf/descriptor.h:289
      pragma Import (CPP, FindFieldByLowercaseName, "_ZNK6google8protobuf10Descriptor24FindFieldByLowercaseNameERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE");

      function FindFieldByCamelcaseName (this : access constant Descriptor; camelcase_name : access constant Interfaces_CPP.Strings.CPP_String_External) return System.Address;  -- ../../../src/google/protobuf/descriptor.h:296
      pragma Import (CPP, FindFieldByCamelcaseName, "_ZNK6google8protobuf10Descriptor24FindFieldByCamelcaseNameERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE");

      function oneof_decl_count (this : access constant Descriptor) return int;  -- ../../../src/google/protobuf/descriptor.h:1780
      pragma Import (CPP, oneof_decl_count, "_ZNK6google8protobuf10Descriptor16oneof_decl_countEv");

      function oneof_decl (this : access constant Descriptor; index : int) return System.Address;  -- ../../../src/google/protobuf/descriptor.h:1785
      pragma Import (CPP, oneof_decl, "_ZNK6google8protobuf10Descriptor10oneof_declEi");

      function FindOneofByName (this : access constant Descriptor; name : Interfaces_CPP.Strings.CPP_String_External) return System.Address;  -- ../../../src/google/protobuf/descriptor.h:306
      pragma Import (CPP, FindOneofByName, "_ZNK6google8protobuf10Descriptor15FindOneofByNameERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE");

      function nested_type_count (this : access constant Descriptor) return int;  -- ../../../src/google/protobuf/descriptor.h:1781
      pragma Import (CPP, nested_type_count, "_ZNK6google8protobuf10Descriptor17nested_type_countEv");

      function nested_type (this : access constant Descriptor; index : int) return access constant Descriptor;  -- ../../../src/google/protobuf/descriptor.h:1786
      pragma Import (CPP, nested_type, "_ZNK6google8protobuf10Descriptor11nested_typeEi");

      function FindNestedTypeByName (this : access constant Descriptor; name : Interfaces_CPP.Strings.CPP_String_External) return access constant Descriptor;  -- ../../../src/google/protobuf/descriptor.h:318
      pragma Import (CPP, FindNestedTypeByName, "_ZNK6google8protobuf10Descriptor20FindNestedTypeByNameERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE");

      function enum_type_count (this : access constant Descriptor) return int;  -- ../../../src/google/protobuf/descriptor.h:1782
      pragma Import (CPP, enum_type_count, "_ZNK6google8protobuf10Descriptor15enum_type_countEv");

      function enum_type (this : access constant Descriptor; index : int) return System.Address;  -- ../../../src/google/protobuf/descriptor.h:1787
      pragma Import (CPP, enum_type, "_ZNK6google8protobuf10Descriptor9enum_typeEi");

      function FindEnumTypeByName (this : access constant Descriptor; name : Interfaces_CPP.Strings.CPP_String_External) return System.Address;  -- ../../../src/google/protobuf/descriptor.h:329
      pragma Import (CPP, FindEnumTypeByName, "_ZNK6google8protobuf10Descriptor18FindEnumTypeByNameERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE");

      function FindEnumValueByName (this : access constant Descriptor; name : Interfaces_CPP.Strings.CPP_String_External) return System.Address;  -- ../../../src/google/protobuf/descriptor.h:333
      pragma Import (CPP, FindEnumValueByName, "_ZNK6google8protobuf10Descriptor19FindEnumValueByNameERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE");

      function extension_range_count (this : access constant Descriptor) return int;  -- ../../../src/google/protobuf/descriptor.h:1789
      pragma Import (CPP, extension_range_count, "_ZNK6google8protobuf10Descriptor21extension_range_countEv");

      function extension_range (this : access constant Descriptor; index : int) return access constant ExtensionRange;  -- ../../../src/google/protobuf/descriptor.h:1791
      pragma Import (CPP, extension_range, "_ZNK6google8protobuf10Descriptor15extension_rangeEi");

      function IsExtensionNumber (this : access constant Descriptor; number : int) return Extensions.bool;  -- ../../../src/google/protobuf/descriptor.h:1893
      pragma Import (CPP, IsExtensionNumber, "_ZNK6google8protobuf10Descriptor17IsExtensionNumberEi");

      function FindExtensionRangeContainingNumber (this : access constant Descriptor; number : int) return access constant ExtensionRange;  -- ../../../src/google/protobuf/descriptor.h:355
      pragma Import (CPP, FindExtensionRangeContainingNumber, "_ZNK6google8protobuf10Descriptor34FindExtensionRangeContainingNumberEi");

      function extension_count (this : access constant Descriptor) return int;  -- ../../../src/google/protobuf/descriptor.h:1790
      pragma Import (CPP, extension_count, "_ZNK6google8protobuf10Descriptor15extension_countEv");

      function extension (this : access constant Descriptor; index : int) return System.Address;  -- ../../../src/google/protobuf/descriptor.h:1793
      pragma Import (CPP, extension, "_ZNK6google8protobuf10Descriptor9extensionEi");

      function FindExtensionByName (this : access constant Descriptor; name : Interfaces_CPP.Strings.CPP_String_External) return System.Address;  -- ../../../src/google/protobuf/descriptor.h:366
      pragma Import (CPP, FindExtensionByName, "_ZNK6google8protobuf10Descriptor19FindExtensionByNameERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE");

      function FindExtensionByLowercaseName (this : access constant Descriptor; name : Interfaces_CPP.Strings.CPP_String_External) return System.Address;  -- ../../../src/google/protobuf/descriptor.h:370
      pragma Import (CPP, FindExtensionByLowercaseName, "_ZNK6google8protobuf10Descriptor28FindExtensionByLowercaseNameERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE");

      function FindExtensionByCamelcaseName (this : access constant Descriptor; name : Interfaces_CPP.Strings.CPP_String_External) return System.Address;  -- ../../../src/google/protobuf/descriptor.h:374
      pragma Import (CPP, FindExtensionByCamelcaseName, "_ZNK6google8protobuf10Descriptor28FindExtensionByCamelcaseNameERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE");

      function reserved_range_count (this : access constant Descriptor) return int;  -- ../../../src/google/protobuf/descriptor.h:1796
      pragma Import (CPP, reserved_range_count, "_ZNK6google8protobuf10Descriptor20reserved_range_countEv");

      function reserved_range (this : access constant Descriptor; index : int) return access constant ReservedRange;  -- ../../../src/google/protobuf/descriptor.h:1797
      pragma Import (CPP, reserved_range, "_ZNK6google8protobuf10Descriptor14reserved_rangeEi");

      function IsReservedNumber (this : access constant Descriptor; number : int) return Extensions.bool;  -- ../../../src/google/protobuf/descriptor.h:1897
      pragma Import (CPP, IsReservedNumber, "_ZNK6google8protobuf10Descriptor16IsReservedNumberEi");

      function FindReservedRangeContainingNumber (this : access constant Descriptor; number : int) return access constant ReservedRange;  -- ../../../src/google/protobuf/descriptor.h:395
      pragma Import (CPP, FindReservedRangeContainingNumber, "_ZNK6google8protobuf10Descriptor33FindReservedRangeContainingNumberEi");

      function reserved_name_count (this : access constant Descriptor) return int;  -- ../../../src/google/protobuf/descriptor.h:1799
      pragma Import (CPP, reserved_name_count, "_ZNK6google8protobuf10Descriptor19reserved_name_countEv");

      function reserved_name (this : access constant Descriptor; index : int) return Interfaces_CPP.Strings.CPP_String_External;  -- ../../../src/google/protobuf/descriptor.h:1912
      pragma Import (CPP, reserved_name, "_ZNK6google8protobuf10Descriptor13reserved_nameB5cxx11Ei");

    function IsReservedName (this : access constant Descriptor; name : Interfaces_CPP.Strings.CPP_String_External) return Extensions.bool;  -- ../../../src/google/protobuf/descriptor.h:1901
      pragma Import (CPP, IsReservedName, "_ZNK6google8protobuf10Descriptor14IsReservedNameERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE");

      function GetSourceLocation (this : access constant Descriptor; out_location : access SourceLocation) return Extensions.bool;  -- ../../../src/google/protobuf/descriptor.h:411
      pragma Import (CPP, GetSourceLocation, "_ZNK6google8protobuf10Descriptor17GetSourceLocationEPNS0_14SourceLocationE");

      procedure CopyJsonNameTo (this : access constant Descriptor; proto : System.Address);  -- ../../../src/google/protobuf/descriptor.h:423
      pragma Import (CPP, CopyJsonNameTo, "_ZNK6google8protobuf10Descriptor14CopyJsonNameToEPNS0_15DescriptorProtoE");

      procedure DebugString2
        (this : access constant Descriptor;
         depth : int;
         contents : Interfaces_CPP.Strings.CPP_String_External;
         options : access constant DebugStringOptions;
         include_opening_clause : Extensions.bool);  -- ../../../src/google/protobuf/descriptor.h:429
      pragma Import (CPP, DebugString2, "_ZNK6google8protobuf10Descriptor11DebugStringEiPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEERKNS0_18DebugStringOptionsEb");

      procedure GetLocationPath (this : access constant Descriptor; output : System.Address);  -- ../../../src/google/protobuf/descriptor.h:435
      pragma Import (CPP, GetLocationPath, "_ZNK6google8protobuf10Descriptor15GetLocationPathEPSt6vectorIiSaIiEE");

      function New_Descriptor return Descriptor;  -- ../../../src/google/protobuf/descriptor.h:469
      pragma CPP_Constructor (New_Descriptor, "_ZN6google8protobuf10DescriptorC1Ev");

      procedure operator_as (this : access Descriptor; arg2 : access constant Descriptor);  -- ../../../src/google/protobuf/descriptor.h:477
      pragma Import (CPP, operator_as, "_ZN6google8protobuf10DescriptoraSERKS1_");
   end;
  use Class_Descriptor;

--     type Descriptor;
--     type FileDescriptor;


   package Class_OneofDescriptor is
      type OneofDescriptor is limited record
         name_u : Interfaces_CPP.Strings.CPP_String_External;  -- ../../../src/google/protobuf/descriptor.h:847
         full_name_u : Interfaces_CPP.Strings.CPP_String_External;  -- ../../../src/google/protobuf/descriptor.h:848
         containing_type_u : access constant Descriptor;  -- ../../../src/google/protobuf/descriptor.h:849
         is_extendable_u : aliased Extensions.bool;  -- ../../../src/google/protobuf/descriptor.h:850
         field_count_u : aliased int;  -- ../../../src/google/protobuf/descriptor.h:851
         fields_u : System.Address;  -- ../../../src/google/protobuf/descriptor.h:852
         options_u : System.Address;  -- ../../../src/google/protobuf/descriptor.h:853
      end record;
      pragma Import (CPP, OneofDescriptor);

      function name (this : access constant OneofDescriptor) return Interfaces_CPP.Strings.CPP_String_External;  -- ../../../src/google/protobuf/descriptor.h:1830
      pragma Import (CPP, name, "_ZNK6google8protobuf15OneofDescriptor4nameB5cxx11Ev");

    function full_name (this : access constant OneofDescriptor) return Interfaces_CPP.Strings.CPP_String_External;  -- ../../../src/google/protobuf/descriptor.h:1831
      pragma Import (CPP, full_name, "_ZNK6google8protobuf15OneofDescriptor9full_nameB5cxx11Ev");

      function index (this : access constant OneofDescriptor) return int;  -- ../../../src/google/protobuf/descriptor.h:1952
      pragma Import (CPP, index, "_ZNK6google8protobuf15OneofDescriptor5indexEv");

      function containing_type (this : access constant OneofDescriptor) return access constant Descriptor;  -- ../../../src/google/protobuf/descriptor.h:1832
      pragma Import (CPP, containing_type, "_ZNK6google8protobuf15OneofDescriptor15containing_typeEv");

      function field_count (this : access constant OneofDescriptor) return int;  -- ../../../src/google/protobuf/descriptor.h:1833
      pragma Import (CPP, field_count, "_ZNK6google8protobuf15OneofDescriptor11field_countEv");

      function field (this : access constant OneofDescriptor; index : int) return access constant FieldDescriptor;  -- ../../../src/google/protobuf/descriptor.h:2023
      pragma Import (CPP, field, "_ZNK6google8protobuf15OneofDescriptor5fieldEi");

      function options (this : access constant OneofDescriptor) return System.Address;  -- ../../../src/google/protobuf/descriptor.h:1834
      pragma Import (CPP, options, "_ZNK6google8protobuf15OneofDescriptor7optionsEv");

      procedure CopyTo (this : access constant OneofDescriptor; proto : System.Address);  -- ../../../src/google/protobuf/descriptor.h:818
      pragma Import (CPP, CopyTo, "_ZNK6google8protobuf15OneofDescriptor6CopyToEPNS0_20OneofDescriptorProtoE");

      function DebugString (this : access constant OneofDescriptor) return Interfaces_CPP.Strings.CPP_String_External;  -- ../../../src/google/protobuf/descriptor.h:821
      pragma Import (CPP, DebugString, "_ZNK6google8protobuf15OneofDescriptor11DebugStringB5cxx11Ev");

      function DebugStringWithOptions (this : access constant OneofDescriptor; options : access constant DebugStringOptions) return Interfaces_CPP.Strings.CPP_String_External;  -- ../../../src/google/protobuf/descriptor.h:824
      pragma Import (CPP, DebugStringWithOptions, "_ZNK6google8protobuf15OneofDescriptor22DebugStringWithOptionsB5cxx11ERKNS0_18DebugStringOptionsE");

      function GetSourceLocation (this : access constant OneofDescriptor; out_location : access SourceLocation) return Extensions.bool;  -- ../../../src/google/protobuf/descriptor.h:831
      pragma Import (CPP, GetSourceLocation, "_ZNK6google8protobuf15OneofDescriptor17GetSourceLocationEPNS0_14SourceLocationE");

      procedure DebugString2
        (this : access constant OneofDescriptor;
         depth : int;
         contents : Interfaces_CPP.Strings.CPP_String_External;
         options : access constant DebugStringOptions);  -- ../../../src/google/protobuf/descriptor.h:840
      pragma Import (CPP, DebugString2, "_ZNK6google8protobuf15OneofDescriptor11DebugStringEiPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEERKNS0_18DebugStringOptionsE");

      procedure GetLocationPath (this : access constant OneofDescriptor; output : System.Address);  -- ../../../src/google/protobuf/descriptor.h:845
      pragma Import (CPP, GetLocationPath, "_ZNK6google8protobuf15OneofDescriptor15GetLocationPathEPSt6vectorIiSaIiEE");

      function New_OneofDescriptor return OneofDescriptor;  -- ../../../src/google/protobuf/descriptor.h:860
      pragma CPP_Constructor (New_OneofDescriptor, "_ZN6google8protobuf15OneofDescriptorC1Ev");

      procedure operator_as (this : access OneofDescriptor; arg2 : access constant OneofDescriptor);  -- ../../../src/google/protobuf/descriptor.h:863
      pragma Import (CPP, operator_as, "_ZN6google8protobuf15OneofDescriptoraSERKS1_");
   end;
  use Class_OneofDescriptor;

   package Class_EnumValueDescriptor is
      type EnumValueDescriptor is limited record
         name_u : Interfaces_CPP.Strings.CPP_String_External;  -- ../../../src/google/protobuf/descriptor.h:1042
         full_name_u : Interfaces_CPP.Strings.CPP_String_External;  -- ../../../src/google/protobuf/descriptor.h:1043
         number_u : aliased int;  -- ../../../src/google/protobuf/descriptor.h:1044
         type_u : access constant EnumDescriptor;  -- ../../../src/google/protobuf/descriptor.h:1045
         options_u : System.Address;  -- ../../../src/google/protobuf/descriptor.h:1046
      end record;
      pragma Import (CPP, EnumValueDescriptor);

      function name (this : access constant EnumValueDescriptor) return Interfaces_CPP.Strings.CPP_String_External;  -- ../../../src/google/protobuf/descriptor.h:1846
      pragma Import (CPP, name, "_ZNK6google8protobuf19EnumValueDescriptor4nameB5cxx11Ev");

      function index (this : access constant EnumValueDescriptor) return int;  -- ../../../src/google/protobuf/descriptor.h:1964
      pragma Import (CPP, index, "_ZNK6google8protobuf19EnumValueDescriptor5indexEv");

      function number (this : access constant EnumValueDescriptor) return int;  -- ../../../src/google/protobuf/descriptor.h:1848
      pragma Import (CPP, number, "_ZNK6google8protobuf19EnumValueDescriptor6numberEv");

      function full_name (this : access constant EnumValueDescriptor) return Interfaces_CPP.Strings.CPP_String_External;  -- ../../../src/google/protobuf/descriptor.h:1847
      pragma Import (CPP, full_name, "_ZNK6google8protobuf19EnumValueDescriptor9full_nameB5cxx11Ev");

      function c_type (this : access constant EnumValueDescriptor) return access constant EnumDescriptor;  -- ../../../src/google/protobuf/descriptor.h:1849
      pragma Import (CPP, c_type, "_ZNK6google8protobuf19EnumValueDescriptor4typeEv");

      function options (this : access constant EnumValueDescriptor) return System.Address;  -- ../../../src/google/protobuf/descriptor.h:1850
      pragma Import (CPP, options, "_ZNK6google8protobuf19EnumValueDescriptor7optionsEv");

      procedure CopyTo (this : access constant EnumValueDescriptor; proto : System.Address);  -- ../../../src/google/protobuf/descriptor.h:1012
      pragma Import (CPP, CopyTo, "_ZNK6google8protobuf19EnumValueDescriptor6CopyToEPNS0_24EnumValueDescriptorProtoE");

      function DebugString (this : access constant EnumValueDescriptor) return Interfaces_CPP.Strings.CPP_String_External;  -- ../../../src/google/protobuf/descriptor.h:1015
      pragma Import (CPP, DebugString, "_ZNK6google8protobuf19EnumValueDescriptor11DebugStringB5cxx11Ev");

      function DebugStringWithOptions (this : access constant EnumValueDescriptor; options : access constant DebugStringOptions) return Interfaces_CPP.Strings.CPP_String_External;  -- ../../../src/google/protobuf/descriptor.h:1018
      pragma Import (CPP, DebugStringWithOptions, "_ZNK6google8protobuf19EnumValueDescriptor22DebugStringWithOptionsB5cxx11ERKNS0_18DebugStringOptionsE");

      function GetSourceLocation (this : access constant EnumValueDescriptor; out_location : access SourceLocation) return Extensions.bool;  -- ../../../src/google/protobuf/descriptor.h:1026
      pragma Import (CPP, GetSourceLocation, "_ZNK6google8protobuf19EnumValueDescriptor17GetSourceLocationEPNS0_14SourceLocationE");

      procedure DebugString2
        (this : access constant EnumValueDescriptor;
         depth : int;
         contents : access Interfaces_CPP.Strings.CPP_String_External;
         options : access constant DebugStringOptions);  -- ../../../src/google/protobuf/descriptor.h:1035
      pragma Import (CPP, DebugString2, "_ZNK6google8protobuf19EnumValueDescriptor11DebugStringEiPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEERKNS0_18DebugStringOptionsE");

      procedure GetLocationPath (this : access constant EnumValueDescriptor; output : System.Address);  -- ../../../src/google/protobuf/descriptor.h:1040
      pragma Import (CPP, GetLocationPath, "_ZNK6google8protobuf19EnumValueDescriptor15GetLocationPathEPSt6vectorIiSaIiEE");

      function New_EnumValueDescriptor return EnumValueDescriptor;  -- ../../../src/google/protobuf/descriptor.h:1052
      pragma CPP_Constructor (New_EnumValueDescriptor, "_ZN6google8protobuf19EnumValueDescriptorC1Ev");

      procedure operator_as (this : access EnumValueDescriptor; arg2 : access constant EnumValueDescriptor);  -- ../../../src/google/protobuf/descriptor.h:1057
      pragma Import (CPP, operator_as, "_ZN6google8protobuf19EnumValueDescriptoraSERKS1_");
   end;
  use Class_EnumValueDescriptor;



--     type FieldDescriptor;
   type OptionsType is null record;
   pragma Convention (C_Pass_By_Copy, OptionsType);
--     type EnumValueDescriptor;




--     type ServiceDescriptor;
--     type OptionsType2 is null record;
--     pragma Convention (C_Pass_By_Copy, OptionsType2);
--     type MethodDescriptor;
   package Class_ServiceDescriptor is
      type ServiceDescriptor is limited record
         name_u : Interfaces_CPP.Strings.CPP_String_External;  -- ../../../src/google/protobuf/descriptor.h:1121
         full_name_u : Interfaces_CPP.Strings.CPP_String_External;  -- ../../../src/google/protobuf/descriptor.h:1122
         file_u : access constant FileDescriptor;  -- ../../../src/google/protobuf/descriptor.h:1123
         options_u : System.Address;  -- ../../../src/google/protobuf/descriptor.h:1124
         method_count_u : aliased int;  -- ../../../src/google/protobuf/descriptor.h:1125
         methods_u : access MethodDescriptor;  -- ../../../src/google/protobuf/descriptor.h:1126
      end record;
      pragma Import (CPP, ServiceDescriptor);

      function name (this : access constant ServiceDescriptor) return Interfaces_CPP.Strings.CPP_String_External;  -- ../../../src/google/protobuf/descriptor.h:1852
      pragma Import (CPP, name, "_ZNK6google8protobuf17ServiceDescriptor4nameB5cxx11Ev");

      function full_name (this : access constant ServiceDescriptor) return Interfaces_CPP.Strings.CPP_String_External;  -- ../../../src/google/protobuf/descriptor.h:1853
      pragma Import (CPP, full_name, "_ZNK6google8protobuf17ServiceDescriptor9full_nameB5cxx11Ev");

      function index (this : access constant ServiceDescriptor) return int;  -- ../../../src/google/protobuf/descriptor.h:1968
      pragma Import (CPP, index, "_ZNK6google8protobuf17ServiceDescriptor5indexEv");

      function file (this : access constant ServiceDescriptor) return access constant FileDescriptor;  -- ../../../src/google/protobuf/descriptor.h:1854
      pragma Import (CPP, file, "_ZNK6google8protobuf17ServiceDescriptor4fileEv");

      function options (this : access constant ServiceDescriptor) return System.Address;  -- ../../../src/google/protobuf/descriptor.h:1858
      pragma Import (CPP, options, "_ZNK6google8protobuf17ServiceDescriptor7optionsEv");

      function method_count (this : access constant ServiceDescriptor) return int;  -- ../../../src/google/protobuf/descriptor.h:1855
      pragma Import (CPP, method_count, "_ZNK6google8protobuf17ServiceDescriptor12method_countEv");

      function method (this : access constant ServiceDescriptor; index : int) return access constant MethodDescriptor;  -- ../../../src/google/protobuf/descriptor.h:1856
      pragma Import (CPP, method, "_ZNK6google8protobuf17ServiceDescriptor6methodEi");

      function FindMethodByName (this : access constant ServiceDescriptor; name : Interfaces_CPP.Strings.CPP_String_External) return access constant MethodDescriptor;  -- ../../../src/google/protobuf/descriptor.h:1090
      pragma Import (CPP, FindMethodByName, "_ZNK6google8protobuf17ServiceDescriptor16FindMethodByNameERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE");

      procedure CopyTo (this : access constant ServiceDescriptor; proto : System.Address);  -- ../../../src/google/protobuf/descriptor.h:1092
      pragma Import (CPP, CopyTo, "_ZNK6google8protobuf17ServiceDescriptor6CopyToEPNS0_22ServiceDescriptorProtoE");

      function DebugString (this : access constant ServiceDescriptor) return Interfaces_CPP.Strings.CPP_String_External;  -- ../../../src/google/protobuf/descriptor.h:1095
      pragma Import (CPP, DebugString, "_ZNK6google8protobuf17ServiceDescriptor11DebugStringB5cxx11Ev");

      function DebugStringWithOptions (this : access constant ServiceDescriptor; options : access constant DebugStringOptions) return Interfaces_CPP.Strings.CPP_String_External;  -- ../../../src/google/protobuf/descriptor.h:1098
      pragma Import (CPP, DebugStringWithOptions, "_ZNK6google8protobuf17ServiceDescriptor22DebugStringWithOptionsB5cxx11ERKNS0_18DebugStringOptionsE");

      function GetSourceLocation (this : access constant ServiceDescriptor; out_location : access SourceLocation) return Extensions.bool;  -- ../../../src/google/protobuf/descriptor.h:1106
      pragma Import (CPP, GetSourceLocation, "_ZNK6google8protobuf17ServiceDescriptor17GetSourceLocationEPNS0_14SourceLocationE");

      procedure DebugString2
        (this : access constant ServiceDescriptor;
         contents : Interfaces_CPP.Strings.CPP_String_External;
         options : access constant DebugStringOptions);  -- ../../../src/google/protobuf/descriptor.h:1115
      pragma Import (CPP, DebugString2, "_ZNK6google8protobuf17ServiceDescriptor11DebugStringEPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEERKNS0_18DebugStringOptionsE");

      procedure GetLocationPath (this : access constant ServiceDescriptor; output : System.Address);  -- ../../../src/google/protobuf/descriptor.h:1119
      pragma Import (CPP, GetLocationPath, "_ZNK6google8protobuf17ServiceDescriptor15GetLocationPathEPSt6vectorIiSaIiEE");

      function New_ServiceDescriptor return ServiceDescriptor;  -- ../../../src/google/protobuf/descriptor.h:1132
      pragma CPP_Constructor (New_ServiceDescriptor, "_ZN6google8protobuf17ServiceDescriptorC1Ev");

      procedure operator_as (this : access ServiceDescriptor; arg2 : access constant ServiceDescriptor);  -- ../../../src/google/protobuf/descriptor.h:1136
      pragma Import (CPP, operator_as, "_ZN6google8protobuf17ServiceDescriptoraSERKS1_");
   end;
   use Class_ServiceDescriptor;

   --  skipped empty struct StreamDescriptor

--     type DescriptorPool;
--     type ErrorCollector is record
--        null;
--     end record;
--     pragma Convention (C_Pass_By_Copy, ErrorCollector);
--     type Tables is null record;
--     pragma Convention (C_Pass_By_Copy, Tables);
  package Class_DescriptorPool is

       type PlaceholderType is
     (PLACEHOLDER_MESSAGE,
      PLACEHOLDER_ENUM,
      PLACEHOLDER_EXTENDABLE_MESSAGE);
   pragma Convention (C, PlaceholderType);
      type DescriptorPool is limited record
         mutex_u : access google.protobuf.binding.mutex_h.Class_Mutex.Mutex;  -- ../../../src/google/protobuf/descriptor.h:1735
         fallback_database_u : System.Address;  -- ../../../src/google/protobuf/descriptor.h:1738
         default_error_collector_u : System.Address;--access ErrorCollector;  -- ../../../src/google/protobuf/descriptor.h:1739
         underlay_u : access constant DescriptorPool;  -- ../../../src/google/protobuf/descriptor.h:1740
         tables_u : System.Address; --aliased google.protobuf.binding.scoped_ptr_h.Class_scoped_ptr.scoped_ptr;  -- ../../../src/google/protobuf/descriptor.h:1745
         enforce_dependencies_u : aliased Extensions.bool;  -- ../../../src/google/protobuf/descriptor.h:1747
         lazily_build_dependencies_u : aliased Extensions.bool;  -- ../../../src/google/protobuf/descriptor.h:1748
         allow_unknown_u : aliased Extensions.bool;  -- ../../../src/google/protobuf/descriptor.h:1749
         enforce_weak_u : aliased Extensions.bool;  -- ../../../src/google/protobuf/descriptor.h:1750
         unused_import_track_files_u : System.Address;  -- ../../../src/google/protobuf/descriptor.h:1751
         disallow_enforce_utf8_u : aliased Extensions.bool;  -- ../../../src/google/protobuf/descriptor.h:1752
      end record;
      pragma Import (CPP, DescriptorPool);

      function New_DescriptorPool return DescriptorPool;  -- ../../../src/google/protobuf/descriptor.h:1440
      pragma CPP_Constructor (New_DescriptorPool, "_ZN6google8protobuf14DescriptorPoolC1Ev");

      function New_DescriptorPool (fallback_database : System.Address; error_collector : System.Address) return DescriptorPool;  -- ../../../src/google/protobuf/descriptor.h:1466
      pragma CPP_Constructor (New_DescriptorPool, "_ZN6google8protobuf14DescriptorPoolC1EPNS0_18DescriptorDatabaseEPNS1_14ErrorCollectorE");

      procedure Delete_DescriptorPool (this : access DescriptorPool);  -- ../../../src/google/protobuf/descriptor.h:1469
      pragma Import (CPP, Delete_DescriptorPool, "_ZN6google8protobuf14DescriptorPoolD1Ev");

      function FindFileByName (this : access constant DescriptorPool; name : Interfaces_CPP.Strings.CPP_String_External) return access constant FileDescriptor;  -- ../../../src/google/protobuf/descriptor.h:1479
      pragma Import (CPP, FindFileByName, "_ZNK6google8protobuf14DescriptorPool14FindFileByNameERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE");

      function FindFileContainingSymbol (this : access constant DescriptorPool; symbol_name : Interfaces_CPP.Strings.CPP_String_External) return access constant FileDescriptor;  -- ../../../src/google/protobuf/descriptor.h:1485
      pragma Import (CPP, FindFileContainingSymbol, "_ZNK6google8protobuf14DescriptorPool24FindFileContainingSymbolERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE");

      function FindMessageTypeByName (this : access constant DescriptorPool; name : Interfaces_CPP.Strings.CPP_String_External) return access constant Descriptor;  -- ../../../src/google/protobuf/descriptor.h:1493
      pragma Import (CPP, FindMessageTypeByName, "_ZNK6google8protobuf14DescriptorPool21FindMessageTypeByNameERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE");

      function FindFieldByName (this : access constant DescriptorPool; name : Interfaces_CPP.Strings.CPP_String_External) return access constant FieldDescriptor;  -- ../../../src/google/protobuf/descriptor.h:1494
      pragma Import (CPP, FindFieldByName, "_ZNK6google8protobuf14DescriptorPool15FindFieldByNameERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE");

      function FindExtensionByName (this : access constant DescriptorPool; name : Interfaces_CPP.Strings.CPP_String_External) return access constant FieldDescriptor;  -- ../../../src/google/protobuf/descriptor.h:1495
      pragma Import (CPP, FindExtensionByName, "_ZNK6google8protobuf14DescriptorPool19FindExtensionByNameERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE");

      function FindOneofByName (this : access constant DescriptorPool; name : Interfaces_CPP.Strings.CPP_String_External) return access constant OneofDescriptor;  -- ../../../src/google/protobuf/descriptor.h:1496
      pragma Import (CPP, FindOneofByName, "_ZNK6google8protobuf14DescriptorPool15FindOneofByNameERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE");

      function FindEnumTypeByName (this : access constant DescriptorPool; name : Interfaces_CPP.Strings.CPP_String_External) return access constant EnumDescriptor;  -- ../../../src/google/protobuf/descriptor.h:1497
      pragma Import (CPP, FindEnumTypeByName, "_ZNK6google8protobuf14DescriptorPool18FindEnumTypeByNameERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE");

      function FindEnumValueByName (this : access constant DescriptorPool; name : Interfaces_CPP.Strings.CPP_String_External) return access constant EnumValueDescriptor;  -- ../../../src/google/protobuf/descriptor.h:1498
      pragma Import (CPP, FindEnumValueByName, "_ZNK6google8protobuf14DescriptorPool19FindEnumValueByNameERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE");

      function FindServiceByName (this : access constant DescriptorPool; name : Interfaces_CPP.Strings.CPP_String_External) return access constant ServiceDescriptor;  -- ../../../src/google/protobuf/descriptor.h:1499
      pragma Import (CPP, FindServiceByName, "_ZNK6google8protobuf14DescriptorPool17FindServiceByNameERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE");

      function FindMethodByName (this : access constant DescriptorPool; name : Interfaces_CPP.Strings.CPP_String_External) return access constant MethodDescriptor;  -- ../../../src/google/protobuf/descriptor.h:1500
      pragma Import (CPP, FindMethodByName, "_ZNK6google8protobuf14DescriptorPool16FindMethodByNameERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE");

      function FindExtensionByNumber
        (this : access constant DescriptorPool;
         extendee : access constant Descriptor;
         number : int) return access constant FieldDescriptor;  -- ../../../src/google/protobuf/descriptor.h:1504
      pragma Import (CPP, FindExtensionByNumber, "_ZNK6google8protobuf14DescriptorPool21FindExtensionByNumberEPKNS0_10DescriptorEi");

      procedure FindAllExtensions
        (this : access constant DescriptorPool;
         extendee : access constant Descriptor;
         c_out : System.Address);  -- ../../../src/google/protobuf/descriptor.h:1512
      pragma Import (CPP, FindAllExtensions, "_ZNK6google8protobuf14DescriptorPool17FindAllExtensionsEPKNS0_10DescriptorEPSt6vectorIPKNS0_15FieldDescriptorESaIS8_EE");

      function BuildFile (this : access DescriptorPool; proto : System.Address) return access constant FileDescriptor;  -- ../../../src/google/protobuf/descriptor.h:1570
      pragma Import (CPP, BuildFile, "_ZN6google8protobuf14DescriptorPool9BuildFileERKNS0_19FileDescriptorProtoE");

      function BuildFileCollectingErrors
        (this : access DescriptorPool;
         proto : System.Address;
         error_collector : System.Address) return access constant FileDescriptor;  -- ../../../src/google/protobuf/descriptor.h:1573
      pragma Import (CPP, BuildFileCollectingErrors, "_ZN6google8protobuf14DescriptorPool25BuildFileCollectingErrorsERKNS0_19FileDescriptorProtoEPNS1_14ErrorCollectorE");

      procedure AllowUnknownDependencies (this : access DescriptorPool);  -- ../../../src/google/protobuf/descriptor.h:1592
      pragma Import (CPP, AllowUnknownDependencies, "_ZN6google8protobuf14DescriptorPool24AllowUnknownDependenciesEv");

      procedure EnforceWeakDependencies (this : access DescriptorPool; enforce : Extensions.bool);  -- ../../../src/google/protobuf/descriptor.h:1598
      pragma Import (CPP, EnforceWeakDependencies, "_ZN6google8protobuf14DescriptorPool23EnforceWeakDependenciesEb");

      function New_DescriptorPool (underlay : access constant DescriptorPool) return DescriptorPool;  -- ../../../src/google/protobuf/descriptor.h:1625
      pragma CPP_Constructor (New_DescriptorPool, "_ZN6google8protobuf14DescriptorPoolC1EPKS1_");

      procedure DisallowEnforceUtf8 (this : access DescriptorPool);  -- ../../../src/google/protobuf/descriptor.h:1634
      pragma Import (CPP, DisallowEnforceUtf8, "_ZN6google8protobuf14DescriptorPool19DisallowEnforceUtf8Ev");

      procedure InternalDontEnforceDependencies (this : access DescriptorPool);  -- ../../../src/google/protobuf/descriptor.h:1646
      pragma Import (CPP, InternalDontEnforceDependencies, "_ZN6google8protobuf14DescriptorPool31InternalDontEnforceDependenciesEv");

      procedure InternalSetLazilyBuildDependencies (this : access DescriptorPool);  -- ../../../src/google/protobuf/descriptor.h:1656
      pragma Import (CPP, InternalSetLazilyBuildDependencies, "_ZN6google8protobuf14DescriptorPool34InternalSetLazilyBuildDependenciesEv");

      procedure internal_set_underlay (this : access DescriptorPool; underlay : access constant DescriptorPool);  -- ../../../src/google/protobuf/descriptor.h:1664
      pragma Import (CPP, internal_set_underlay, "_ZN6google8protobuf14DescriptorPool21internal_set_underlayEPKS1_");

      function InternalIsFileLoaded (this : access constant DescriptorPool; filename : Interfaces_CPP.Strings.CPP_String_External) return Extensions.bool;  -- ../../../src/google/protobuf/descriptor.h:1671
      pragma Import (CPP, InternalIsFileLoaded, "_ZNK6google8protobuf14DescriptorPool20InternalIsFileLoadedERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE");

      procedure AddUnusedImportTrackFile (this : access DescriptorPool; file_name : Interfaces_CPP.Strings.CPP_String_External);  -- ../../../src/google/protobuf/descriptor.h:1676
      pragma Import (CPP, AddUnusedImportTrackFile, "_ZN6google8protobuf14DescriptorPool24AddUnusedImportTrackFileERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE");

      procedure ClearUnusedImportTrackFiles (this : access DescriptorPool);  -- ../../../src/google/protobuf/descriptor.h:1677
      pragma Import (CPP, ClearUnusedImportTrackFiles, "_ZN6google8protobuf14DescriptorPool27ClearUnusedImportTrackFilesEv");

      function IsSubSymbolOfBuiltType (this : access constant DescriptorPool; name : Interfaces_CPP.Strings.CPP_String_External) return Extensions.bool;  -- ../../../src/google/protobuf/descriptor.h:1694
      pragma Import (CPP, IsSubSymbolOfBuiltType, "_ZNK6google8protobuf14DescriptorPool22IsSubSymbolOfBuiltTypeERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE");

      function TryFindFileInFallbackDatabase (this : access constant DescriptorPool; name : Interfaces_CPP.Strings.CPP_String_External) return Extensions.bool;  -- ../../../src/google/protobuf/descriptor.h:1700
      pragma Import (CPP, TryFindFileInFallbackDatabase, "_ZNK6google8protobuf14DescriptorPool29TryFindFileInFallbackDatabaseERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE");

      function TryFindSymbolInFallbackDatabase (this : access constant DescriptorPool; name : Interfaces_CPP.Strings.CPP_String_External) return Extensions.bool;  -- ../../../src/google/protobuf/descriptor.h:1701
      pragma Import (CPP, TryFindSymbolInFallbackDatabase, "_ZNK6google8protobuf14DescriptorPool31TryFindSymbolInFallbackDatabaseERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE");

      function TryFindExtensionInFallbackDatabase
        (this : access constant DescriptorPool;
         containing_type : access constant Descriptor;
         field_number : int) return Extensions.bool;  -- ../../../src/google/protobuf/descriptor.h:1702
      pragma Import (CPP, TryFindExtensionInFallbackDatabase, "_ZNK6google8protobuf14DescriptorPool34TryFindExtensionInFallbackDatabaseEPKNS0_10DescriptorEi");

      function BuildFileFromDatabase (this : access constant DescriptorPool; proto : System.Address) return access constant FileDescriptor;  -- ../../../src/google/protobuf/descriptor.h:1708
      pragma Import (CPP, BuildFileFromDatabase, "_ZNK6google8protobuf14DescriptorPool21BuildFileFromDatabaseERKNS0_19FileDescriptorProtoE");

      function CrossLinkOnDemandHelper
        (this : access constant DescriptorPool;
         name : Interfaces_CPP.Strings.CPP_String_External;
         expecting_enum : Extensions.bool) return Symbol;  -- ../../../src/google/protobuf/descriptor.h:1716
      pragma Import (CPP, CrossLinkOnDemandHelper, "_ZNK6google8protobuf14DescriptorPool23CrossLinkOnDemandHelperERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEb");

      function NewPlaceholderFile (this : access constant DescriptorPool; name : Interfaces_CPP.Strings.CPP_String_External) return access FileDescriptor;  -- ../../../src/google/protobuf/descriptor.h:1719
      pragma Import (CPP, NewPlaceholderFile, "_ZNK6google8protobuf14DescriptorPool18NewPlaceholderFileERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE");

      function NewPlaceholderFileWithMutexHeld (this : access constant DescriptorPool; name : Interfaces_CPP.Strings.CPP_String_External) return access FileDescriptor;  -- ../../../src/google/protobuf/descriptor.h:1720
      pragma Import (CPP, NewPlaceholderFileWithMutexHeld, "_ZNK6google8protobuf14DescriptorPool31NewPlaceholderFileWithMutexHeldERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE");

      function NewPlaceholder
        (this : access constant DescriptorPool;
         name : Interfaces_CPP.Strings.CPP_String_External;
         placeholder_type : PlaceholderType) return Symbol;  -- ../../../src/google/protobuf/descriptor.h:1728
      pragma Import (CPP, NewPlaceholder, "_ZNK6google8protobuf14DescriptorPool14NewPlaceholderERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEENS1_15PlaceholderTypeE");

      function NewPlaceholderWithMutexHeld
        (this : access constant DescriptorPool;
         name : Interfaces_CPP.Strings.CPP_String_External;
         placeholder_type : PlaceholderType) return Symbol;  -- ../../../src/google/protobuf/descriptor.h:1730
      pragma Import (CPP, NewPlaceholderWithMutexHeld, "_ZNK6google8protobuf14DescriptorPool27NewPlaceholderWithMutexHeldERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEENS1_15PlaceholderTypeE");

      procedure operator_as (this : access DescriptorPool; arg2 : access constant DescriptorPool);  -- ../../../src/google/protobuf/descriptor.h:1754
      pragma Import (CPP, operator_as, "_ZN6google8protobuf14DescriptorPoolaSERKS1_");

      package Static is
         function generated_pool return access constant DescriptorPool;  -- ../../../src/google/protobuf/descriptor.h:1474
         pragma Import (CPP, generated_pool, "_ZN6google8protobuf14DescriptorPool14generated_poolEv");

         procedure InternalAddGeneratedFile (encoded_file_descriptor : System.Address; size : int);  -- ../../../src/google/protobuf/descriptor.h:1630
         pragma Import (CPP, InternalAddGeneratedFile, "_ZN6google8protobuf14DescriptorPool24InternalAddGeneratedFileEPKvi");

         function internal_generated_pool return access DescriptorPool;  -- ../../../src/google/protobuf/descriptor.h:1641
         pragma Import (CPP, internal_generated_pool, "_ZN6google8protobuf14DescriptorPool23internal_generated_poolEv");
      end;

      function generated_pool return access constant DescriptorPool renames Static.generated_pool;

      procedure InternalAddGeneratedFile (encoded_file_descriptor : System.Address; size : int) renames Static.InternalAddGeneratedFile;

      function internal_generated_pool return access DescriptorPool renames Static.internal_generated_pool;
   end;
   use Class_DescriptorPool;
end google.protobuf.binding.descriptor_h;
