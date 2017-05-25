-- Protocol Buffers - Google's data interchange format
-- https:  --github.com/zackboll/protobuf
--
-- Redistribution and use in source and binary forms, with or without
-- modification, are permitted provided that the following conditions are
-- met:
--
--     * Redistributions of source code must retain the above copyright
-- notice, this list of conditions and the following disclaimer.
--     * Redistributions in binary form must reproduce the above
-- copyright notice, this list of conditions and the following disclaimer
-- in the documentation and/or other materials provided with the
-- distribution.
--     * Neither the name of Google Inc. nor the names of its
-- contributors may be used to endorse or promote products derived from
-- this software without specific prior written permission.
--
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

with Google.Protobuf.Binding.coded_stream_h;

with Ada.Text_IO;
with Interfaces_CPP; use Interfaces_CPP;
with System.Storage_Elements;
with Unchecked_Conversion;


package body Google.Protobuf.Messages_Lite is

  --
  -- Class wide access types used for dynamic dispatching
  --
  type Class_Wide_Access is access all Message_Lite'class;
  type Class_Wide_Access_Constant is access constant Message_Lite'class;

  type unsigned_char_access_constant is
    access constant Interfaces.C.unsigned_char;
  type char_access_constant is access constant Interfaces.C.char;

  function to_uchar_access_constant is new Unchecked_Conversion
    (Source => char_access_constant, Target => unsigned_char_access_constant);


  function Initialization_Error_String
    (Msg : not null access constant Message_Lite) return String is

    pragma Unreferenced (Msg);

  begin

    return "(cannot determine missing fields for lite message)";

  end Initialization_Error_String;


