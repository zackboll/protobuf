pragma Ada_2005;
pragma Style_Checks (Off);

with Interfaces_CPP.Strings;

with google.protobuf.binding.once_h;

limited with google.protobuf.binding.descriptor_h;
limited with google.protobuf.binding.file_descriptor_h;

package google.protobuf.binding.lazy_descriptor_h is

   package Class_LazyDescriptor is
      type LazyDescriptor is limited record
         descriptor_u : access constant google.protobuf.binding.descriptor_h.Class_Descriptor.Descriptor;  -- ../../../src/google/protobuf/descriptor.h:212
         name_u : Interfaces_CPP.Strings.CPP_String_External;--Interfaces_CPP.Strings.CPP_String_External;--access constant google.protobuf.binding.cpp_6_2_1_bits_stringfwd_h.Class_string.string;  -- ../../../src/google/protobuf/descriptor.h:213
         once_u : access google.protobuf.binding.once_h.Class_GoogleOnceDynamic.GoogleOnceDynamic;  -- ../../../src/google/protobuf/descriptor.h:214
         file_u : access constant google.protobuf.binding.file_descriptor_h.Class_FileDescriptor.FileDescriptor;  -- ../../../src/google/protobuf/descriptor.h:215
      end record;
      pragma Import (CPP, LazyDescriptor);

      procedure Init (this : access LazyDescriptor);  -- ../../../src/google/protobuf/descriptor.h:179
      pragma Import (CPP, Init, "_ZN6google8protobuf8internal14LazyDescriptor4InitEv");

      procedure Set (this : access LazyDescriptor; the_descriptor : access constant google.protobuf.binding.descriptor_h.Class_Descriptor.Descriptor);  -- ../../../src/google/protobuf/descriptor.h:190
      pragma Import (CPP, Set, "_ZN6google8protobuf8internal14LazyDescriptor3SetEPKNS0_10DescriptorE");

      procedure SetLazy
        (this : access LazyDescriptor;
         name : Interfaces_CPP.Strings.CPP_String_External;--access constant google.protobuf.binding.cpp_6_2_1_bits_stringfwd_h.Class_string.string;
         file : access constant google.protobuf.binding.file_descriptor_h.Class_FileDescriptor.FileDescriptor);  -- ../../../src/google/protobuf/descriptor.h:197
      pragma Import (CPP, SetLazy, "_ZN6google8protobuf8internal14LazyDescriptor7SetLazyERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEPKNS0_14FileDescriptorE");

      function Get (this : access LazyDescriptor) return access constant google.protobuf.binding.descriptor_h.Class_Descriptor.Descriptor;  -- ../../../src/google/protobuf/descriptor.h:202
      pragma Import (CPP, Get, "_ZN6google8protobuf8internal14LazyDescriptor3GetEv");

      procedure OnceInternal (this : access LazyDescriptor);  -- ../../../src/google/protobuf/descriptor.h:209
      pragma Import (CPP, OnceInternal, "_ZN6google8protobuf8internal14LazyDescriptor12OnceInternalEv");

      procedure Once (this : access LazyDescriptor);  -- ../../../src/google/protobuf/descriptor.h:210
      pragma Import (CPP, Once, "_ZN6google8protobuf8internal14LazyDescriptor4OnceEv");

      package Static is
         procedure OnceStatic (lazy : access LazyDescriptor);  -- ../../../src/google/protobuf/descriptor.h:208
         pragma Import (CPP, OnceStatic, "_ZN6google8protobuf8internal14LazyDescriptor10OnceStaticEPS2_");
      end;

      procedure OnceStatic (lazy : access LazyDescriptor) renames Static.OnceStatic;
  end;

end google.protobuf.binding.lazy_descriptor_h;
