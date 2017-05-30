pragma Ada_2005;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with Interfaces.C.Extensions;
with Interfaces_CPP.Strings;
with System;

limited with google.protobuf.binding.descriptor_h;
limited with google.protobuf.binding.file_descriptor_h;

package google.protobuf.binding.enum_descriptor_h is

   package Class_EnumDescriptor is
      type EnumDescriptor is limited record
         name_u : Interfaces_CPP.Strings.CPP_String_External;  -- ../../../src/google/protobuf/descriptor.h:954
         full_name_u : Interfaces_CPP.Strings.CPP_String_External;  -- ../../../src/google/protobuf/descriptor.h:955
         file_u : access constant google.protobuf.binding.file_descriptor_h.Class_FileDescriptor.FileDescriptor;  -- ../../../src/google/protobuf/descriptor.h:956
         containing_type_u : access constant google.protobuf.binding.descriptor_h.Class_Descriptor.Descriptor;  -- ../../../src/google/protobuf/descriptor.h:957
         options_u : System.Address;  -- ../../../src/google/protobuf/descriptor.h:958
         is_placeholder_u : aliased Extensions.bool;  -- ../../../src/google/protobuf/descriptor.h:961
         is_unqualified_placeholder_u : aliased Extensions.bool;  -- ../../../src/google/protobuf/descriptor.h:963
         value_count_u : aliased int;  -- ../../../src/google/protobuf/descriptor.h:965
         values_u : access google.protobuf.binding.descriptor_h.Class_EnumValueDescriptor.EnumValueDescriptor;  -- ../../../src/google/protobuf/descriptor.h:966
      end record;
      pragma Import (CPP, EnumDescriptor);

      function name (this : access constant EnumDescriptor) return Interfaces_CPP.Strings.CPP_String_External;  -- ../../../src/google/protobuf/descriptor.h:1836
      pragma Import (CPP, name, "_ZNK6google8protobuf14EnumDescriptor4nameB5cxx11Ev");

      function full_name (this : access constant EnumDescriptor) return Interfaces_CPP.Strings.CPP_String_External;  -- ../../../src/google/protobuf/descriptor.h:1837
      pragma Import (CPP, full_name, "_ZNK6google8protobuf14EnumDescriptor9full_nameB5cxx11Ev");

      function index (this : access constant EnumDescriptor) return int;  -- ../../../src/google/protobuf/descriptor.h:1956
      pragma Import (CPP, index, "_ZNK6google8protobuf14EnumDescriptor5indexEv");

      function file (this : access constant EnumDescriptor) return access constant google.protobuf.binding.file_descriptor_h.Class_FileDescriptor.FileDescriptor;  -- ../../../src/google/protobuf/descriptor.h:1838
      pragma Import (CPP, file, "_ZNK6google8protobuf14EnumDescriptor4fileEv");

      function value_count (this : access constant EnumDescriptor) return int;  -- ../../../src/google/protobuf/descriptor.h:1840
      pragma Import (CPP, value_count, "_ZNK6google8protobuf14EnumDescriptor11value_countEv");

      function value (this : access constant EnumDescriptor; index : int) return access constant google.protobuf.binding.descriptor_h.Class_EnumValueDescriptor.EnumValueDescriptor;  -- ../../../src/google/protobuf/descriptor.h:1841
      pragma Import (CPP, value, "_ZNK6google8protobuf14EnumDescriptor5valueEi");

      function FindValueByName (this : access constant EnumDescriptor; name : Interfaces_CPP.Strings.CPP_String_External) return access constant google.protobuf.binding.descriptor_h.Class_EnumValueDescriptor.EnumValueDescriptor;  -- ../../../src/google/protobuf/descriptor.h:891
      pragma Import (CPP, FindValueByName, "_ZNK6google8protobuf14EnumDescriptor15FindValueByNameERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE");

      function FindValueByNumber (this : access constant EnumDescriptor; number : int) return access constant google.protobuf.binding.descriptor_h.Class_EnumValueDescriptor.EnumValueDescriptor;  -- ../../../src/google/protobuf/descriptor.h:894
      pragma Import (CPP, FindValueByNumber, "_ZNK6google8protobuf14EnumDescriptor17FindValueByNumberEi");

      function containing_type (this : access constant EnumDescriptor) return access constant google.protobuf.binding.descriptor_h.Class_Descriptor.Descriptor;  -- ../../../src/google/protobuf/descriptor.h:1839
      pragma Import (CPP, containing_type, "_ZNK6google8protobuf14EnumDescriptor15containing_typeEv");

      function options (this : access constant EnumDescriptor) return System.Address;  -- ../../../src/google/protobuf/descriptor.h:1843
      pragma Import (CPP, options, "_ZNK6google8protobuf14EnumDescriptor7optionsEv");

      procedure CopyTo (this : access constant EnumDescriptor; proto : System.Address);  -- ../../../src/google/protobuf/descriptor.h:907
      pragma Import (CPP, CopyTo, "_ZNK6google8protobuf14EnumDescriptor6CopyToEPNS0_19EnumDescriptorProtoE");

      function DebugString (this : access constant EnumDescriptor) return Interfaces_CPP.Strings.CPP_String_External;  -- ../../../src/google/protobuf/descriptor.h:910
      pragma Import (CPP, DebugString, "_ZNK6google8protobuf14EnumDescriptor11DebugStringB5cxx11Ev");

      function DebugStringWithOptions (this : access constant EnumDescriptor; options : access constant google.protobuf.binding.descriptor_h.Class_DebugStringOptions.DebugStringOptions) return Interfaces_CPP.Strings.CPP_String_External;  -- ../../../src/google/protobuf/descriptor.h:913
      pragma Import (CPP, DebugStringWithOptions, "_ZNK6google8protobuf14EnumDescriptor22DebugStringWithOptionsB5cxx11ERKNS0_18DebugStringOptionsE");

      function is_placeholder (this : access constant EnumDescriptor) return Extensions.bool;  -- ../../../src/google/protobuf/descriptor.h:1844
      pragma Import (CPP, is_placeholder, "_ZNK6google8protobuf14EnumDescriptor14is_placeholderEv");

      function GetSourceLocation (this : access constant EnumDescriptor; out_location : access google.protobuf.binding.descriptor_h.Class_SourceLocation.SourceLocation) return Extensions.bool;  -- ../../../src/google/protobuf/descriptor.h:926
      pragma Import (CPP, GetSourceLocation, "_ZNK6google8protobuf14EnumDescriptor17GetSourceLocationEPNS0_14SourceLocationE");

      function FindValueByNumberCreatingIfUnknown (this : access constant EnumDescriptor; number : int) return access constant google.protobuf.binding.descriptor_h.Class_EnumValueDescriptor.EnumValueDescriptor;  -- ../../../src/google/protobuf/descriptor.h:943
      pragma Import (CPP, FindValueByNumberCreatingIfUnknown, "_ZNK6google8protobuf14EnumDescriptor34FindValueByNumberCreatingIfUnknownEi");

      procedure DebugString2
        (this : access constant EnumDescriptor;
         depth : int;
         contents : Interfaces_CPP.Strings.CPP_String_External;
         options : access constant google.protobuf.binding.descriptor_h.Class_DebugStringOptions.DebugStringOptions);  -- ../../../src/google/protobuf/descriptor.h:947
      pragma Import (CPP, DebugString2, "_ZNK6google8protobuf14EnumDescriptor11DebugStringEiPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEERKNS0_18DebugStringOptionsE");

      procedure GetLocationPath (this : access constant EnumDescriptor; output : System.Address);  -- ../../../src/google/protobuf/descriptor.h:952
      pragma Import (CPP, GetLocationPath, "_ZNK6google8protobuf14EnumDescriptor15GetLocationPathEPSt6vectorIiSaIiEE");

      function New_EnumDescriptor return EnumDescriptor;  -- ../../../src/google/protobuf/descriptor.h:972
      pragma CPP_Constructor (New_EnumDescriptor, "_ZN6google8protobuf14EnumDescriptorC1Ev");

      procedure operator_as (this : access EnumDescriptor; arg2 : access constant EnumDescriptor);  -- ../../../src/google/protobuf/descriptor.h:980
      pragma Import (CPP, operator_as, "_ZN6google8protobuf14EnumDescriptoraSERKS1_");
   end;

end google.protobuf.binding.enum_descriptor_h;
