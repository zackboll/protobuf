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
with Interfaces.C;
with Interfaces_CPP; use Interfaces_CPP;
with Unchecked_Conversion;


package body Google.Protobuf.Message_Lite is

  --
  -- Class wide access type used for dynamic dispatching where necessary
  --
  type Class_Wide_Access is access all Message_Lite'class;

  type unsigned_char_access is access all Interfaces.C.unsigned_char;
  type char_access is access all Interfaces.C.char;
  function to_uchar_access is new Unchecked_Conversion
    (Source => char_access, Target => unsigned_char_access);

  function Initialization_Error_Message (Action : String;
                                         Msg    : not null access Message_Lite)
                                         return String is

  begin

    -- Note:  We want to avoid depending on strutil in the lite library, otherwise
    --   we'd use:
    --
    -- return strings::Substitute(
    --   "Can't $0 message of type \"$1\" because it is missing required "
    --   "fields: $2",
    --   action, message.GetTypeName(),
    --   message.InitializationErrorString());
    return "Can't " & Action & " message of type """ &
      Class_Wide_Access (Msg).Get_Type_Name &
      """ because it is missing required fields: " &
      Class_Wide_Access (Msg).Initialization_Error_String;

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
    (Data    : not null access Interfaces.C.char_array;
     Message : not null access Message_Lite)
     return Boolean with Inline_Always => True is

    use Google.Protobuf.IO;
    use Google.Protobuf.Binding.coded_stream_h;
    use Google.Protobuf.Binding.coded_stream_h.Class_CodedInputStream;
    use Interfaces.C;

    Input : aliased Coded_Input_Stream := New_CodedInputStream
      (buffer => to_uchar_access (Data (Data'first)'access),
       size   => int (Data.all'length));

  begin

    return Inline_Parse_From_Coded_Stream (Input => Input'access,
                                           Message => Message) and
      To_Boolean (Class_CodedInputStream.ConsumedEntireMessage (Input'access));

  end Inline_Parse_From_Array;


  function Inline_Parse_Partial_From_Array
    (Data    : not null access Interfaces.C.char_array;
     Message : not null access Message_Lite)
     return Boolean with Inline_Always => True is

    use Google.Protobuf.IO;
    use Google.Protobuf.Binding.coded_stream_h;
    use Google.Protobuf.Binding.coded_stream_h.Class_CodedInputStream;
    use Interfaces.C;

    Input : aliased Coded_Input_Stream := New_CodedInputStream
      (buffer => to_uchar_access (Data (Data'first)'access),
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
    data_array : aliased char_array := To_C (Item => Data, Append_Nul => False);

  begin

    return Inline_Parse_From_Array (Data => data_array'access, Message => Msg);

  end Parse_From_String;


  function Parse_From_Partial_String
    (Msg  : not null access Message_Lite;
     Data : String) return Boolean is

    use Interfaces.C;
    data_array : aliased char_array := To_C (Item => Data, Append_Nul => False);

  begin

    return Inline_Parse_Partial_From_Array
      (Data => data_array'access, Message => Msg);

  end Parse_From_Partial_String;

  function Merge_From_Coded_Stream
    (Msg   : not null access Message_Lite;
     Input : not null access Google.Protobuf.IO.Coded_Input_Stream)
     return Boolean is

  begin

    return Inline_Merge_From_Coded_Stream (Input => Input, Message => Msg);

  end Merge_From_Coded_Stream;

end Google.Protobuf.Message_Lite;
