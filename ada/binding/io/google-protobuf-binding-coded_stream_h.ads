pragma Ada_2005;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with google.protobuf.binding.port_h;
with System;
with Interfaces.C.Extensions;
--  limited with google.protobuf.binding.cpp_6_2_1_bits_stringfwd_h;
--  with google.protobuf.binding.cpp_6_2_1_bits_stl_pair_h;
with google.protobuf.binding.stddef_h;
with google.protobuf.binding.atomicops_h;
with google.protobuf.binding.zero_copy_stream_h;

with Interfaces_CPP.Strings;

package google.protobuf.binding.coded_stream_h is
  
  -- Opaque type used with PushLimit() and PopLimit().  Do not modify
  -- values of this type yourself.  The only reason that this isn't a
  -- struct with private internals is for efficiency.
  -- typedef int Limit;
  subtype Limit is Interfaces.C.int;
  
   package Class_CodedInputStream is
      type CodedInputStream is limited record
         buffer_u : access google.protobuf.binding.port_h.uint8;  -- ../../../../src/google/protobuf/io/coded_stream.h:535
         buffer_end_u : access google.protobuf.binding.port_h.uint8;  -- ../../../../src/google/protobuf/io/coded_stream.h:536
         input_u : access google.Protobuf.Binding.zero_copy_stream_h.Class_ZeroCopyInputStream.ZeroCopyInputStream;  -- ../../../../src/google/protobuf/io/coded_stream.h:537
         total_bytes_read_u : aliased int;  -- ../../../../src/google/protobuf/io/coded_stream.h:538
         overflow_bytes_u : aliased int;  -- ../../../../src/google/protobuf/io/coded_stream.h:543
         last_tag_u : aliased google.protobuf.binding.port_h.uint32;  -- ../../../../src/google/protobuf/io/coded_stream.h:546
         legitimate_message_end_u : aliased Extensions.bool;  -- ../../../../src/google/protobuf/io/coded_stream.h:551
         aliasing_enabled_u : aliased Extensions.bool;  -- ../../../../src/google/protobuf/io/coded_stream.h:554
         current_limit_u : aliased Limit;  -- ../../../../src/google/protobuf/io/coded_stream.h:557
         buffer_size_after_limit_u : aliased int;  -- ../../../../src/google/protobuf/io/coded_stream.h:566
         total_bytes_limit_u : aliased int;  -- ../../../../src/google/protobuf/io/coded_stream.h:570
         recursion_budget_u : aliased int;  -- ../../../../src/google/protobuf/io/coded_stream.h:575
         recursion_limit_u : aliased int;  -- ../../../../src/google/protobuf/io/coded_stream.h:577
         disable_strict_correctness_enforcement_u : aliased Extensions.bool;  -- ../../../../src/google/protobuf/io/coded_stream.h:579
         extension_pool_u : System.Address;  -- ../../../../src/google/protobuf/io/coded_stream.h:582
         extension_factory_u : System.Address;  -- ../../../../src/google/protobuf/io/coded_stream.h:583
      end record;
      pragma Import (CPP, CodedInputStream);

      function New_CodedInputStream (input : not null access google.Protobuf.Binding.zero_copy_stream_h.Class_ZeroCopyInputStream.ZeroCopyInputStream) return CodedInputStream;  -- ../../../../src/google/protobuf/io/coded_stream.h:1387
      pragma CPP_Constructor (New_CodedInputStream, "_ZN6google8protobuf2io16CodedInputStreamC1EPNS1_19ZeroCopyInputStreamE");

      function New_CodedInputStream2 (buffer : access constant google.protobuf.binding.port_h.uint8; size : int) return CodedInputStream;  -- ../../../../src/google/protobuf/io/coded_stream.h:1408
      pragma CPP_Constructor (New_CodedInputStream2, "_ZN6google8protobuf2io16CodedInputStreamC1EPKhi");

      procedure Delete_CodedInputStream (this : access CodedInputStream);  -- ../../../../src/google/protobuf/io/coded_stream.h:179
      pragma Import (CPP, Delete_CodedInputStream, "_ZN6google8protobuf2io16CodedInputStreamD1Ev");

      function IsFlat (this : access constant CodedInputStream) return Extensions.bool;  -- ../../../../src/google/protobuf/io/coded_stream.h:1429
      pragma Import (CPP, IsFlat, "_ZNK6google8protobuf2io16CodedInputStream6IsFlatEv");

      function Skip (this : access CodedInputStream; count : int) return Extensions.bool;  -- ../../../../src/google/protobuf/io/coded_stream.h:187
      pragma Import (CPP, Skip, "_ZN6google8protobuf2io16CodedInputStream4SkipEi");

      function GetDirectBufferPointer
        (this : access CodedInputStream;
         data : System.Address;
         size : access int) return Extensions.bool;  -- ../../../../src/google/protobuf/io/coded_stream.h:196
      pragma Import (CPP, GetDirectBufferPointer, "_ZN6google8protobuf2io16CodedInputStream22GetDirectBufferPointerEPPKvPi");

      procedure GetDirectBufferPointerInline
        (this : access CodedInputStream;
         data : System.Address;
         size : access int);  -- ../../../../src/google/protobuf/io/coded_stream.h:1157
      pragma Import (CPP, GetDirectBufferPointerInline, "_ZN6google8protobuf2io16CodedInputStream28GetDirectBufferPointerInlineEPPKvPi");

      function ReadRaw
        (this : access CodedInputStream;
         buffer : System.Address;
         size : int) return Extensions.bool;  -- ../../../../src/google/protobuf/io/coded_stream.h:204
      pragma Import (CPP, ReadRaw, "_ZN6google8protobuf2io16CodedInputStream7ReadRawEPvi");

      function InternalReadRawInline
        (this : access CodedInputStream;
         buffer : System.Address;
         size : int) return Extensions.bool;  -- ../../../../src/google/protobuf/io/coded_stream.h:208
      pragma Import (CPP, InternalReadRawInline, "_ZN6google8protobuf2io16CodedInputStream21InternalReadRawInlineEPvi");

      function ReadString
        (this : access CodedInputStream;
         buffer : access Interfaces_CPP.Strings.CPP_String_External;
         size : int) return Extensions.bool;  -- ../../../../src/google/protobuf/io/coded_stream.h:217
      pragma Import (CPP, ReadString, "_ZN6google8protobuf2io16CodedInputStream10ReadStringEPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEi");

      function InternalReadStringInline
        (this : access CodedInputStream;
         buffer : Interfaces_CPP.Strings.CPP_String_External;
         size : int) return Extensions.bool;  -- ../../../../src/google/protobuf/io/coded_stream.h:220
      pragma Import (CPP, InternalReadStringInline, "_ZN6google8protobuf2io16CodedInputStream24InternalReadStringInlineEPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEi");

      function ReadLittleEndian32 (this : access CodedInputStream; value : access google.protobuf.binding.port_h.uint32) return Extensions.bool;  -- ../../../../src/google/protobuf/io/coded_stream.h:995
      pragma Import (CPP, ReadLittleEndian32, "_ZN6google8protobuf2io16CodedInputStream18ReadLittleEndian32EPj");

      function ReadLittleEndian64 (this : access CodedInputStream; value : access google.protobuf.binding.port_h.uint64) return Extensions.bool;  -- ../../../../src/google/protobuf/io/coded_stream.h:1008
      pragma Import (CPP, ReadLittleEndian64, "_ZN6google8protobuf2io16CodedInputStream18ReadLittleEndian64EPm");

      function ReadVarint32 (this : access CodedInputStream; value : access google.protobuf.binding.port_h.uint32) return Extensions.bool;  -- ../../../../src/google/protobuf/io/coded_stream.h:919
      pragma Import (CPP, ReadVarint32, "_ZN6google8protobuf2io16CodedInputStream12ReadVarint32EPj");

      function ReadVarint64 (this : access CodedInputStream; value : access google.protobuf.binding.port_h.uint64) return Extensions.bool;  -- ../../../../src/google/protobuf/io/coded_stream.h:934
      pragma Import (CPP, ReadVarint64, "_ZN6google8protobuf2io16CodedInputStream12ReadVarint64EPm");

      function ReadVarintSizeAsInt (this : access CodedInputStream; value : access int) return Extensions.bool;  -- ../../../../src/google/protobuf/io/coded_stream.h:945
      pragma Import (CPP, ReadVarintSizeAsInt, "_ZN6google8protobuf2io16CodedInputStream19ReadVarintSizeAsIntEPi");

      function ReadTag (this : access CodedInputStream) return google.protobuf.binding.port_h.uint32;  -- ../../../../src/google/protobuf/io/coded_stream.h:1021
      pragma Import (CPP, ReadTag, "_ZN6google8protobuf2io16CodedInputStream7ReadTagEv");

      function ReadTagNoLastTag (this : access CodedInputStream) return google.protobuf.binding.port_h.uint32;  -- ../../../../src/google/protobuf/io/coded_stream.h:1025
      pragma Import (CPP, ReadTagNoLastTag, "_ZN6google8protobuf2io16CodedInputStream16ReadTagNoLastTagEv");

