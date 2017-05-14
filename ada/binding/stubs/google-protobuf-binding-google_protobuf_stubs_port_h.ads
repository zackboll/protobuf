pragma Ada_2005;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with google.protobuf.binding.stdint_h;
with Interfaces.C.Extensions;
with System;

package google.protobuf.binding.google_protobuf_stubs_port_h is

   PROTOBUF_LITTLE_ENDIAN : constant := 1;  --  /usr/local/include/google/protobuf/stubs/port.h:72

   LANG_CXX11 : constant := 1;  --  /usr/local/include/google/protobuf/stubs/port.h:108
   --  unsupported macro: GOOGLE_LONGLONG(x) x ##LL
   --  unsupported macro: GOOGLE_ULONGLONG(x) x ##ULL

   GOOGLE_LL_FORMAT : aliased constant String := "ll" & ASCII.NUL;  --  /usr/local/include/google/protobuf/stubs/port.h:153
   --  unsupported macro: GOOGLE_ATTRIBUTE_ALWAYS_INLINE __attribute__ ((always_inline))
   --  unsupported macro: GOOGLE_ATTRIBUTE_NOINLINE __attribute__ ((noinline))
   --  unsupported macro: GOOGLE_ATTRIBUTE_NORETURN __attribute__((noreturn))
   --  unsupported macro: GOOGLE_ATTRIBUTE_DEPRECATED __attribute__((deprecated))
   --  arg-macro: function GOOGLE_PREDICT_TRUE (__builtin_expect(notnot(x), 1)
   --    return __builtin_expect(notnot(x), 1);
   --  arg-macro: function GOOGLE_PREDICT_FALSE (__builtin_expect(x, 0)
   --    return __builtin_expect(x, 0);
   --  arg-macro: function GOOGLE_UNALIGNED_LOAD16 (*reinterpret_cast<const uint16 *>(_p)
   --    return *reinterpret_cast<const uint16 *>(_p);
   --  arg-macro: function GOOGLE_UNALIGNED_LOAD32 (*reinterpret_cast<const uint32 *>(_p)
   --    return *reinterpret_cast<const uint32 *>(_p);
   --  arg-macro: function GOOGLE_UNALIGNED_LOAD64 (*reinterpret_cast<const uint64 *>(_p)
   --    return *reinterpret_cast<const uint64 *>(_p);
   --  arg-macro: function GOOGLE_UNALIGNED_STORE16 (*reinterpret_cast<uint16 *>(_p) := (_val)
   --    return *reinterpret_cast<uint16 *>(_p) := (_val);
   --  arg-macro: function GOOGLE_UNALIGNED_STORE32 (*reinterpret_cast<uint32 *>(_p) := (_val)
   --    return *reinterpret_cast<uint32 *>(_p) := (_val);
   --  arg-macro: function GOOGLE_UNALIGNED_STORE64 (*reinterpret_cast<uint64 *>(_p) := (_val)
   --    return *reinterpret_cast<uint64 *>(_p) := (_val);
   --  unsupported macro: GOOGLE_THREAD_LOCAL __thread

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
  -- Tru64 lacks stdint.h, but has inttypes.h which defines a superset of
  -- what stdint.h would define.
  -- Assuming windows is always little-endian.
  -- TODO(xiaofeng): The PROTOBUF_LITTLE_ENDIAN is not only used for
  -- optimization but also for correctness. We should define an
  -- different macro to test the big-endian code path in coded_stream.
  -- If MSVC has "/RTCc" set, it will complain about truncating casts at
  -- runtime.  This file contains some intentional truncating casts.
  -- __BYTE_ORDER 
  -- These #includes are for the byte swap functions declared later on.
  -- IWYU pragma: export 
  -- ===================================================================
  -- from google3/base/port.h
  -- Define this to 1 if the code is compiled in C++11 mode; leave it
  -- undefined otherwise.  Do NOT define it to 0 -- that causes
  -- '#ifdef LANG_CXX11' to behave differently from '#if LANG_CXX11'.
   subtype uint is unsigned;  -- /usr/local/include/google/protobuf/stubs/port.h:114

   subtype int8 is google.protobuf.binding.stdint_h.int8_t;  -- /usr/local/include/google/protobuf/stubs/port.h:127

   subtype int16 is google.protobuf.binding.stdint_h.int16_t;  -- /usr/local/include/google/protobuf/stubs/port.h:128

   subtype int32 is google.protobuf.binding.stdint_h.int32_t;  -- /usr/local/include/google/protobuf/stubs/port.h:129

   subtype int64 is google.protobuf.binding.stdint_h.int64_t;  -- /usr/local/include/google/protobuf/stubs/port.h:130

   subtype uint8 is google.protobuf.binding.stdint_h.uint8_t;  -- /usr/local/include/google/protobuf/stubs/port.h:132

   subtype uint16 is google.protobuf.binding.stdint_h.uint16_t;  -- /usr/local/include/google/protobuf/stubs/port.h:133

   subtype uint32 is google.protobuf.binding.stdint_h.uint32_t;  -- /usr/local/include/google/protobuf/stubs/port.h:134

   subtype uint64 is google.protobuf.binding.stdint_h.uint64_t;  -- /usr/local/include/google/protobuf/stubs/port.h:135

  -- long long macros to be used because gcc and vc++ use different suffixes,
  -- and different size specifiers in format strings
  -- By long long, we actually mean int64.
  -- Used to format real long long integers.
   kint32max : aliased int32;  -- /usr/local/include/google/protobuf/stubs/port.h:156
   pragma Import (CPP, kint32max, "_ZN6google8protobufL9kint32maxE");

   kint32min : aliased int32;  -- /usr/local/include/google/protobuf/stubs/port.h:157
   pragma Import (CPP, kint32min, "_ZN6google8protobufL9kint32minE");

   kint64max : aliased int64;  -- /usr/local/include/google/protobuf/stubs/port.h:158
   pragma Import (CPP, kint64max, "_ZN6google8protobufL9kint64maxE");

   kint64min : aliased int64;  -- /usr/local/include/google/protobuf/stubs/port.h:159
   pragma Import (CPP, kint64min, "_ZN6google8protobufL9kint64minE");

   kuint32max : aliased uint32;  -- /usr/local/include/google/protobuf/stubs/port.h:160
   pragma Import (CPP, kuint32max, "_ZN6google8protobufL10kuint32maxE");

   kuint64max : aliased uint64;  -- /usr/local/include/google/protobuf/stubs/port.h:161
   pragma Import (CPP, kuint64max, "_ZN6google8protobufL10kuint64maxE");

  -- -------------------------------------------------------------------
  -- Annotations:  Some parts of the code have been annotated in ways that might
  --   be useful to some compilers or tools, but are not supported universally.
  --   You can #define these annotations yourself if the default implementation
  --   is not right for you.
  -- For functions we want to force inline.
  -- Introduced in gcc 3.1.
  -- Other compilers will have to figure it out for themselves.
  -- For functions we want to force not inline.
  -- Introduced in gcc 3.1.
  -- Seems to have been around since at least Visual Studio 2005
  -- Other compilers will have to figure it out for themselves.
  -- Tell the compiler that a given function never returns.
  -- If the method/variable/type is used anywhere, produce a warning.
  -- Provided at least since GCC 3.0.
  -- Provided at least since GCC 3.0.
  -- Delimits a block of code which may write to memory which is simultaneously
  -- written by other threads, but which has been determined to be thread-safe
  -- (e.g. because it is an idempotent write).
  -- x86 and x86-64 can perform unaligned loads/stores directly.
  -- The following guarantees declaration of the byte swap functions.
  -- Mac OS X / Darwin features
  -- ===================================================================
  -- from google3/util/bits/bits.h
   package Class_Bits is
      type Bits is limited record
         null;
      end record;
      pragma Import (CPP, Bits);

      package Static is
         function Log2FloorNonZero (n : uint32) return uint32;  -- /usr/local/include/google/protobuf/stubs/port.h:349
         pragma Import (CPP, Log2FloorNonZero, "_ZN6google8protobuf4Bits16Log2FloorNonZeroEj");

         function Log2FloorNonZero64 (n : uint64) return uint32;  -- /usr/local/include/google/protobuf/stubs/port.h:363
         pragma Import (CPP, Log2FloorNonZero64, "_ZN6google8protobuf4Bits18Log2FloorNonZero64Em");

         function Log2FloorNonZero_Portable (n : uint32) return int;  -- /usr/local/include/google/protobuf/stubs/port.h:376
         pragma Import (CPP, Log2FloorNonZero_Portable, "_ZN6google8protobuf4Bits25Log2FloorNonZero_PortableEj");

         function Log2FloorNonZero64_Portable (n : uint64) return int;  -- /usr/local/include/google/protobuf/stubs/port.h:393
         pragma Import (CPP, Log2FloorNonZero64_Portable, "_ZN6google8protobuf4Bits27Log2FloorNonZero64_PortableEm");
      end;

      function Log2FloorNonZero (n : uint32) return uint32 renames Static.Log2FloorNonZero;

      function Log2FloorNonZero64 (n : uint64) return uint32 renames Static.Log2FloorNonZero64;

      function Log2FloorNonZero_Portable (n : uint32) return int renames Static.Log2FloorNonZero_Portable;

      function Log2FloorNonZero64_Portable (n : uint64) return int renames Static.Log2FloorNonZero64_Portable;
   end;
   use Class_Bits;
  -- arm-nacl-clang runs into an instruction-selection failure when it
  -- encounters __builtin_clzll:
  -- https://bugs.chromium.org/p/nativeclient/issues/detail?id=4395
  -- To work around this, when we build for NaCl we use the portable
  -- implementation instead.
  -- Top bits are zero, so scan in bottom bits
  -- ===================================================================
  -- from google3/util/endian/endian.h
   function ghtonl (x : uint32) return uint32;  -- /usr/local/include/google/protobuf/stubs/port.h:406
   pragma Import (CPP, ghtonl, "_ZN6google8protobuf6ghtonlEj");

   package Class_BigEndian is
      type BigEndian is limited record
         null;
      end record;
      pragma Import (CPP, BigEndian);

      package Static is
         function FromHost16 (x : uint16) return uint16;  -- /usr/local/include/google/protobuf/stubs/port.h:412
         pragma Import (CPP, FromHost16, "_ZN6google8protobuf9BigEndian10FromHost16Et");

         function ToHost16 (x : uint16) return uint16;  -- /usr/local/include/google/protobuf/stubs/port.h:413
         pragma Import (CPP, ToHost16, "_ZN6google8protobuf9BigEndian8ToHost16Et");

         function FromHost32 (x : uint32) return uint32;  -- /usr/local/include/google/protobuf/stubs/port.h:415
         pragma Import (CPP, FromHost32, "_ZN6google8protobuf9BigEndian10FromHost32Ej");

         function ToHost32 (x : uint32) return uint32;  -- /usr/local/include/google/protobuf/stubs/port.h:416
         pragma Import (CPP, ToHost32, "_ZN6google8protobuf9BigEndian8ToHost32Ej");

         function FromHost64 (x : uint64) return uint64;  -- /usr/local/include/google/protobuf/stubs/port.h:418
         pragma Import (CPP, FromHost64, "_ZN6google8protobuf9BigEndian10FromHost64Em");

         function ToHost64 (x : uint64) return uint64;  -- /usr/local/include/google/protobuf/stubs/port.h:419
         pragma Import (CPP, ToHost64, "_ZN6google8protobuf9BigEndian8ToHost64Em");

         function IsLittleEndian return Extensions.bool;  -- /usr/local/include/google/protobuf/stubs/port.h:421
         pragma Import (CPP, IsLittleEndian, "_ZN6google8protobuf9BigEndian14IsLittleEndianEv");

         function Load16 (p : System.Address) return uint16;  -- /usr/local/include/google/protobuf/stubs/port.h:439
         pragma Import (CPP, Load16, "_ZN6google8protobuf9BigEndian6Load16EPKv");

         procedure Store16 (p : System.Address; v : uint16);  -- /usr/local/include/google/protobuf/stubs/port.h:443
         pragma Import (CPP, Store16, "_ZN6google8protobuf9BigEndian7Store16EPvt");

         function Load32 (p : System.Address) return uint32;  -- /usr/local/include/google/protobuf/stubs/port.h:447
         pragma Import (CPP, Load32, "_ZN6google8protobuf9BigEndian6Load32EPKv");

         procedure Store32 (p : System.Address; v : uint32);  -- /usr/local/include/google/protobuf/stubs/port.h:451
         pragma Import (CPP, Store32, "_ZN6google8protobuf9BigEndian7Store32EPvj");

         function Load64 (p : System.Address) return uint64;  -- /usr/local/include/google/protobuf/stubs/port.h:455
         pragma Import (CPP, Load64, "_ZN6google8protobuf9BigEndian6Load64EPKv");

         procedure Store64 (p : System.Address; v : uint64);  -- /usr/local/include/google/protobuf/stubs/port.h:459
         pragma Import (CPP, Store64, "_ZN6google8protobuf9BigEndian7Store64EPvm");
      end;

      function FromHost16 (x : uint16) return uint16 renames Static.FromHost16;

      function ToHost16 (x : uint16) return uint16 renames Static.ToHost16;

      function FromHost32 (x : uint32) return uint32 renames Static.FromHost32;

      function ToHost32 (x : uint32) return uint32 renames Static.ToHost32;

      function FromHost64 (x : uint64) return uint64 renames Static.FromHost64;

      function ToHost64 (x : uint64) return uint64 renames Static.ToHost64;

      function IsLittleEndian return Extensions.bool renames Static.IsLittleEndian;

      function Load16 (p : System.Address) return uint16 renames Static.Load16;

      procedure Store16 (p : System.Address; v : uint16) renames Static.Store16;

      function Load32 (p : System.Address) return uint32 renames Static.Load32;

      procedure Store32 (p : System.Address; v : uint32) renames Static.Store32;

      function Load64 (p : System.Address) return uint64 renames Static.Load64;

      procedure Store64 (p : System.Address; v : uint64) renames Static.Store64;
   end;
   use Class_BigEndian;
  -- Functions to do unaligned loads and stores in big-endian order.
  -- namespace protobuf
  -- namespace google
end google.protobuf.binding.google_protobuf_stubs_port_h;
