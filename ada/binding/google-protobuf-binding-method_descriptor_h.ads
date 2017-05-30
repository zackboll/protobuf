pragma Ada_2005;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with Interfaces.C.Extensions;
with Interfaces_CPP.Strings;
with System;

--  with google.protobuf.binding.lazy_descriptor_h;
limited with google.protobuf.binding.descriptor_h;

package google.protobuf.binding.method_descriptor_h is

--    use google.protobuf.binding.lazy_descriptor_h.Class_LazyDescriptor;

   package Class_MethodDescriptor is
      type MethodDescriptor is limited record
         name_u : Interfaces_CPP.Strings.CPP_String_External;  -- ../../../src/google/protobuf/descriptor.h:1203
         full_name_u : Interfaces_CPP.Strings.CPP_String_External;  -- ../../../src/google/protobuf/descriptor.h:1204
         service_u : access constant google.protobuf.binding.descriptor_h.Class_ServiceDescriptor.ServiceDescriptor;  -- ../../../src/google/protobuf/descriptor.h:1205
         input_type_u : System.Address;--aliased LazyDescriptor;  -- ../../../src/google/protobuf/descriptor.h:1206
         output_type_u : System.Address;-- aliased LazyDescriptor;  -- ../../../src/google/protobuf/descriptor.h:1207
         options_u : System.Address;  -- ../../../src/google/protobuf/descriptor.h:1208
         client_streaming_u : aliased Extensions.bool;  -- ../../../src/google/protobuf/descriptor.h:1209
         server_streaming_u : aliased Extensions.bool;  -- ../../../src/google/protobuf/descriptor.h:1210
      end record;
      pragma Import (CPP, MethodDescriptor);

      function name (this : access constant MethodDescriptor) return Interfaces_CPP.Strings.CPP_String_External;  -- ../../../src/google/protobuf/descriptor.h:1860
      pragma Import (CPP, name, "_ZNK6google8protobuf16MethodDescriptor4nameB5cxx11Ev");

      function full_name (this : access constant MethodDescriptor) return Interfaces_CPP.Strings.CPP_String_External;  -- ../../../src/google/protobuf/descriptor.h:1861
      pragma Import (CPP, full_name, "_ZNK6google8protobuf16MethodDescriptor9full_nameB5cxx11Ev");

      function index (this : access constant MethodDescriptor) return int;  -- ../../../src/google/protobuf/descriptor.h:1972
      pragma Import (CPP, index, "_ZNK6google8protobuf16MethodDescriptor5indexEv");

      function service (this : access constant MethodDescriptor) return access constant google.protobuf.binding.descriptor_h.Class_ServiceDescriptor.ServiceDescriptor;  -- ../../../src/google/protobuf/descriptor.h:1862
      pragma Import (CPP, service, "_ZNK6google8protobuf16MethodDescriptor7serviceEv");

      function input_type (this : access constant MethodDescriptor) return access constant google.protobuf.binding.descriptor_h.Class_Descriptor.Descriptor;  -- ../../../src/google/protobuf/descriptor.h:1156
      pragma Import (CPP, input_type, "_ZNK6google8protobuf16MethodDescriptor10input_typeEv");

      function output_type (this : access constant MethodDescriptor) return access constant google.protobuf.binding.descriptor_h.Class_Descriptor.Descriptor;  -- ../../../src/google/protobuf/descriptor.h:1158
      pragma Import (CPP, output_type, "_ZNK6google8protobuf16MethodDescriptor11output_typeEv");

      function client_streaming (this : access constant MethodDescriptor) return Extensions.bool;  -- ../../../src/google/protobuf/descriptor.h:1864
      pragma Import (CPP, client_streaming, "_ZNK6google8protobuf16MethodDescriptor16client_streamingEv");

      function server_streaming (this : access constant MethodDescriptor) return Extensions.bool;  -- ../../../src/google/protobuf/descriptor.h:1865
      pragma Import (CPP, server_streaming, "_ZNK6google8protobuf16MethodDescriptor16server_streamingEv");

      function options (this : access constant MethodDescriptor) return System.Address;  -- ../../../src/google/protobuf/descriptor.h:1863
      pragma Import (CPP, options, "_ZNK6google8protobuf16MethodDescriptor7optionsEv");

      procedure CopyTo (this : access constant MethodDescriptor; proto : System.Address);  -- ../../../src/google/protobuf/descriptor.h:1173
      pragma Import (CPP, CopyTo, "_ZNK6google8protobuf16MethodDescriptor6CopyToEPNS0_21MethodDescriptorProtoE");

      function DebugString (this : access constant MethodDescriptor) return Interfaces_CPP.Strings.CPP_String_External;  -- ../../../src/google/protobuf/descriptor.h:1176
      pragma Import (CPP, DebugString, "_ZNK6google8protobuf16MethodDescriptor11DebugStringB5cxx11Ev");

      function DebugStringWithOptions (this : access constant MethodDescriptor; options : access constant google.protobuf.binding.descriptor_h.Class_DebugStringOptions.DebugStringOptions) return Interfaces_CPP.Strings.CPP_String_External;  -- ../../../src/google/protobuf/descriptor.h:1179
      pragma Import (CPP, DebugStringWithOptions, "_ZNK6google8protobuf16MethodDescriptor22DebugStringWithOptionsB5cxx11ERKNS0_18DebugStringOptionsE");

      function GetSourceLocation (this : access constant MethodDescriptor; out_location : access google.protobuf.binding.descriptor_h.Class_SourceLocation.SourceLocation) return Extensions.bool;  -- ../../../src/google/protobuf/descriptor.h:1187
      pragma Import (CPP, GetSourceLocation, "_ZNK6google8protobuf16MethodDescriptor17GetSourceLocationEPNS0_14SourceLocationE");

      procedure DebugString2
        (this : access constant MethodDescriptor;
         depth : int;
         contents : Interfaces_CPP.Strings.CPP_String_External;
         options : access constant google.protobuf.binding.descriptor_h.Class_DebugStringOptions.DebugStringOptions);  -- ../../../src/google/protobuf/descriptor.h:1196
      pragma Import (CPP, DebugString2, "_ZNK6google8protobuf16MethodDescriptor11DebugStringEiPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEERKNS0_18DebugStringOptionsE");

      procedure GetLocationPath (this : access constant MethodDescriptor; output : System.Address);  -- ../../../src/google/protobuf/descriptor.h:1201
      pragma Import (CPP, GetLocationPath, "_ZNK6google8protobuf16MethodDescriptor15GetLocationPathEPSt6vectorIiSaIiEE");

      function New_MethodDescriptor return MethodDescriptor;  -- ../../../src/google/protobuf/descriptor.h:1216
      pragma CPP_Constructor (New_MethodDescriptor, "_ZN6google8protobuf16MethodDescriptorC1Ev");

      procedure operator_as (this : access MethodDescriptor; arg2 : access constant MethodDescriptor);  -- ../../../src/google/protobuf/descriptor.h:1219
      pragma Import (CPP, operator_as, "_ZN6google8protobuf16MethodDescriptoraSERKS1_");
   end;

end google.protobuf.binding.method_descriptor_h;