--        function ReadTagWithCutoff (this : access CodedInputStream; cutoff : google.protobuf.binding.port_h.uint32) return google.protobuf.binding.cpp_6_2_1_bits_stl_pair_h.Class_pair.pair;  -- ../../../../src/google/protobuf/io/coded_stream.h:1049
--        pragma Import (CPP, ReadTagWithCutoff, "_ZN6google8protobuf2io16CodedInputStream17ReadTagWithCutoffEj");

--        function ReadTagWithCutoffNoLastTag (this : access CodedInputStream; cutoff : google.protobuf.binding.port_h.uint32) return google.protobuf.binding.cpp_6_2_1_bits_stl_pair_h.Class_pair.pair;  -- ../../../../src/google/protobuf/io/coded_stream.h:1054
--        pragma Import (CPP, ReadTagWithCutoffNoLastTag, "_ZN6google8protobuf2io16CodedInputStream26ReadTagWithCutoffNoLastTagEj");

      function ExpectTag (this : access CodedInputStream; expected : google.protobuf.binding.port_h.uint32) return Extensions.bool;  -- ../../../../src/google/protobuf/io/coded_stream.h:1119
      pragma Import (CPP, ExpectTag, "_ZN6google8protobuf2io16CodedInputStream9ExpectTagEj");

      function ExpectAtEnd (this : access CodedInputStream) return Extensions.bool;  -- ../../../../src/google/protobuf/io/coded_stream.h:1163
      pragma Import (CPP, ExpectAtEnd, "_ZN6google8protobuf2io16CodedInputStream11ExpectAtEndEv");

      function LastTagWas (this : access CodedInputStream; expected : google.protobuf.binding.port_h.uint32) return Extensions.bool;  -- ../../../../src/google/protobuf/io/coded_stream.h:1111
      pragma Import (CPP, LastTagWas, "_ZN6google8protobuf2io16CodedInputStream10LastTagWasEj");

      function ConsumedEntireMessage (this : access CodedInputStream) return Extensions.bool;  -- ../../../../src/google/protobuf/io/coded_stream.h:1115
