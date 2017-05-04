pragma Ada_2005;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with Interfaces.C.Strings;
with Interfaces.C.Extensions;
with System;
package google.protobuf.common_h is

   PROTOBUF_USE_EXCEPTIONS : constant := 1;  --  ../../src/google/protobuf/stubs/common.h:59

   GOOGLE_PROTOBUF_VERSION : constant := 3003000;  --  ../../src/google/protobuf/stubs/common.h:104

   GOOGLE_PROTOBUF_VERSION_SUFFIX : aliased constant String := "" & ASCII.NUL;  --  ../../src/google/protobuf/stubs/common.h:107

   GOOGLE_PROTOBUF_MIN_LIBRARY_VERSION : constant := 3003000;  --  ../../src/google/protobuf/stubs/common.h:111

   GOOGLE_PROTOBUF_MIN_PROTOC_VERSION : constant := 3003000;  --  ../../src/google/protobuf/stubs/common.h:120
   --  unsupported macro: GOOGLE_PROTOBUF_VERIFY_VERSION ::google::protobuf::internal::VerifyVersion( GOOGLE_PROTOBUF_VERSION, GOOGLE_PROTOBUF_MIN_LIBRARY_VERSION, __FILE__)

   kMinHeaderVersionForLibrary : aliased int;  -- ../../src/google/protobuf/stubs/common.h:116
   pragma Import (CPP, kMinHeaderVersionForLibrary, "_ZN6google8protobuf8internalL27kMinHeaderVersionForLibraryE");

   kMinHeaderVersionForProtoc : aliased int;  -- ../../src/google/protobuf/stubs/common.h:124
   pragma Import (CPP, kMinHeaderVersionForProtoc, "_ZN6google8protobuf8internalL26kMinHeaderVersionForProtocE");

   procedure VerifyVersion
     (headerVersion : int;
      minLibraryVersion : int;
      filename : Interfaces.C.Strings.chars_ptr);  -- ../../src/google/protobuf/stubs/common.h:128
   pragma Import (CPP, VerifyVersion, "_ZN6google8protobuf8internal13VerifyVersionEiiPKc");

   function IsStructurallyValidUTF8 (buf : Interfaces.C.Strings.chars_ptr; len : int) return Extensions.bool;  -- ../../src/google/protobuf/stubs/common.h:154
   pragma Import (CPP, IsStructurallyValidUTF8, "_ZN6google8protobuf8internal23IsStructurallyValidUTF8EPKci");

   function UTF8SpnStructurallyValid (str : System.Address) return int;  -- ../../src/google/protobuf/stubs/common.h:161
   pragma Import (CPP, UTF8SpnStructurallyValid, "_ZN6google8protobuf8internal24UTF8SpnStructurallyValidERKNS0_11StringPieceE");

   function UTF8CoerceToStructurallyValid
     (str : System.Address;
      dst : Interfaces.C.Strings.chars_ptr;
      replace_char : char) return Interfaces.C.Strings.chars_ptr;  -- ../../src/google/protobuf/stubs/common.h:175
   pragma Import (CPP, UTF8CoerceToStructurallyValid, "_ZN6google8protobuf8internal29UTF8CoerceToStructurallyValidERKNS0_11StringPieceEPcc");

   procedure ShutdownProtobufLibrary;  -- ../../src/google/protobuf/stubs/common.h:197
   pragma Import (CPP, ShutdownProtobufLibrary, "_ZN6google8protobuf23ShutdownProtobufLibraryEv");

   procedure OnShutdown (func : access procedure);  -- ../../src/google/protobuf/stubs/common.h:202
   pragma Import (CPP, OnShutdown, "_ZN6google8protobuf8internal10OnShutdownEPFvvE");

end google.protobuf.common_h;
