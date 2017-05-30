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
with Google.Protobuf.Messages_Lite;

package Google.Protobuf.Messages is

  -- Abstract interface for protocol messages.
  --
  -- See also MessageLite, which contains most every-day operations.  Message
  -- adds descriptors and reflection on top of that.
  --
  -- The methods of this class that are virtual but not pure-virtual have
  -- default implementations based on reflection.  Message classes which are
  -- optimized for speed will want to override these with faster implementations,
  -- but classes optimized for code size may be happy with keeping them.  See
  -- the optimize_for option in descriptor.proto.
  type Message is abstract new Google.Protobuf.Messages_Lite.Message_Lite
  with private;

  overriding procedure Initialize (Msg : in out Message) is null;
  overriding procedure Finalize   (Msg : in out Message) is abstract;

  -- Basic Operations ------------------------------------------------

  -- Construct a new instance of the same type.  Ownership is passed to the
  -- caller.  (This is also defined in MessageLite, but is defined again here
  -- for return-type covariance.)
  overriding function New_Message (Msg: not null access constant Message)
                                   return access Message is abstract;

  -- Construct a new instance on the arena. Ownership is passed to the caller
  -- if arena is a NULL. Default implementation allows for API compatibility
  -- during the Arena transition.
  --
  -- Since the Ada implementation is to dynamically dispatch to the abstract
  -- routine "New_Message", the concrete implementation cannot be provided
  -- here per Ada LRM rules and must be provided by the first non-abstract
  -- derivation of this class.
  overriding function New_Message
    (Msg   : not null access constant Message;
     Arena : access Google.Protobuf.Arena.Arena)
     return access Message is abstract;

  -- Make this message into a copy of the given message.  The given message
  -- must have the same descriptor, but need not necessarily be the same class.
  -- By default this is just implemented as "Clear(); MergeFrom(from);".
  not overriding procedure Copy_From (Msg  : not null access Message;
                                      From : not null access constant Message);

private

  type Message is abstract new Google.Protobuf.Messages_Lite.Message_Lite
    with null record;

end Google.Protobuf.Messages;