-- When serializing, we first compute the byte size, then serialize the message.
-- If serialization produces a different number of bytes than expected, we
-- call this function, which crashes.  The problem could be due to a bug in the
-- protobuf implementation but is more likely caused by concurrent modification
-- of the message.  This function attempts to distinguish between the two and
-- provide a useful error message.
  procedure Byte_Size_Consistency_Error
    (byte_size_before_serialization  : Interfaces.Unsigned_64;
     byte_size_after_serialization   : Interfaces.Unsigned_64;
     bytes_produced_by_serialization : Interfaces.Unsigned_64;
     message                         : not null access constant Message_Lite) is

    pragma Unreferenced
      (byte_size_before_serialization,
       byte_size_after_serialization,
       bytes_produced_by_serialization,
       message);

  begin

    --
    -- TODO: Complete, needs binding to Google Log
    --
    Ada.Text_IO.Put_Line ("--TODO: Byte_Size_Consistency_Error");

  end Byte_Size_Consistency_Error;


  function Initialization_Error_Message
    (Action : String;
     Msg    : not null access constant Message_Lite)
     return String is

  begin

    return "Can't " & Action & " message of type """ &
      Class_Wide_Access_Constant (Msg).Get_Type_Name &
      """ because it is missing required fields: " &
      Class_Wide_Access_Constant (Msg).Initialization_Error_String;

  end Initialization_Error_Message;

  function Inline_Merge_From_Coded_Stream
    (Input   : not null access Google.Protobuf.IO.Coded_Input_Stream;
     Message : not null access Message_Lite) return Boolean
    with Inline_Always => True is

  begin

    if not Class_Wide_Access (Message).Merge_Partial_From_Coded_Stream (Input)
    then
      return False;
    end if;

    if Class_Wide_Access (Message).Is_Initialized then
      --
      -- TODO: create binding to GLOG for Ada, for now dump error to screen
      --
      Ada.Text_IO.Put_Line (Initialization_Error_Message ("parse", Message));
      return False;

    end if;

    return True;

  end Inline_Merge_From_Coded_Stream;


  function Inline_Parse_From_Coded_Stream
    (Input   : not null access Google.Protobuf.IO.Coded_Input_Stream;
     Message : not null access Message_Lite) return Boolean
    with Inline_Always => True is

  begin

    Class_Wide_Access (Message).Clear;
    return Inline_Merge_From_Coded_Stream (Input, Message);

  end Inline_Parse_From_Coded_Stream;


  function Inline_Parse_Partial_From_Coded_Stream
    (Input   : not null access Google.Protobuf.IO.Coded_Input_Stream;
     Message : not null access Message_Lite) return Boolean
    with Inline_Always => True is

  begin

    Class_Wide_Access (Message).Clear;
    return Class_Wide_Access (Message).Merge_Partial_From_Coded_Stream (Input);

  end Inline_Parse_Partial_From_Coded_Stream;


  function Inline_Parse_From_Array
    (Data    : not null access constant Interfaces.C.char_array;
     Message : not null access Message_Lite)
     return Boolean with Inline_Always => True is

    use Google.Protobuf.IO;
    use Google.Protobuf.Binding.coded_stream_h;
    use Google.Protobuf.Binding.coded_stream_h.Class_CodedInputStream;
    use Interfaces.C;

    Input : aliased Coded_Input_Stream := New_CodedInputStream2
      (buffer => to_uchar_access_constant (Data (Data'first)'access),
       size   => int (Data.all'length));

  begin

    return Inline_Parse_From_Coded_Stream (Input => Input'access,
                                           Message => Message) and
      To_Boolean (Class_CodedInputStream.ConsumedEntireMessage (Input'access));

  end Inline_Parse_From_Array;


  function Inline_Parse_Partial_From_Array
    (Data    : not null access constant Interfaces.C.char_array;
     Message : not null access Message_Lite)
     return Boolean with Inline_Always => True is

    use Google.Protobuf.IO;
    use Google.Protobuf.Binding.coded_stream_h;
    use Google.Protobuf.Binding.coded_stream_h.Class_CodedInputStream;
    use Interfaces.C;

    Input : aliased Coded_Input_Stream := New_CodedInputStream2
      (buffer => to_uchar_access_constant (Data (Data'first)'access),
       size   => int (Data.all'length));

  begin

    return Inline_Parse_Partial_From_Coded_Stream (Input => Input'access,
                                                   Message => Message) and
      To_Boolean (Class_CodedInputStream.ConsumedEntireMessage (Input'access));

  end Inline_Parse_Partial_From_Array;


  function Parse_From_Coded_Stream
    (Msg   : not null access Message_Lite;
     Input : not null access Google.Protobuf.IO.Coded_Input_Stream)
     return Boolean is

  begin

    return Inline_Parse_From_Coded_Stream (Input, Msg);

  end Parse_From_Coded_Stream;


  function Parse_Partial_From_Coded_Stream
    (Msg   : not null access Message_Lite;
     Input : not null access Google.Protobuf.IO.Coded_Input_Stream)
    return Boolean is

  begin

    return Inline_Parse_Partial_From_Coded_Stream (Input, Msg);

  end Parse_Partial_From_Coded_Stream;


  function Parse_From_Zero_Copy_Stream
    (Msg   : not null access Message_Lite;
     Input : not null access Google.Protobuf.IO.Zero_Copy_Input_Stream)
     return Boolean is

    use Google.Protobuf.IO;
    use Google.Protobuf.Binding.coded_stream_h;
    use Google.Protobuf.Binding.coded_stream_h.Class_CodedInputStream;

    Decoder : aliased Coded_Input_Stream := New_CodedInputStream (Input);

  begin

    return Class_Wide_Access (Msg).Parse_From_Coded_Stream
      (Input => Decoder'access) and To_Boolean
      (Class_CodedInputStream.ConsumedEntireMessage (Decoder'access));

  end Parse_From_Zero_Copy_Stream;


  function Parse_Partial_From_Zero_Copy_Stream
    (Msg   : not null access Message_Lite;
     Input : not null access Google.Protobuf.IO.Zero_Copy_Input_Stream)
     return Boolean is

    use Google.Protobuf.IO;
    use Google.Protobuf.Binding.coded_stream_h;
    use Google.Protobuf.Binding.coded_stream_h.Class_CodedInputStream;

    Decoder : aliased Coded_Input_Stream := New_CodedInputStream (Input);

  begin

    return Class_Wide_Access (Msg).
      Parse_Partial_From_Coded_Stream (Decoder'access) and To_Boolean
      (Class_CodedInputStream.ConsumedEntireMessage (Decoder'access));

  end Parse_Partial_From_Zero_Copy_Stream;


  function Parse_From_Bounded_Zero_Copy_Stream
    (Msg   : not null access Message_Lite;
     Input : not null access Google.Protobuf.IO.Zero_Copy_Input_Stream;
     Size  : Integer) return Boolean is

    use Google.Protobuf.IO;
    use Google.Protobuf.Binding.coded_stream_h;
    use Google.Protobuf.Binding.coded_stream_h.Class_CodedInputStream;
    use type Interfaces.C.int;

    Decoder : aliased Coded_Input_Stream := New_CodedInputStream (Input);
    Limit : Google.Protobuf.Binding.coded_stream_h.Limit;
    pragma Unreferenced (Limit);

  begin

    Limit := Class_CodedInputStream.PushLimit
      (this => Decoder'access, byte_limit => Interfaces.C.int (Size));
    return Class_Wide_Access (Msg).Parse_From_Coded_Stream (Decoder'access) and
      To_Boolean (Class_CodedInputStream.ConsumedEntireMessage (Decoder'access))
      and Class_CodedInputStream.BytesUntilLimit (Decoder'access) = 0;

  end Parse_From_Bounded_Zero_Copy_Stream;


  function Parse_Partial_From_Bounded_Zero_Copy_Stream
    (Msg   : not null access Message_Lite;
     Input : not null access Google.Protobuf.IO.Zero_Copy_Input_Stream;
     Size  : Integer) return Boolean is

    use Google.Protobuf.IO;
    use Google.Protobuf.Binding.coded_stream_h;
    use Google.Protobuf.Binding.coded_stream_h.Class_CodedInputStream;
    use type Interfaces.C.int;

    Decoder : aliased Coded_Input_Stream := New_CodedInputStream (Input);
    Limit : Google.Protobuf.Binding.coded_stream_h.Limit;
    pragma Unreferenced (Limit);

  begin

    Limit := Class_CodedInputStream.PushLimit
      (this => Decoder'access, byte_limit => Interfaces.C.int (Size));
    return Class_Wide_Access (Msg).Parse_Partial_From_Coded_Stream
      (Decoder'access) and To_Boolean
      (Class_CodedInputStream.ConsumedEntireMessage (Decoder'access)) and
      Class_CodedInputStream.BytesUntilLimit (Decoder'access) = 0;

  end Parse_Partial_From_Bounded_Zero_Copy_Stream;


  function Parse_From_String
    (Msg  : not null access Message_Lite;
     Data : String) return Boolean is

    use Interfaces.C;
    -- TODO: This is not particularly efficient as we first copy to stack, but
    -- Strings are fixed length and the elements are non-aliased in Ada
    -- so not much we can do about String type without first copying it
    -- due to the implementation of the CodedInputStream type.
    data_array : aliased char_array := To_C (Item => Data, Append_Nul => False);

  begin

    return Inline_Parse_From_Array (Data => data_array'access, Message => Msg);

  end Parse_From_String;


  function Parse_From_Partial_String
    (Msg  : not null access Message_Lite;
     Data : String) return Boolean is

    use Interfaces.C;
    -- TODO: This is not particularly efficient as we first copy to stack, but
    -- Strings are fixed length and the elements are non-aliased in Ada
    -- so not much we can do about String type without first copying it
    -- due to the implementation of the CodedInputStream type.
    data_array : aliased char_array := To_C (Item => Data, Append_Nul => False);

  begin

    return Inline_Parse_Partial_From_Array
      (Data => data_array'access, Message => Msg);

  end Parse_From_Partial_String;


  function Parse_From_Array
    (Msg : not null access Message_Lite;
     Data: not null access constant Interfaces.C.char_array) return Boolean is

    --
    -- For efficiency,
    --

  begin

    return Inline_Parse_From_Array (Data => Data, Message => Msg);

  end Parse_From_Array;


  function Parse_Partial_From_Array
    (Msg  : not null access Message_Lite;
     Data : not null access constant Interfaces.C.char_array) return Boolean is

  begin

    return Inline_Parse_Partial_From_Array
      (Data => Data, Message => Msg);

  end Parse_Partial_From_Array;


  function Merge_From_Coded_Stream
    (Msg   : not null access Message_Lite;
     Input : not null access Google.Protobuf.IO.Coded_Input_Stream)
     return Boolean is

  begin

    return Inline_Merge_From_Coded_Stream (Input => Input, Message => Msg);

  end Merge_From_Coded_Stream;


-- ===================================================================


  function Serialize_To_Coded_Stream
    (Msg    : not null access constant Message_Lite;
     Output : not null access Google.Protobuf.IO.Coded_Output_Stream)
     return Boolean is

    -- Dispatching instance of message
    Message : constant Class_Wide_Access_Constant :=
      Class_Wide_Access_Constant (Msg);

  begin

    --
    -- TODO: Consider implementing Ada binding to Google log, for now, dump
    -- error to terminal
    --
    if not Message.Is_Initialized then

      Ada.Text_IO.Put_Line
        (Initialization_Error_Message
           (Action => "serialize", Msg => Msg));

    end if;

    return Message.Serialize_Partial_To_Coded_Stream (Output);

  end Serialize_To_Coded_Stream;


  function Serialize_Partial_To_Coded_Stream
    (Msg    : not null access constant Message_Lite;
     Output : not null access Google.Protobuf.IO.Coded_Output_Stream)
     return Boolean is

    use Interfaces;
    use Interfaces.C;
    use Google.Protobuf.Port;
    use google.Protobuf.Binding.coded_stream_h;
    use System.Storage_Elements;

    Size : constant Interfaces.Unsigned_64 :=
      Class_Wide_Access_Constant (Msg).Byte_Size_Long;

    buffer, buffer_end : access uint8;

    original_byte_count, final_byte_count : int;

  begin

    if Size > Interfaces.Unsigned_64 (Integer'last) then
      -- TODO: Google Log
      Ada.Text_IO.Put_Line
        ("Error, Exceeded maximum protobuf size of 2GB: " & Size'img);
      return False;
    end if;

    buffer := Class_CodedOutputStream.GetDirectBufferForNBytesAndAdvance
      (this => Output, size => int (Size));

    if buffer /= null then

      buffer_end := Class_Wide_Access_Constant (Msg).
        Internal_Serialize_With_Cached_Sizes_To_Array
          (Deterministic => To_Boolean
             (Class_CodedOutputStream.IsSerializationDeterministic (output)),
           Target        => buffer);

      if Unsigned_64 (buffer_end.all'Address - buffer.all'Address) /= Size then

        Byte_Size_Consistency_Error
          (byte_size_before_serialization => Size,
           byte_size_after_serialization => Class_Wide_Access_Constant (Msg).
               Byte_Size_Long,
           bytes_produced_by_serialization => Unsigned_64
             (buffer_end.all'address - buffer.all'address),
           message => Msg);

      end if;

      return True;

    else

      original_byte_count := Class_CodedOutputStream.ByteCount (Output);
      Class_Wide_Access_Constant (Msg).Serialize_With_Cached_Sizes (Output);

      if To_Boolean (Class_CodedOutputStream.HadError (Output)) then
        return False;
      end if;

      final_byte_count := Class_CodedOutputStream.ByteCount (Output);

      if Unsigned_64(final_byte_count - original_byte_count) /= Size then

        Byte_Size_Consistency_Error
          (byte_size_before_serialization => Size,
           byte_size_after_serialization => Class_Wide_Access_Constant (Msg).
               Byte_Size_Long,
           bytes_produced_by_serialization => Unsigned_64
             (final_byte_count - original_byte_count),
           message => Msg);

      end if;

      return True;

    end if;

  end Serialize_Partial_To_Coded_Stream;


  function Serialize_To_Zero_Copy_Stream
    (Msg    : not null access constant Message_Lite;
     Output : not null access Google.Protobuf.IO.Zero_Copy_Output_Stream)
     return Boolean is

    use Google.Protobuf.IO;
    use google.Protobuf.Binding.coded_stream_h;

    Encoder : aliased Coded_Output_Stream :=
      Class_CodedOutputStream.New_CodedOutputStream (output => Output);

    -- Dispatching message instance
    Message : constant Class_Wide_Access_Constant :=
      Class_Wide_Access_Constant (Msg);

  begin

    return Message.Serialize_To_Coded_Stream (Encoder'access);

  end Serialize_To_Zero_Copy_Stream;


  function Serialize_Partial_To_Zero_Copy_Stream
    (Msg    : not null access constant Message_Lite;
     Output : not null access Google.Protobuf.IO.Zero_Copy_Output_Stream)
     return Boolean is

    use Google.Protobuf.IO;
    use Google.Protobuf.Binding.coded_stream_h;

    Encoder : aliased Coded_Output_Stream :=
      Class_CodedOutputStream.New_CodedOutputStream (Output);

    Message : constant Class_Wide_Access_Constant :=
      Class_Wide_Access_Constant (Msg);

  begin

    return Message.Serialize_Partial_To_Coded_Stream (Encoder'access);

  end Serialize_Partial_To_Zero_Copy_Stream;


end Google.Protobuf.Messages_Lite;