--        pragma Import (CPP, ConsumedEntireMessage, "Google_Protobuf_Ada_ConsumedEntireMessage");
      pragma Import (CPP, ConsumedEntireMessage, "_ZN6google8protobuf2io16CodedInputStream21ConsumedEntireMessageEv");

      function PushLimit (this : access CodedInputStream; byte_limit : int) return Limit;  -- ../../../../src/google/protobuf/io/coded_stream.h:351
      pragma Import (CPP, PushLimit, "_ZN6google8protobuf2io16CodedInputStream9PushLimitEi");

      procedure PopLimit (this : access CodedInputStream; the_limit : Limit);  -- ../../../../src/google/protobuf/io/coded_stream.h:355
      pragma Import (CPP, PopLimit, "_ZN6google8protobuf2io16CodedInputStream8PopLimitEi");

      function BytesUntilLimit (this : access constant CodedInputStream) return int;  -- ../../../../src/google/protobuf/io/coded_stream.h:359
      pragma Import (CPP, BytesUntilLimit, "_ZNK6google8protobuf2io16CodedInputStream15BytesUntilLimitEv");

      function CurrentPosition (this : access constant CodedInputStream) return int;  -- ../../../../src/google/protobuf/io/coded_stream.h:1178
      pragma Import (CPP, CurrentPosition, "_ZNK6google8protobuf2io16CodedInputStream15CurrentPositionEv");

      procedure SetTotalBytesLimit
        (this : access CodedInputStream;
         total_bytes_limit : int;
         warning_threshold : int);  -- ../../../../src/google/protobuf/io/coded_stream.h:398
      pragma Import (CPP, SetTotalBytesLimit, "_ZN6google8protobuf2io16CodedInputStream18SetTotalBytesLimitEii");

      function BytesUntilTotalBytesLimit (this : access constant CodedInputStream) return int;  -- ../../../../src/google/protobuf/io/coded_stream.h:402
      pragma Import (CPP, BytesUntilTotalBytesLimit, "_ZNK6google8protobuf2io16CodedInputStream25BytesUntilTotalBytesLimitEv");

      procedure SetRecursionLimit (this : access CodedInputStream; limit : int);  -- ../../../../src/google/protobuf/io/coded_stream.h:1350
      pragma Import (CPP, SetRecursionLimit, "_ZN6google8protobuf2io16CodedInputStream17SetRecursionLimitEi");

      function IncrementRecursionDepth (this : access CodedInputStream) return Extensions.bool;  -- ../../../../src/google/protobuf/io/coded_stream.h:1355
      pragma Import (CPP, IncrementRecursionDepth, "_ZN6google8protobuf2io16CodedInputStream23IncrementRecursionDepthEv");

      procedure DecrementRecursionDepth (this : access CodedInputStream);  -- ../../../../src/google/protobuf/io/coded_stream.h:1360
      pragma Import (CPP, DecrementRecursionDepth, "_ZN6google8protobuf2io16CodedInputStream23DecrementRecursionDepthEv");

      procedure UnsafeDecrementRecursionDepth (this : access CodedInputStream);  -- ../../../../src/google/protobuf/io/coded_stream.h:1364
      pragma Import (CPP, UnsafeDecrementRecursionDepth, "_ZN6google8protobuf2io16CodedInputStream29UnsafeDecrementRecursionDepthEv");

