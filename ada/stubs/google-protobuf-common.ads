-- Protocol Buffers - Google's data interchange format
-- https://github.com/zackboll/protobuf
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

--
-- Currently, this package imports an auto-generated file from the C++
-- implementation common.h.  This package is maintained for code aesthetics
--

with Google.Protobuf.Binding.common_h;

package Google.Protobuf.Common is

  Google_Protobuf_Version : constant :=
    Google.Protobuf.Binding.common_h.GOOGLE_PROTOBUF_VERSION;

  Google_Protobuf_Version_Suffix : constant String :=
    Google.Protobuf.Binding.common_h.GOOGLE_PROTOBUF_VERSION_SUFFIX;

  Google_Protobuf_Min_Library_Version : constant :=
    Google.Protobuf.Binding.common_h.GOOGLE_PROTOBUF_MIN_LIBRARY_VERSION;

  Google_Protobuf_Min_Protoc_Version : constant :=
    Google.Protobuf.Binding.common_h.GOOGLE_PROTOBUF_MIN_PROTOC_VERSION;

  -- ===================================================================
  -- Shutdown support.

  -- Shut down the entire protocol buffers library, deleting all static-duration
  -- objects allocated by the library or by generated .pb.cc files.
  --
  -- There are two reasons you might want to call this:
  -- * You use a draconian definition of "memory leak" in which you expect
  --   every single malloc() to have a corresponding free(), even for objects
  --   which live until program exit.
  -- * You are writing a dynamically-loaded library which needs to clean up
  --   after itself when the library is unloaded.
  --
  -- It is safe to call this multiple times.  However, it is not safe to use
  -- any other part of the protocol buffers library after
  -- ShutdownProtobufLibrary() has been called.

  procedure Shutdown_Protobuf_Library;

end Google.Protobuf.Common;
