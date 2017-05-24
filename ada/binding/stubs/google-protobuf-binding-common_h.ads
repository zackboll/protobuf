pragma Ada_2005;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with Interfaces.C.Strings;
with Interfaces.C.Extensions;
with System;
with google.protobuf.binding.cpp_exception;

with Interfaces_CPP.Strings;

package google.protobuf.binding.common_h is

   PROTOBUF_USE_EXCEPTIONS : constant := 1;  --  ../../../src/google/protobuf/stubs/common.h:59

   GOOGLE_PROTOBUF_VERSION : constant := 3003000;  --  ../../../src/google/protobuf/stubs/common.h:104

   GOOGLE_PROTOBUF_VERSION_SUFFIX : aliased constant String := "" & ASCII.NUL;  --  ../../../src/google/protobuf/stubs/common.h:107

   GOOGLE_PROTOBUF_MIN_LIBRARY_VERSION : constant := 3003000;  --  ../../../src/google/protobuf/stubs/common.h:111

   GOOGLE_PROTOBUF_MIN_PROTOC_VERSION : constant := 3003000;  --  ../../../src/google/protobuf/stubs/common.h:120
   --  unsupported macro: GOOGLE_PROTOBUF_VERIFY_VERSION ::google::protobuf::internal::VerifyVersion( GOOGLE_PROTOBUF_VERSION, GOOGLE_PROTOBUF_MIN_LIBRARY_VERSION, __FILE__)

  -- Protocol Buffers - Google's data interchange format
  -- Copyright 2008 Google Inc.  All rights reserved.
  -- https://developers.google.com/protocol-buffers/
  -- Redistribution and use in source and binary forms, with or without
  -- modification, are permitted provided that the following conditions are
  -- met:
  --     * Redistributions of source code must retain the above copyright
  -- notice, this list of conditions and the following disclaimer.
  --     * Redistributions in binary form must reproduce the above
  -- copyright notice, this list of conditions and the following disclaimer
  -- in the documentation and/or other materials provided with the
  -- distribution.
  --     * Neither the name of Google Inc. nor the names of its
  -- contributors may be used to endorse or promote products derived from
  -- this software without specific prior written permission.
  -- THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
  -- "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
  -- LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
  -- A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
  -- OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
  -- SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
  -- LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
  -- DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
  -- THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  -- (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
  -- OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  -- Author: kenton@google.com (Kenton Varda) and others
  -- Contains basic types and utilities used by the rest of the library.
  -- TODO(liujisi): Remove the following includes after the include clean-up.
  -- Allow GetMessage to be used as a valid method name in protobuf classes.
  -- windows.h defines GetMessage() as a macro.  Let's re-define it as an inline
  -- function.  The inline function should be equivalent for C++ users.
  -- Some of these constants are macros rather than const ints so that they can
  -- be used in #if directives.
  -- The current version, represented as a single integer to make comparison
  -- easier:  major * 10^6 + minor * 10^3 + micro
  -- A suffix string for alpha, beta or rc releases. Empty for stable releases.
  -- The minimum library version which works with the current version of the
  -- headers.
  -- The minimum header version which works with the current version of
  -- the library.  This constant should only be used by protoc's C++ code
  -- generator.
   kMinHeaderVersionForLibrary : aliased int;  -- ../../../src/google/protobuf/stubs/common.h:116
   pragma Import (CPP, kMinHeaderVersionForLibrary, "_ZN6google8protobuf8internalL27kMinHeaderVersionForLibraryE");

  -- The minimum protoc version which works with the current version of the
  -- headers.
  -- The minimum header version which works with the current version of
  -- protoc.  This constant should only be used in VerifyVersion().
   kMinHeaderVersionForProtoc : aliased int;  -- ../../../src/google/protobuf/stubs/common.h:124
   pragma Import (CPP, kMinHeaderVersionForProtoc, "_ZN6google8protobuf8internalL26kMinHeaderVersionForProtocE");

  -- Verifies that the headers and libraries are compatible.  Use the macro
  -- below to call this.
   procedure VerifyVersion
     (headerVersion : int;
      minLibraryVersion : int;
      filename : Interfaces.C.Strings.chars_ptr);  -- ../../../src/google/protobuf/stubs/common.h:128
   pragma Import (CPP, VerifyVersion, "_ZN6google8protobuf8internal13VerifyVersionEiiPKc");

  -- Converts a numeric version number to a string.
--     function VersionString (version : int) return google.protobuf.binding.cpp_6_2_1_bits_stringfwd_h.Class_string.string;  -- ../../../src/google/protobuf/stubs/common.h:132
--     pragma Import (CPP, VersionString, "_ZN6google8protobuf8internal13VersionStringB5cxx11Ei");

  -- namespace internal
  -- Place this macro in your main() function (or somewhere before you attempt
  -- to use the protobuf library) to verify that the version you link against
  -- matches the headers you compiled against.  If a version mismatch is
  -- detected, the process will abort.
  -- ===================================================================
  -- from google3/util/utf8/public/unilib.h
  -- Checks if the buffer contains structurally-valid UTF-8.  Implemented in
  -- structurally_valid.cc.
   function IsStructurallyValidUTF8 (buf : Interfaces.C.Strings.chars_ptr; len : int) return Extensions.bool;  -- ../../../src/google/protobuf/stubs/common.h:154
   pragma Import (CPP, IsStructurallyValidUTF8, "_ZN6google8protobuf8internal23IsStructurallyValidUTF8EPKci");

   function IsStructurallyValidUTF8_CPP (str : Interfaces_CPP.Strings.CPP_String_External) return Extensions.bool;  -- ../../../src/google/protobuf/stubs/common.h:156
   pragma Import (CPP, IsStructurallyValidUTF8_CPP, "_ZN6google8protobuf8internal23IsStructurallyValidUTF8ERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE");

  -- Returns initial number of bytes of structually valid UTF-8.
   function UTF8SpnStructurallyValid (str : System.Address) return int;  -- ../../../src/google/protobuf/stubs/common.h:161
   pragma Import (CPP, UTF8SpnStructurallyValid, "_ZN6google8protobuf8internal24UTF8SpnStructurallyValidERKNS0_11StringPieceE");

  -- Coerce UTF-8 byte string in src_str to be
  -- a structurally-valid equal-length string by selectively
  -- overwriting illegal bytes with replace_char (typically ' ' or '?').
  -- replace_char must be legal printable 7-bit Ascii 0x20..0x7e.
  -- src_str is read-only.
  -- Returns pointer to output buffer, src_str.data() if no changes were made,
  --  or idst if some bytes were changed. idst is allocated by the caller
  --  and must be at least as big as src_str
  -- Optimized for: all structurally valid and no byte copying is done.
   function UTF8CoerceToStructurallyValid
     (str : System.Address;
      dst : Interfaces.C.Strings.chars_ptr;
      replace_char : char) return Interfaces.C.Strings.chars_ptr;  -- ../../../src/google/protobuf/stubs/common.h:175
   pragma Import (CPP, UTF8CoerceToStructurallyValid, "_ZN6google8protobuf8internal29UTF8CoerceToStructurallyValidERKNS0_11StringPieceEPcc");

  -- namespace internal
  -- ===================================================================
  -- Shutdown support.
  -- Shut down the entire protocol buffers library, deleting all static-duration
  -- objects allocated by the library or by generated .pb.cc files.
  -- There are two reasons you might want to call this:
  -- * You use a draconian definition of "memory leak" in which you expect
  --   every single malloc() to have a corresponding free(), even for objects
  --   which live until program exit.
  -- * You are writing a dynamically-loaded library which needs to clean up
  --   after itself when the library is unloaded.
  -- It is safe to call this multiple times.  However, it is not safe to use
  -- any other part of the protocol buffers library after
  -- ShutdownProtobufLibrary() has been called.
   procedure ShutdownProtobufLibrary;  -- ../../../src/google/protobuf/stubs/common.h:197
   pragma Import (CPP, ShutdownProtobufLibrary, "_ZN6google8protobuf23ShutdownProtobufLibraryEv");

  -- Register a function to be called when ShutdownProtocolBuffers() is called.
   procedure OnShutdown (func : access procedure);  -- ../../../src/google/protobuf/stubs/common.h:202
   pragma Import (CPP, OnShutdown, "_ZN6google8protobuf8internal10OnShutdownEPFvvE");

  -- namespace internal
   package Class_FatalException is
      type FatalException is limited new google.protobuf.binding.cpp_exception.Class_c_exception.c_exception with record
         filename_u : Interfaces.C.Strings.chars_ptr;  -- ../../../src/google/protobuf/stubs/common.h:220
         line_u : aliased int;  -- ../../../src/google/protobuf/stubs/common.h:221
         message_u : System.Address;--Interfaces_CPP.Strings.CPP_String_External; -- TODO: this is not really the correct type, figure out what to do
--           message_u : aliased google.protobuf.binding.cpp_6_2_1_bits_stringfwd_h.Class_string.string;  -- ../../../src/google/protobuf/stubs/common.h:222
      end record;
      pragma Import (CPP, FatalException);

      function New_FatalException
        (filename : Interfaces.C.Strings.chars_ptr;
         line : int;
         message : Interfaces_CPP.Strings.CPP_String_External) return FatalException;  -- ../../../src/google/protobuf/stubs/common.h:209
      pragma CPP_Constructor (New_FatalException, "_ZN6google8protobuf14FatalExceptionC1EPKciRKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE");

      procedure Delete_FatalException (this : access FatalException);  -- ../../../src/google/protobuf/stubs/common.h:211
      pragma Import (CPP, Delete_FatalException, "_ZN6google8protobuf14FatalExceptionD1Ev");

      function what (this : access constant FatalException) return Interfaces.C.Strings.chars_ptr;  -- ../../../src/google/protobuf/stubs/common.h:213
      pragma Import (CPP, what, "_ZNK6google8protobuf14FatalException4whatEv");

      function filename (this : access constant FatalException'Class) return Interfaces.C.Strings.chars_ptr;  -- ../../../src/google/protobuf/stubs/common.h:215
      pragma Import (CPP, filename, "_ZNK6google8protobuf14FatalException8filenameEv");

      function line (this : access constant FatalException'Class) return int;  -- ../../../src/google/protobuf/stubs/common.h:216
      pragma Import (CPP, line, "_ZNK6google8protobuf14FatalException4lineEv");

      function message (this : access constant FatalException'Class) return Interfaces_CPP.Strings.CPP_String_External;  -- ../../../src/google/protobuf/stubs/common.h:217
      pragma Import (CPP, message, "_ZNK6google8protobuf14FatalException7messageB5cxx11Ev");
   end;
   use Class_FatalException;
  -- This is at the end of the file instead of the beginning to work around a bug
  -- in some versions of MSVC.
  -- TODO(acozzette): remove these using statements
  -- namespace protobuf
  -- namespace google
end google.protobuf.binding.common_h;