--        function IncrementRecursionDepthAndPushLimit (this : access CodedInputStream; byte_limit : int) return google.protobuf.binding.cpp_6_2_1_bits_stl_pair_h.Class_pair.pair;  -- ../../../../src/google/protobuf/io/coded_stream.h:431
--        pragma Import (CPP, IncrementRecursionDepthAndPushLimit, "_ZN6google8protobuf2io16CodedInputStream35IncrementRecursionDepthAndPushLimitEi");

      function ReadLengthAndPushLimit (this : access CodedInputStream) return Limit;  -- ../../../../src/google/protobuf/io/coded_stream.h:435
      pragma Import (CPP, ReadLengthAndPushLimit, "_ZN6google8protobuf2io16CodedInputStream22ReadLengthAndPushLimitEv");

      function DecrementRecursionDepthAndPopLimit (this : access CodedInputStream; the_limit : Limit) return Extensions.bool;  -- ../../../../src/google/protobuf/io/coded_stream.h:444
      pragma Import (CPP, DecrementRecursionDepthAndPopLimit, "_ZN6google8protobuf2io16CodedInputStream34DecrementRecursionDepthAndPopLimitEi");

      function CheckEntireMessageConsumedAndPopLimit (this : access CodedInputStream; the_limit : Limit) return Extensions.bool;  -- ../../../../src/google/protobuf/io/coded_stream.h:451
      pragma Import (CPP, CheckEntireMessageConsumedAndPopLimit, "_ZN6google8protobuf2io16CodedInputStream37CheckEntireMessageConsumedAndPopLimitEi");

      procedure SetExtensionRegistry
        (this : access CodedInputStream;
         pool : System.Address;
         factory : System.Address);  -- ../../../../src/google/protobuf/io/coded_stream.h:1369
      pragma Import (CPP, SetExtensionRegistry, "_ZN6google8protobuf2io16CodedInputStream20SetExtensionRegistryEPKNS0_14DescriptorPoolEPNS0_14MessageFactoryE");

      function GetExtensionPool (this : access CodedInputStream) return System.Address;  -- ../../../../src/google/protobuf/io/coded_stream.h:1375
      pragma Import (CPP, GetExtensionPool, "_ZN6google8protobuf2io16CodedInputStream16GetExtensionPoolEv");

      function GetExtensionFactory (this : access CodedInputStream) return System.Address;  -- ../../../../src/google/protobuf/io/coded_stream.h:1379
      pragma Import (CPP, GetExtensionFactory, "_ZN6google8protobuf2io16CodedInputStream19GetExtensionFactoryEv");

      procedure operator_as (this : access CodedInputStream; arg2 : access constant CodedInputStream);  -- ../../../../src/google/protobuf/io/coded_stream.h:533
      pragma Import (CPP, operator_as, "_ZN6google8protobuf2io16CodedInputStreamaSERKS2_");

      procedure Advance (this : access CodedInputStream; amount : int);  -- ../../../../src/google/protobuf/io/coded_stream.h:1341
      pragma Import (CPP, Advance, "_ZN6google8protobuf2io16CodedInputStream7AdvanceEi");

      procedure BackUpInputToCurrentPosition (this : access CodedInputStream);  -- ../../../../src/google/protobuf/io/coded_stream.h:591
      pragma Import (CPP, BackUpInputToCurrentPosition, "_ZN6google8protobuf2io16CodedInputStream28BackUpInputToCurrentPositionEv");

      procedure RecomputeBufferLimits (this : access CodedInputStream);  -- ../../../../src/google/protobuf/io/coded_stream.h:595
      pragma Import (CPP, RecomputeBufferLimits, "_ZN6google8protobuf2io16CodedInputStream21RecomputeBufferLimitsEv");

      procedure PrintTotalBytesLimitError (this : access CodedInputStream);  -- ../../../../src/google/protobuf/io/coded_stream.h:598
      pragma Import (CPP, PrintTotalBytesLimitError, "_ZN6google8protobuf2io16CodedInputStream25PrintTotalBytesLimitErrorEv");

      function Refresh (this : access CodedInputStream) return Extensions.bool;  -- ../../../../src/google/protobuf/io/coded_stream.h:602
      pragma Import (CPP, Refresh, "_ZN6google8protobuf2io16CodedInputStream7RefreshEv");

      function ReadVarint32Fallback (this : access CodedInputStream; first_byte_or_zero : google.protobuf.binding.port_h.uint32) return google.protobuf.binding.port_h.int64;  -- ../../../../src/google/protobuf/io/coded_stream.h:615
      pragma Import (CPP, ReadVarint32Fallback, "_ZN6google8protobuf2io16CodedInputStream20ReadVarint32FallbackEj");

      function ReadVarintSizeAsIntFallback (this : access CodedInputStream) return int;  -- ../../../../src/google/protobuf/io/coded_stream.h:616
      pragma Import (CPP, ReadVarintSizeAsIntFallback, "_ZN6google8protobuf2io16CodedInputStream27ReadVarintSizeAsIntFallbackEv");

