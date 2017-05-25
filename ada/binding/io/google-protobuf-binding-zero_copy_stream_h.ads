pragma Ada_2005;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with System;
with Interfaces.C.Extensions;
with google.protobuf.binding.google_protobuf_stubs_port_h;

package google.protobuf.binding.zero_copy_stream_h is

   package Class_ZeroCopyInputStream is
      type ZeroCopyInputStream is abstract tagged limited record
         null;
      end record;
      pragma Import (CPP, ZeroCopyInputStream);

--        function New_ZeroCopyInputStream return ZeroCopyInputStream is abstract;  -- ../../../../src/google/protobuf/io/zero_copy_stream.h:126
--        pragma CPP_Constructor (New_ZeroCopyInputStream, "_ZN6google8protobuf2io19ZeroCopyInputStreamC1Ev");

      procedure Delete_ZeroCopyInputStream (this : access ZeroCopyInputStream);  -- ../../../../src/google/protobuf/io/zero_copy_stream.h:127
      pragma Import (CPP, Delete_ZeroCopyInputStream, "_ZN6google8protobuf2io19ZeroCopyInputStreamD1Ev");

      function Next
        (this : access ZeroCopyInputStream;
         data : System.Address;
         size : access int) return Extensions.bool is abstract;  -- ../../../../src/google/protobuf/io/zero_copy_stream.h:145

      procedure BackUp (this : access ZeroCopyInputStream; count : int) is abstract;  -- ../../../../src/google/protobuf/io/zero_copy_stream.h:163

      function Skip (this : access ZeroCopyInputStream; count : int) return Extensions.bool is abstract;  -- ../../../../src/google/protobuf/io/zero_copy_stream.h:169

      function ByteCount (this : access constant ZeroCopyInputStream) return google.protobuf.binding.google_protobuf_stubs_port_h.int64 is abstract;  -- ../../../../src/google/protobuf/io/zero_copy_stream.h:172

      procedure operator_as (this : access ZeroCopyInputStream'Class; arg2 : access constant ZeroCopyInputStream'Class);  -- ../../../../src/google/protobuf/io/zero_copy_stream.h:176
      pragma Import (CPP, operator_as, "_ZN6google8protobuf2io19ZeroCopyInputStreamaSERKS2_");
   end;
   use Class_ZeroCopyInputStream;

   package Class_ZeroCopyOutputStream is
      type ZeroCopyOutputStream is abstract tagged limited record
         null;
      end record;
      pragma Import (CPP, ZeroCopyOutputStream);

--        function New_ZeroCopyOutputStream return ZeroCopyOutputStream is abstract;  -- ../../../../src/google/protobuf/io/zero_copy_stream.h:183
--        pragma CPP_Constructor (New_ZeroCopyOutputStream, "_ZN6google8protobuf2io20ZeroCopyOutputStreamC1Ev");

      procedure Delete_ZeroCopyOutputStream (this : access ZeroCopyOutputStream);  -- ../../../../src/google/protobuf/io/zero_copy_stream.h:184
      pragma Import (CPP, Delete_ZeroCopyOutputStream, "_ZN6google8protobuf2io20ZeroCopyOutputStreamD1Ev");

      function Next
        (this : access ZeroCopyOutputStream;
         data : System.Address;
         size : access int) return Extensions.bool is abstract;  -- ../../../../src/google/protobuf/io/zero_copy_stream.h:206

      procedure BackUp (this : access ZeroCopyOutputStream; count : int) is abstract;  -- ../../../../src/google/protobuf/io/zero_copy_stream.h:224

      function ByteCount (this : access constant ZeroCopyOutputStream) return google.protobuf.binding.google_protobuf_stubs_port_h.int64 is abstract;  -- ../../../../src/google/protobuf/io/zero_copy_stream.h:227

      function WriteAliasedRaw
        (this : access ZeroCopyOutputStream;
         data : System.Address;
         size : int) return Extensions.bool;  -- ../../../../src/google/protobuf/io/zero_copy_stream.h:236
      pragma Import (CPP, WriteAliasedRaw, "_ZN6google8protobuf2io20ZeroCopyOutputStream15WriteAliasedRawEPKvi");

      function AllowsAliasing (this : access constant ZeroCopyOutputStream) return Extensions.bool;  -- ../../../../src/google/protobuf/io/zero_copy_stream.h:237
      pragma Import (CPP, AllowsAliasing, "_ZNK6google8protobuf2io20ZeroCopyOutputStream14AllowsAliasingEv");

      procedure operator_as (this : access ZeroCopyOutputStream'Class; arg2 : access constant ZeroCopyOutputStream'Class);  -- ../../../../src/google/protobuf/io/zero_copy_stream.h:241
      pragma Import (CPP, operator_as, "_ZN6google8protobuf2io20ZeroCopyOutputStreamaSERKS2_");
   end;
   use Class_ZeroCopyOutputStream;

end google.protobuf.binding.zero_copy_stream_h;
