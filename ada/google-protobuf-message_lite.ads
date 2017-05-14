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


package Google.Protobuf.Message_Lite is

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
  type Message_Lite is abstract tagged private;

  procedure Initialize (Msg : in out Message_Lite) is null;
  procedure Finalize   (Msg : in out Message_Lite) is abstract;

  -- Basic Operations ------------------------------------------------

  -- Get the name of this message type, e.g. "foo.bar.BazProto".
  function Get_Type_Name (Msg: not null access constant Message_Lite)
                          return String is abstract;

  -- Construct a new instance of the same type.  Ownership is passed to the
  -- caller.
  function New_Message (Msg : not null access constant Message_Lite)
                        return access Message_Lite is abstract;

  -- Get the arena, if any, associated with this message. Virtual method
  -- required for generic operations but most arena-related operations should
  -- use the GetArenaNoVirtual() generated-code method. Default implementation
  -- to reduce code size by avoiding the need for per-type implementations when
  -- types do not implement arena support.
  -- :TODO: Implement for Ada

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
    (Msg: not null access constant Message_Lite) return String is abstract;

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

private

  type Message_Lite is abstract tagged null record;

end Google.Protobuf.Message_Lite;
