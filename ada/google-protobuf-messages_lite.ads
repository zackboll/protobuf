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

with Google.Protobuf.Arena;
with Google.Protobuf.IO;
with Google.Protobuf.Port;

with Ada.Finalization;
with Interfaces.C;

package Google.Protobuf.Messages_Lite is

  -- Interface to light weight protocol messages.
  --
  -- This interface is implemented by all protocol message objects.  Non-lite
  -- messages additionally implement the Message interface, which is a
  -- subclass of MessageLite.  Use MessageLite instead when you only need
  -- the subset of features which it supports -- namely, nothing that uses
  -- descriptors or reflection.  You can instruct the protocol compiler
  -- to generate classes which implement only MessageLite, not the full
  -- Message interface, by adding the following line to the .proto file:
  --
  --   option optimize_for = LITE_RUNTIME;
  --
  -- This is particularly useful on resource-constrained systems where
  -- the full protocol buffers runtime library is too big.
  --
  -- Note that on non-constrained systems (e.g. servers) when you need
  -- to link in lots of protocol definitions, a better way to reduce
  -- total code footprint is to use optimize_for = CODE_SIZE.  This
  -- will make the generated code smaller while still supporting all the
  -- same features (at the expense of speed).  optimize_for = LITE_RUNTIME
  -- is best when you only have a small number of message types linked
  -- into your binary, in which case the size of the protocol buffers
  -- runtime itself is the biggest problem.
  type Message_Lite is abstract new Ada.Finalization.Controlled with private;

  overriding procedure Initialize (Msg : in out Message_Lite) is null;
  overriding procedure Finalize   (Msg : in out Message_Lite) is null;

  -- Basic Operations ------------------------------------------------

  -- Get the name of this message type, e.g. "foo.bar.BazProto".
  function Get_Type_Name (Msg: not null access constant Message_Lite)
                          return String is abstract;

  -- Construct a new instance of the same type.  Ownership is passed to the
  -- caller.
  function New_Message (Msg : not null access constant Message_Lite)
                        return access Message_Lite is abstract;

  -- Construct a new instance on the arena. Ownership is passed to the caller
  -- if arena is a NULL. Default implementation for backwards compatibility.
  --
  -- Since the Ada implementation is to dynamically dispatch to the abstract
  -- routine "New_Message", the concrete implementation cannot be provided
  -- here per Ada LRM rules and must be provided by the first non-abstract
  -- derivation of this class.
  function New_Message (Msg   : not null access constant Message_Lite;
                        Arena : access Google.Protobuf.Arena.Arena)
    return access Message_Lite is abstract;

  -- Get the arena, if any, associated with this message. Virtual method
  -- required for generic operations but most arena-related operations should
  -- use the GetArenaNoVirtual() generated-code method. Default implementation
  -- to reduce code size by avoiding the need for per-type implementations when
  -- types do not implement arena support.
  -- :TODO: Implement for Ada
  --virtual ::google::protobuf::Arena* GetArena() const { return NULL; }

  -- Get a pointer that may be equal to this message's arena, or may not be. If
  -- the value returned by this method is equal to some arena pointer, then this
  -- message is on that arena; however, if this message is on some arena, this
  -- method may or may not return that arena's pointer. As a tradeoff, this
  -- method may be more efficient than GetArena(). The intent is to allow
  -- underlying representations that use e.g. tagged pointers to sometimes store
  -- the arena pointer directly, and sometimes in a more indirect way, and allow
  -- a fastpath comparison against the arena pointer when it's easy to obtain.
  -- TODO:
  --virtual void* GetMaybeArenaPointer() const { return GetArena(); }

  -- Clear all fields of the message and set them to their default values.
  -- Clear() avoids freeing memory, assuming that any memory allocated
  -- to hold parts of the message will be needed again to hold the next
  -- message.  If you actually want to free the memory used by a Message,
  -- you must delete it.
  procedure Clear (Msg: not null access Message_Lite) is abstract;

  -- Quickly check if all required fields have values set.
  function Is_Initialized (Msg: not null access constant Message_Lite)
                           return Boolean is abstract;

  -- This is not implemented for Lite messages -- it just returns "(cannot
  -- determine missing fields for lite message)".  However, it is implemented
  -- for full messages.  See message.h.
  function Initialization_Error_String
    (Msg: not null access constant Message_Lite) return String;

  -- If |other| is the exact same class as this, calls MergeFrom().  Otherwise,
  -- results are undefined (probably crash).
  procedure Check_Type_And_Merge_From
    (Msg   : not null access Message_Lite;
     Other : not null access constant Message_Lite) is abstract;

  -- Parsing ---------------------------------------------------------
  -- Methods for parsing in protocol buffer format.  Most of these are
  -- just simple wrappers around MergeFromCodedStream().  Clear() will be called
  -- before merging the input.

  -- Fill the message with a protocol buffer parsed from the given input stream.
  -- Returns false on a read error or if the input is in the wrong format.  A
  -- successful return does not indicate the entire input is consumed, ensure
  -- you call ConsumedEntireMessage() to check that if applicable.
  function Parse_From_Coded_Stream
    (Msg   : not null access Message_Lite;
     Input : not null access Google.Protobuf.IO.Coded_Input_Stream)
     return Boolean;

  -- Like ParseFromCodedStream(), but accepts messages that are missing
  -- required fields.
  function Parse_Partial_From_Coded_Stream
    (Msg   : not null access Message_Lite;
     Input : not null access Google.Protobuf.IO.Coded_Input_Stream)
     return Boolean;

  -- Read a protocol buffer from the given zero-copy input stream.  If
  -- successful, the entire input will be consumed.
  function Parse_From_Zero_Copy_Stream
    (Msg   : not null access Message_Lite;
     Input : not null access Google.Protobuf.IO.Zero_Copy_Input_Stream)
     return Boolean;

  -- Like ParseFromZeroCopyStream(), but accepts messages that are missing
  -- required fields.
  function Parse_Partial_From_Zero_Copy_Stream
    (Msg   : not null access Message_Lite;
     Input : not null access Google.Protobuf.IO.Zero_Copy_Input_Stream)
     return Boolean;

  -- Read a protocol buffer from the given zero-copy input stream, expecting
  -- the message to be exactly "size" bytes long.  If successful, exactly
  -- this many bytes will have been consumed from the input.
  function Parse_From_Bounded_Zero_Copy_Stream
    (Msg   : not null access Message_Lite;
     Input : not null access Google.Protobuf.IO.Zero_Copy_Input_Stream;
     Size  : Integer) return Boolean;

  -- Like ParseFromBoundedZeroCopyStream(), but accepts messages that are
  -- missing required fields.
  function Parse_Partial_From_Bounded_Zero_Copy_Stream
    (Msg   : not null access Message_Lite;
     Input : not null access Google.Protobuf.IO.Zero_Copy_Input_Stream;
     Size  : Integer) return Boolean;

  -- Parses a protocol buffer contained in a string. Returns true on success.
  -- This function takes a string in the (non-human-readable) binary wire
  -- format, matching the encoding output by MessageLite::SerializeToString().
  -- If you'd like to convert a human-readable string into a protocol buffer
  -- object, see google::protobuf::TextFormat::ParseFromString().
  function Parse_From_String
    (Msg  : not null access Message_Lite;
     Data : String) return Boolean;

  -- Like ParseFromString(), but accepts messages that are missing
  -- required fields.
  function Parse_From_Partial_String
    (Msg  : not null access Message_Lite;
     Data : String) return Boolean;

  -- Parse a protocol buffer contained in an array of bytes.
  function Parse_From_Array
    (Msg : not null access Message_Lite;
     Data: not null access constant Interfaces.C.char_array) return Boolean;

  -- Like ParseFromArray(), but accepts messages that are missing
  -- required fields.
  function Parse_Partial_From_Array
    (Msg  : not null access Message_Lite;
     Data : not null access constant Interfaces.C.char_array) return Boolean;


  -- Reads a protocol buffer from the stream and merges it into this
  -- Message.  Singular fields read from the input overwrite what is
  -- already in the Message and repeated fields are appended to those
  -- already present.
  --
  -- It is the responsibility of the caller to call input->LastTagWas()
  -- (for groups) or input->ConsumedEntireMessage() (for non-groups) after
  -- this returns to verify that the message's end was delimited correctly.
  --
  -- ParsefromCodedStream() is implemented as Clear() followed by
  -- MergeFromCodedStream().
  function Merge_From_Coded_Stream
    (Msg   : not null access Message_Lite;
     Input : not null access Google.Protobuf.IO.Coded_Input_Stream)
     return Boolean;

  -- Like MergeFromCodedStream(), but succeeds even if required fields are
  -- missing in the input.
  --
  -- MergeFromCodedStream() is just implemented as MergePartialFromCodedStream()
  -- followed by IsInitialized().
  function Merge_Partial_From_Coded_Stream
    (Msg   : not null access Message_Lite;
     Input : not null access Google.Protobuf.IO.Coded_Input_Stream)
    return Boolean is abstract;

  -- Serialization ---------------------------------------------------
  -- Methods for serializing in protocol buffer format.  Most of these
  -- are just simple wrappers around ByteSize() and SerializeWithCachedSizes().

  -- Write a protocol buffer of this message to the given output.  Returns
  -- false on a write error.  If the message is missing required fields,
  -- this may GOOGLE_CHECK-fail.
  function Serialize_To_Coded_Stream
    (Msg    : not null access constant Message_Lite;
     Output : not null access Google.Protobuf.IO.Coded_Output_Stream)
     return Boolean;

  -- Like SerializeToCodedStream(), but allows missing required fields.
  function Serialize_Partial_To_Coded_Stream
    (Msg    : not null access constant Message_Lite;
     Output : not null access Google.Protobuf.IO.Coded_Output_Stream)
     return Boolean;

  -- Write the message to the given zero-copy output stream.  All required
  -- fields must be set.
  function Serialize_To_Zero_Copy_Stream
    (Msg    : not null access constant Message_Lite;
     Output : not null access Google.Protobuf.IO.Zero_Copy_Output_Stream)
     return Boolean;

  -- Like SerializeToZeroCopyStream(), but allows missing required fields.
  function Serialize_Partial_To_Zero_Copy_Stream
    (Msg    : not null access constant Message_Lite;
     Output : not null access Google.Protobuf.IO.Zero_Copy_Output_Stream)
     return Boolean;

  --
  -- For Ada implementation, do not implement the SerializeToString routines
  -- as it is not clear entirely why this would be useful.
  -- TODO: Evaluate at later date whether SerializeToString adds value to Ada
  -- runtime
  --


  -- Computes the serialized size of the message.  This recursively calls
  -- ByteSizeLong() on all embedded messages.
  --
  -- ByteSizeLong() is generally linear in the number of fields defined for the
  -- proto.
  function Byte_Size_Long (Msg : not null access constant Message_Lite)
                           return Interfaces.Unsigned_64 is abstract;

  -- Legacy ByteSize() API.
  -- TODO:
  --int ByteSize() const { return internal::ToIntSize(ByteSizeLong()); }

  -- Serializes the message without recomputing the size.  The message must not
  -- have changed since the last call to ByteSize(), and the value returned by
  -- ByteSize must be non-negative.  Otherwise the results are undefined.
  procedure Serialize_With_Cached_Sizes
    (Msg    : not null access constant Message_Lite;
     Output : not null access Google.Protobuf.IO.Coded_Output_Stream)
  is abstract;

  -- Functions below here are not part of the public interface.  It isn't
  -- enforced, but they should be treated as private, and will be private
  -- at some future time.  Unfortunately the implementation of the "friend"
  -- keyword in GCC is broken at the moment, but we expect it will be fixed.

  -- Like SerializeWithCachedSizes, but writes directly to *target, returning
  -- a pointer to the byte immediately after the last byte written.  "target"
  -- must point at a byte array of at least ByteSize() bytes.  Whether to use
  -- deterministic serialization, e.g., maps in sorted order, is determined by
  -- CodedOutputStream::IsDefaultSerializationDeterministic().
  -- virtual uint8* SerializeWithCachedSizesToArray(uint8* target) const;

  -- Returns the result of the last call to ByteSize().  An embedded message's
  -- size is needed both to serialize it (because embedded messages are
  -- length-delimited) and to compute the outer message's size.  Caching
  -- the size avoids computing it multiple times.
  --
  -- ByteSize() does not automatically use the cached size when available
  -- because this would require invalidating it every time the message was
  -- modified, which would be too hard and expensive.  (E.g. if a deeply-nested
  -- sub-message is changed, all of its parents' cached sizes would need to be
  -- invalidated, which is too much work for an otherwise inlined setter
  -- method.)
  -- TODO:
  -- virtual int GetCachedSize() const = 0;

  function Internal_Serialize_With_Cached_Sizes_To_Array
    (Msg           : not null access constant Message_Lite;
     Deterministic : Boolean;
     Target        : access Google.Protobuf.Port.uint8)
     return access Google.Protobuf.Port.uint8 is abstract;

private

  type Message_Lite is abstract new Ada.Finalization.Controlled with
    null record;

end Google.Protobuf.Messages_Lite;