--        function ReadVarint64Fallback (this : access CodedInputStream) return google.protobuf.binding.cpp_6_2_1_bits_stl_pair_h.Class_pair.pair;  -- ../../../../src/google/protobuf/io/coded_stream.h:617
--        pragma Import (CPP, ReadVarint64Fallback, "_ZN6google8protobuf2io16CodedInputStream20ReadVarint64FallbackEv");

      function ReadVarint32Slow (this : access CodedInputStream; value : access google.protobuf.binding.port_h.uint32) return Extensions.bool;  -- ../../../../src/google/protobuf/io/coded_stream.h:618
      pragma Import (CPP, ReadVarint32Slow, "_ZN6google8protobuf2io16CodedInputStream16ReadVarint32SlowEPj");

      function ReadVarint64Slow (this : access CodedInputStream; value : access google.protobuf.binding.port_h.uint64) return Extensions.bool;  -- ../../../../src/google/protobuf/io/coded_stream.h:619
      pragma Import (CPP, ReadVarint64Slow, "_ZN6google8protobuf2io16CodedInputStream16ReadVarint64SlowEPm");

      function ReadVarintSizeAsIntSlow (this : access CodedInputStream) return int;  -- ../../../../src/google/protobuf/io/coded_stream.h:620
      pragma Import (CPP, ReadVarintSizeAsIntSlow, "_ZN6google8protobuf2io16CodedInputStream23ReadVarintSizeAsIntSlowEv");

      function ReadLittleEndian32Fallback (this : access CodedInputStream; value : access google.protobuf.binding.port_h.uint32) return Extensions.bool;  -- ../../../../src/google/protobuf/io/coded_stream.h:621
      pragma Import (CPP, ReadLittleEndian32Fallback, "_ZN6google8protobuf2io16CodedInputStream26ReadLittleEndian32FallbackEPj");

      function ReadLittleEndian64Fallback (this : access CodedInputStream; value : access google.protobuf.binding.port_h.uint64) return Extensions.bool;  -- ../../../../src/google/protobuf/io/coded_stream.h:622
      pragma Import (CPP, ReadLittleEndian64Fallback, "_ZN6google8protobuf2io16CodedInputStream26ReadLittleEndian64FallbackEPm");

      function ReadTagFallback (this : access CodedInputStream; first_byte_or_zero : google.protobuf.binding.port_h.uint32) return google.protobuf.binding.port_h.uint32;  -- ../../../../src/google/protobuf/io/coded_stream.h:633
      pragma Import (CPP, ReadTagFallback, "_ZN6google8protobuf2io16CodedInputStream15ReadTagFallbackEj");

      function ReadTagSlow (this : access CodedInputStream) return google.protobuf.binding.port_h.uint32;  -- ../../../../src/google/protobuf/io/coded_stream.h:634
      pragma Import (CPP, ReadTagSlow, "_ZN6google8protobuf2io16CodedInputStream11ReadTagSlowEv");

      function ReadStringFallback
        (this : access CodedInputStream;
         buffer : Interfaces_CPP.Strings.CPP_String_External;
         size : int) return Extensions.bool;  -- ../../../../src/google/protobuf/io/coded_stream.h:635
      pragma Import (CPP, ReadStringFallback, "_ZN6google8protobuf2io16CodedInputStream18ReadStringFallbackEPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEi");

      function BufferSize (this : access constant CodedInputStream) return int;  -- ../../../../src/google/protobuf/io/coded_stream.h:1383
      pragma Import (CPP, BufferSize, "_ZNK6google8protobuf2io16CodedInputStream10BufferSizeEv");

      package Static is
         function ReadLittleEndian32FromArray (buffer : access google.protobuf.binding.port_h.uint8; value : access google.protobuf.binding.port_h.uint32) return access google.protobuf.binding.port_h.uint8;  -- ../../../../src/google/protobuf/io/coded_stream.h:959
         pragma Import (CPP, ReadLittleEndian32FromArray, "_ZN6google8protobuf2io16CodedInputStream27ReadLittleEndian32FromArrayEPKhPj");

         function ReadLittleEndian64FromArray (buffer : access google.protobuf.binding.port_h.uint8; value : access google.protobuf.binding.port_h.uint64) return access google.protobuf.binding.port_h.uint8;  -- ../../../../src/google/protobuf/io/coded_stream.h:974
         pragma Import (CPP, ReadLittleEndian64FromArray, "_ZN6google8protobuf2io16CodedInputStream27ReadLittleEndian64FromArrayEPKhPm");

         function ExpectTagFromArray (buffer : access google.protobuf.binding.port_h.uint8; expected : google.protobuf.binding.port_h.uint32) return access google.protobuf.binding.port_h.uint8;  -- ../../../../src/google/protobuf/io/coded_stream.h:1142
         pragma Import (CPP, ExpectTagFromArray, "_ZN6google8protobuf2io16CodedInputStream18ExpectTagFromArrayEPKhj");
      end;

      function ReadLittleEndian32FromArray (buffer : access google.protobuf.binding.port_h.uint8; value : access google.protobuf.binding.port_h.uint32) return access google.protobuf.binding.port_h.uint8 renames Static.ReadLittleEndian32FromArray;

      function ReadLittleEndian64FromArray (buffer : access google.protobuf.binding.port_h.uint8; value : access google.protobuf.binding.port_h.uint64) return access google.protobuf.binding.port_h.uint8 renames Static.ReadLittleEndian64FromArray;

      function ExpectTagFromArray (buffer : access google.protobuf.binding.port_h.uint8; expected : google.protobuf.binding.port_h.uint32) return access google.protobuf.binding.port_h.uint8 renames Static.ExpectTagFromArray;

      kDefaultTotalBytesLimit : aliased int;  -- ../../../../src/google/protobuf/io/coded_stream.h:640
      pragma Import (CPP, kDefaultTotalBytesLimit, "_ZN6google8protobuf2io16CodedInputStream23kDefaultTotalBytesLimitE");

      default_recursion_limit_u : aliased int;  -- ../../../../src/google/protobuf/io/coded_stream.h:642
      pragma Import (CPP, default_recursion_limit_u, "_ZN6google8protobuf2io16CodedInputStream24default_recursion_limit_E");
   end;
   use Class_CodedInputStream;

   package Class_CodedOutputStream is
      type CodedOutputStream is limited record
         output_u : access google.Protobuf.binding.zero_copy_stream_h.Class_ZeroCopyOutputStream.ZeroCopyOutputStream;  -- ../../../../src/google/protobuf/io/coded_stream.h:874
         buffer_u : access google.protobuf.binding.port_h.uint8;  -- ../../../../src/google/protobuf/io/coded_stream.h:875
         buffer_size_u : aliased int;  -- ../../../../src/google/protobuf/io/coded_stream.h:876
         total_bytes_u : aliased int;  -- ../../../../src/google/protobuf/io/coded_stream.h:877
         had_error_u : aliased Extensions.bool;  -- ../../../../src/google/protobuf/io/coded_stream.h:878
         aliasing_enabled_u : aliased Extensions.bool;  -- ../../../../src/google/protobuf/io/coded_stream.h:879
         serialization_deterministic_is_overridden_u : aliased Extensions.bool;  -- ../../../../src/google/protobuf/io/coded_stream.h:881
         serialization_deterministic_override_u : aliased Extensions.bool;  -- ../../../../src/google/protobuf/io/coded_stream.h:882
      end record;
      pragma Import (CPP, CodedOutputStream);

      function New_CodedOutputStream (output : access google.Protobuf.binding.zero_copy_stream_h.Class_ZeroCopyOutputStream.ZeroCopyOutputStream) return CodedOutputStream;  -- ../../../../src/google/protobuf/io/coded_stream.h:694
      pragma CPP_Constructor (New_CodedOutputStream, "_ZN6google8protobuf2io17CodedOutputStreamC1EPNS1_20ZeroCopyOutputStreamE");

      function New_CodedOutputStream (output : System.Address; do_eager_refresh : Extensions.bool) return CodedOutputStream;  -- ../../../../src/google/protobuf/io/coded_stream.h:695
      pragma CPP_Constructor (New_CodedOutputStream, "_ZN6google8protobuf2io17CodedOutputStreamC1EPNS1_20ZeroCopyOutputStreamEb");

      procedure Delete_CodedOutputStream (this : access CodedOutputStream);  -- ../../../../src/google/protobuf/io/coded_stream.h:699
      pragma Import (CPP, Delete_CodedOutputStream, "_ZN6google8protobuf2io17CodedOutputStreamD1Ev");

      procedure Trim (this : access CodedOutputStream);  -- ../../../../src/google/protobuf/io/coded_stream.h:706
      pragma Import (CPP, Trim, "_ZN6google8protobuf2io17CodedOutputStream4TrimEv");

      function Skip (this : access CodedOutputStream; count : int) return Extensions.bool;  -- ../../../../src/google/protobuf/io/coded_stream.h:711
      pragma Import (CPP, Skip, "_ZN6google8protobuf2io17CodedOutputStream4SkipEi");

      function GetDirectBufferPointer
        (this : access CodedOutputStream;
         data : System.Address;
         size : access int) return Extensions.bool;  -- ../../../../src/google/protobuf/io/coded_stream.h:721
      pragma Import (CPP, GetDirectBufferPointer, "_ZN6google8protobuf2io17CodedOutputStream22GetDirectBufferPointerEPPvPi");

      function GetDirectBufferForNBytesAndAdvance (this : access CodedOutputStream; size : int) return access google.protobuf.binding.port_h.uint8;  -- ../../../../src/google/protobuf/io/coded_stream.h:1182
      pragma Import (CPP, GetDirectBufferForNBytesAndAdvance, "_ZN6google8protobuf2io17CodedOutputStream34GetDirectBufferForNBytesAndAdvanceEi");
                                                                                                                                                                           

      procedure WriteRaw
        (this : access CodedOutputStream;
         buffer : System.Address;
         size : int);  -- ../../../../src/google/protobuf/io/coded_stream.h:733
      pragma Import (CPP, WriteRaw, "_ZN6google8protobuf2io17CodedOutputStream8WriteRawEPKvi");

      procedure WriteRawMaybeAliased
        (this : access CodedOutputStream;
         data : System.Address;
         size : int);  -- ../../../../src/google/protobuf/io/coded_stream.h:1323
      pragma Import (CPP, WriteRawMaybeAliased, "_ZN6google8protobuf2io17CodedOutputStream20WriteRawMaybeAliasedEPKvi");

      procedure WriteString (this : access CodedOutputStream; str : Interfaces_CPP.Strings.CPP_String_External);  -- ../../../../src/google/protobuf/io/coded_stream.h:1319
      pragma Import (CPP, WriteString, "_ZN6google8protobuf2io17CodedOutputStream11WriteStringERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEE");

      procedure EnableAliasing (this : access CodedOutputStream; enabled : Extensions.bool);  -- ../../../../src/google/protobuf/io/coded_stream.h:761
      pragma Import (CPP, EnableAliasing, "_ZN6google8protobuf2io17CodedOutputStream14EnableAliasingEb");

      procedure WriteLittleEndian32 (this : access CodedOutputStream; value : google.protobuf.binding.port_h.uint32);  -- ../../../../src/google/protobuf/io/coded_stream.h:764
      pragma Import (CPP, WriteLittleEndian32, "_ZN6google8protobuf2io17CodedOutputStream19WriteLittleEndian32Ej");

      procedure WriteLittleEndian64 (this : access CodedOutputStream; value : google.protobuf.binding.port_h.uint64);  -- ../../../../src/google/protobuf/io/coded_stream.h:768
      pragma Import (CPP, WriteLittleEndian64, "_ZN6google8protobuf2io17CodedOutputStream19WriteLittleEndian64Em");

      procedure WriteVarint32 (this : access CodedOutputStream; value : google.protobuf.binding.port_h.uint32);  -- ../../../../src/google/protobuf/io/coded_stream.h:1256
      pragma Import (CPP, WriteVarint32, "_ZN6google8protobuf2io17CodedOutputStream13WriteVarint32Ej");

      procedure WriteVarint64 (this : access CodedOutputStream; value : google.protobuf.binding.port_h.uint64);  -- ../../../../src/google/protobuf/io/coded_stream.h:1269
      pragma Import (CPP, WriteVarint64, "_ZN6google8protobuf2io17CodedOutputStream13WriteVarint64Em");

      procedure WriteVarint32SignExtended (this : access CodedOutputStream; value : google.protobuf.binding.port_h.int32);  -- ../../../../src/google/protobuf/io/coded_stream.h:1214
      pragma Import (CPP, WriteVarint32SignExtended, "_ZN6google8protobuf2io17CodedOutputStream25WriteVarint32SignExtendedEi");

      procedure WriteTag (this : access CodedOutputStream; value : google.protobuf.binding.port_h.uint32);  -- ../../../../src/google/protobuf/io/coded_stream.h:1282
      pragma Import (CPP, WriteTag, "_ZN6google8protobuf2io17CodedOutputStream8WriteTagEj");

      function ByteCount (this : access constant CodedOutputStream) return int;  -- ../../../../src/google/protobuf/io/coded_stream.h:1337
      pragma Import (CPP, ByteCount, "_ZNK6google8protobuf2io17CodedOutputStream9ByteCountEv");

      function HadError (this : access constant CodedOutputStream) return Extensions.bool;  -- ../../../../src/google/protobuf/io/coded_stream.h:827
      pragma Import (CPP, HadError, "_ZNK6google8protobuf2io17CodedOutputStream8HadErrorEv");

      procedure SetSerializationDeterministic (this : access CodedOutputStream; value : Extensions.bool);  -- ../../../../src/google/protobuf/io/coded_stream.h:853
      pragma Import (CPP, SetSerializationDeterministic, "_ZN6google8protobuf2io17CodedOutputStream29SetSerializationDeterministicEb");

      function IsSerializationDeterministic (this : access constant CodedOutputStream) return Extensions.bool;  -- ../../../../src/google/protobuf/io/coded_stream.h:861
      pragma Import (CPP, IsSerializationDeterministic, "_ZNK6google8protobuf2io17CodedOutputStream28IsSerializationDeterministicEv");

      procedure operator_as (this : access CodedOutputStream; arg2 : access constant CodedOutputStream);  -- ../../../../src/google/protobuf/io/coded_stream.h:872
      pragma Import (CPP, operator_as, "_ZN6google8protobuf2io17CodedOutputStreamaSERKS2_");

      procedure Advance (this : access CodedOutputStream; amount : int);  -- ../../../../src/google/protobuf/io/coded_stream.h:1345
      pragma Import (CPP, Advance, "_ZN6google8protobuf2io17CodedOutputStream7AdvanceEi");

      function Refresh (this : access CodedOutputStream) return Extensions.bool;  -- ../../../../src/google/protobuf/io/coded_stream.h:891
      pragma Import (CPP, Refresh, "_ZN6google8protobuf2io17CodedOutputStream7RefreshEv");

      procedure WriteAliasedRaw
        (this : access CodedOutputStream;
         buffer : System.Address;
         size : int);  -- ../../../../src/google/protobuf/io/coded_stream.h:895
      pragma Import (CPP, WriteAliasedRaw, "_ZN6google8protobuf2io17CodedOutputStream15WriteAliasedRawEPKvi");

      procedure WriteVarint32SlowPath (this : access CodedOutputStream; value : google.protobuf.binding.port_h.uint32);  -- ../../../../src/google/protobuf/io/coded_stream.h:899
      pragma Import (CPP, WriteVarint32SlowPath, "_ZN6google8protobuf2io17CodedOutputStream21WriteVarint32SlowPathEj");

      procedure WriteVarint64SlowPath (this : access CodedOutputStream; value : google.protobuf.binding.port_h.uint64);  -- ../../../../src/google/protobuf/io/coded_stream.h:900
      pragma Import (CPP, WriteVarint64SlowPath, "_ZN6google8protobuf2io17CodedOutputStream21WriteVarint64SlowPathEm");

      package Static is
         function WriteRawToArray
           (buffer : System.Address;
            size : int;
            target : access google.protobuf.binding.port_h.uint8) return access google.protobuf.binding.port_h.uint8;  -- ../../../../src/google/protobuf/io/coded_stream.h:742
         pragma Import (CPP, WriteRawToArray, "_ZN6google8protobuf2io17CodedOutputStream15WriteRawToArrayEPKviPh");

         function WriteStringToArray (str : Interfaces_CPP.Strings.CPP_String_External; target : access google.protobuf.binding.port_h.uint8) return access google.protobuf.binding.port_h.uint8;  -- ../../../../src/google/protobuf/io/coded_stream.h:1332
         pragma Import (CPP, WriteStringToArray, "_ZN6google8protobuf2io17CodedOutputStream18WriteStringToArrayERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEPh");

         function WriteStringWithSizeToArray (str : Interfaces_CPP.Strings.CPP_String_External; target : access google.protobuf.binding.port_h.uint8) return access google.protobuf.binding.port_h.uint8;  -- ../../../../src/google/protobuf/io/coded_stream.h:749
         pragma Import (CPP, WriteStringWithSizeToArray, "_ZN6google8protobuf2io17CodedOutputStream26WriteStringWithSizeToArrayERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEPh");

         function WriteLittleEndian32ToArray (value : google.protobuf.binding.port_h.uint32; target : access google.protobuf.binding.port_h.uint8) return access google.protobuf.binding.port_h.uint8;  -- ../../../../src/google/protobuf/io/coded_stream.h:1223
         pragma Import (CPP, WriteLittleEndian32ToArray, "_ZN6google8protobuf2io17CodedOutputStream26WriteLittleEndian32ToArrayEjPh");

         function WriteLittleEndian64ToArray (value : google.protobuf.binding.port_h.uint64; target : access google.protobuf.binding.port_h.uint8) return access google.protobuf.binding.port_h.uint8;  -- ../../../../src/google/protobuf/io/coded_stream.h:1236
         pragma Import (CPP, WriteLittleEndian64ToArray, "_ZN6google8protobuf2io17CodedOutputStream26WriteLittleEndian64ToArrayEmPh");

         function WriteVarint32ToArray (value : google.protobuf.binding.port_h.uint32; target : access google.protobuf.binding.port_h.uint8) return access google.protobuf.binding.port_h.uint8;  -- ../../../../src/google/protobuf/io/coded_stream.h:1192
         pragma Import (CPP, WriteVarint32ToArray, "_ZN6google8protobuf2io17CodedOutputStream20WriteVarint32ToArrayEjPh");

         function WriteVarint64ToArray (value : google.protobuf.binding.port_h.uint64; target : access google.protobuf.binding.port_h.uint8) return access google.protobuf.binding.port_h.uint8;  -- ../../../../src/google/protobuf/io/coded_stream.h:1203
         pragma Import (CPP, WriteVarint64ToArray, "_ZN6google8protobuf2io17CodedOutputStream20WriteVarint64ToArrayEmPh");

         function WriteVarint32SignExtendedToArray (value : google.protobuf.binding.port_h.int32; target : access google.protobuf.binding.port_h.uint8) return access google.protobuf.binding.port_h.uint8;  -- ../../../../src/google/protobuf/io/coded_stream.h:1218
         pragma Import (CPP, WriteVarint32SignExtendedToArray, "_ZN6google8protobuf2io17CodedOutputStream32WriteVarint32SignExtendedToArrayEiPh");

         function WriteTagToArray (value : google.protobuf.binding.port_h.uint32; target : access google.protobuf.binding.port_h.uint8) return access google.protobuf.binding.port_h.uint8;  -- ../../../../src/google/protobuf/io/coded_stream.h:1286
         pragma Import (CPP, WriteTagToArray, "_ZN6google8protobuf2io17CodedOutputStream15WriteTagToArrayEjPh");

         function VarintSize32 (value : google.protobuf.binding.port_h.uint32) return google.protobuf.binding.stddef_h.size_t;  -- ../../../../src/google/protobuf/io/coded_stream.h:1291
         pragma Import (CPP, VarintSize32, "_ZN6google8protobuf2io17CodedOutputStream12VarintSize32Ej");

         function VarintSize64 (value : google.protobuf.binding.port_h.uint64) return google.protobuf.binding.stddef_h.size_t;  -- ../../../../src/google/protobuf/io/coded_stream.h:1301
         pragma Import (CPP, VarintSize64, "_ZN6google8protobuf2io17CodedOutputStream12VarintSize64Em");

         function VarintSize32SignExtended (value : google.protobuf.binding.port_h.int32) return google.protobuf.binding.stddef_h.size_t;  -- ../../../../src/google/protobuf/io/coded_stream.h:1311
         pragma Import (CPP, VarintSize32SignExtended, "_ZN6google8protobuf2io17CodedOutputStream24VarintSize32SignExtendedEi");

         function IsDefaultSerializationDeterministic return Extensions.bool;  -- ../../../../src/google/protobuf/io/coded_stream.h:867
         pragma Import (CPP, IsDefaultSerializationDeterministic, "_ZN6google8protobuf2io17CodedOutputStream35IsDefaultSerializationDeterministicEv");

         procedure SetDefaultSerializationDeterministic;  -- ../../../../src/google/protobuf/io/coded_stream.h:910
         pragma Import (CPP, SetDefaultSerializationDeterministic, "_ZN6google8protobuf2io17CodedOutputStream36SetDefaultSerializationDeterministicEv");
      end;

      function WriteRawToArray
        (buffer : System.Address;
         size : int;
         target : access google.protobuf.binding.port_h.uint8) return access google.protobuf.binding.port_h.uint8 renames Static.WriteRawToArray;

      function WriteStringToArray (str : Interfaces_CPP.Strings.CPP_String_External; target : access google.protobuf.binding.port_h.uint8) return access google.protobuf.binding.port_h.uint8 renames Static.WriteStringToArray;

      function WriteStringWithSizeToArray (str : Interfaces_CPP.Strings.CPP_String_External; target : access google.protobuf.binding.port_h.uint8) return access google.protobuf.binding.port_h.uint8 renames Static.WriteStringWithSizeToArray;

      function WriteLittleEndian32ToArray (value : google.protobuf.binding.port_h.uint32; target : access google.protobuf.binding.port_h.uint8) return access google.protobuf.binding.port_h.uint8 renames Static.WriteLittleEndian32ToArray;

      function WriteLittleEndian64ToArray (value : google.protobuf.binding.port_h.uint64; target : access google.protobuf.binding.port_h.uint8) return access google.protobuf.binding.port_h.uint8 renames Static.WriteLittleEndian64ToArray;

      function WriteVarint32ToArray (value : google.protobuf.binding.port_h.uint32; target : access google.protobuf.binding.port_h.uint8) return access google.protobuf.binding.port_h.uint8 renames Static.WriteVarint32ToArray;

      function WriteVarint64ToArray (value : google.protobuf.binding.port_h.uint64; target : access google.protobuf.binding.port_h.uint8) return access google.protobuf.binding.port_h.uint8 renames Static.WriteVarint64ToArray;

      function WriteVarint32SignExtendedToArray (value : google.protobuf.binding.port_h.int32; target : access google.protobuf.binding.port_h.uint8) return access google.protobuf.binding.port_h.uint8 renames Static.WriteVarint32SignExtendedToArray;

      function WriteTagToArray (value : google.protobuf.binding.port_h.uint32; target : access google.protobuf.binding.port_h.uint8) return access google.protobuf.binding.port_h.uint8 renames Static.WriteTagToArray;

      function VarintSize32 (value : google.protobuf.binding.port_h.uint32) return google.protobuf.binding.stddef_h.size_t renames Static.VarintSize32;

      function VarintSize64 (value : google.protobuf.binding.port_h.uint64) return google.protobuf.binding.stddef_h.size_t renames Static.VarintSize64;

      function VarintSize32SignExtended (value : google.protobuf.binding.port_h.int32) return google.protobuf.binding.stddef_h.size_t renames Static.VarintSize32SignExtended;

      function IsDefaultSerializationDeterministic return Extensions.bool renames Static.IsDefaultSerializationDeterministic;

      procedure SetDefaultSerializationDeterministic renames Static.SetDefaultSerializationDeterministic;

      default_serialization_deterministic_u : aliased google.protobuf.binding.atomicops_h.AtomicWord;  -- ../../../../src/google/protobuf/io/coded_stream.h:884
      pragma Import (CPP, default_serialization_deterministic_u, "_ZN6google8protobuf2io17CodedOutputStream36default_serialization_deterministic_E");
   end;
   use Class_CodedOutputStream;

   procedure MapTestForceDeterministic;  -- ../../../../src/google/protobuf/io/coded_stream.h:909
   pragma Import (CPP, MapTestForceDeterministic, "_ZN6google8protobuf8internal25MapTestForceDeterministicEv");

end google.protobuf.binding.coded_stream_h;
