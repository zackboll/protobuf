pragma Ada_2005;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with google.protobuf.binding.google_protobuf_stubs_port_h;
with System;
with Interfaces.C.Extensions;
--  limited with google.protobuf.binding.cpp_6_2_1_bits_stringfwd_h;
--  with google.protobuf.binding.cpp_6_2_1_bits_stl_pair_h;
with google.protobuf.binding.stddef_h;
with google.protobuf.binding.google_protobuf_stubs_atomicops_h;
with google.protobuf.binding.zero_copy_stream_h;

with Interfaces_CPP.Strings;

package google.protobuf.binding.coded_stream_h is
  
  -- Opaque type used with PushLimit() and PopLimit().  Do not modify
  -- values of this type yourself.  The only reason that this isn't a
  -- struct with private internals is for efficiency.
  -- typedef int Limit;
  subtype Limit is Interfaces.C.int;
  
  
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
  -- Author: kenton@google.com (Kenton Varda)
  --  Based on original Protocol Buffers design by
  --  Sanjay Ghemawat, Jeff Dean, and others.
  -- This file contains the CodedInputStream and CodedOutputStream classes,
  -- which wrap a ZeroCopyInputStream or ZeroCopyOutputStream, respectively,
  -- and allow you to read or write individual pieces of data in various
  -- formats.  In particular, these implement the varint encoding for
  -- integers, a simple variable-length encoding in which smaller numbers
  -- take fewer bytes.
  -- Typically these classes will only be used internally by the protocol
  -- buffer library in order to encode and decode protocol buffers.  Clients
  -- of the library only need to know about this class if they wish to write
  -- custom message parsing or serialization procedures.
  -- CodedOutputStream example:
  --   // Write some data to "myfile".  First we write a 4-byte "magic number"
  --   // to identify the file type, then write a length-delimited string.  The
  --   // string is composed of a varint giving the length followed by the raw
  --   // bytes.
  --   int fd = open("myfile", O_CREAT | O_WRONLY);
  --   ZeroCopyOutputStream* raw_output = new FileOutputStream(fd);
  --   CodedOutputStream* coded_output = new CodedOutputStream(raw_output);
  --   int magic_number = 1234;
  --   char text[] = "Hello world!";
  --   coded_output->WriteLittleEndian32(magic_number);
  --   coded_output->WriteVarint32(strlen(text));
  --   coded_output->WriteRaw(text, strlen(text));
  --   delete coded_output;
  --   delete raw_output;
  --   close(fd);
  -- CodedInputStream example:
  --   // Read a file created by the above code.
  --   int fd = open("myfile", O_RDONLY);
  --   ZeroCopyInputStream* raw_input = new FileInputStream(fd);
  --   CodedInputStream coded_input = new CodedInputStream(raw_input);
  --   coded_input->ReadLittleEndian32(&magic_number);
  --   if (magic_number != 1234) {
  --     cerr << "File not in expected format." << endl;
  --     return;
  --   }
  --   uint32 size;
  --   coded_input->ReadVarint32(&size);
  --   char* text = new char[size + 1];
  --   coded_input->ReadRaw(buffer, size);
  --   text[size] = '\0';
  --   delete coded_input;
  --   delete raw_input;
  --   close(fd);
  --   cout << "Text is: " << text << endl;
  --   delete [] text;
  -- For those who are interested, varint encoding is defined as follows:
  -- The encoding operates on unsigned integers of up to 64 bits in length.
  -- Each byte of the encoded value has the format:
  -- * bits 0-6: Seven bits of the number being encoded.
  -- * bit 7: Zero if this is the last byte in the encoding (in which
  --   case all remaining bits of the number are zero) or 1 if
  --   more bytes follow.
  -- The first byte contains the least-significant 7 bits of the number, the
  -- second byte (if present) contains the next-least-significant 7 bits,
  -- and so on.  So, the binary number 1011000101011 would be encoded in two
  -- bytes as "10101011 00101100".
  -- In theory, varint could be used to encode integers of any length.
  -- However, for practicality we set a limit at 64 bits.  The maximum encoded
  -- length of a number is thus 10 bytes.
  -- Assuming windows is always little-endian.
  -- If MSVC has "/RTCc" set, it will complain about truncating casts at
  -- runtime.  This file contains some intentional truncating casts.
  -- __BYTE_ORDER 
   --  skipped empty struct DescriptorPool

   --  skipped empty struct MessageFactory

  -- Defined in this file.
  -- Defined in other files.
  -- zero_copy_stream.h
   --  skipped empty struct ZeroCopyInputStream

  -- zero_copy_stream.h
   --  skipped empty struct ZeroCopyOutputStream

  -- Class which reads and decodes binary data which is composed of varint-
  -- encoded integers and fixed-width pieces.  Wraps a ZeroCopyInputStream.
  -- Most users will not need to deal with CodedInputStream.
  -- Most methods of CodedInputStream that return a bool return false if an
  -- underlying I/O error occurs or if the data is malformed.  Once such a
  -- failure occurs, the CodedInputStream is broken and is no longer useful.
  -- Create a CodedInputStream that reads from the given ZeroCopyInputStream.
  -- Create a CodedInputStream that reads from the given flat array.  This is
  -- faster than using an ArrayInputStream.  PushLimit(size) is implied by
  -- this constructor.
  -- Destroy the CodedInputStream and position the underlying
  -- ZeroCopyInputStream at the first unread byte.  If an error occurred while
  -- reading (causing a method to return false), then the exact position of
  -- the input stream may be anywhere between the last value that was read
  -- successfully and the stream's byte limit.
  -- Return true if this CodedInputStream reads from a flat array instead of
  -- a ZeroCopyInputStream.
  -- Skips a number of bytes.  Returns false if an underlying read error
  -- occurs.
  -- Sets *data to point directly at the unread part of the CodedInputStream's
  -- underlying buffer, and *size to the size of that buffer, but does not
  -- advance the stream's current position.  This will always either produce
  -- a non-empty buffer or return false.  If the caller consumes any of
  -- this data, it should then call Skip() to skip over the consumed bytes.
  -- This may be useful for implementing external fast parsing routines for
  -- types of data not covered by the CodedInputStream interface.
  -- Like GetDirectBufferPointer, but this method is inlined, and does not
  -- attempt to Refresh() if the buffer is currently empty.
  -- Read raw bytes, copying them into the given buffer.
  -- Like the above, with inlined optimizations. This should only be used
  -- by the protobuf implementation.
  -- Like ReadRaw, but reads into a string.
  -- Implementation Note:  ReadString() grows the string gradually as it
  -- reads in the data, rather than allocating the entire requested size
  -- upfront.  This prevents denial-of-service attacks in which a client
  -- could claim that a string is going to be MAX_INT bytes long in order to
  -- crash the server because it can't allocate this much space at once.
  -- Like the above, with inlined optimizations. This should only be used
  -- by the protobuf implementation.
  -- Read a 32-bit little-endian integer.
  -- Read a 64-bit little-endian integer.
  -- These methods read from an externally provided buffer. The caller is
  -- responsible for ensuring that the buffer has sufficient space.
  -- Read a 32-bit little-endian integer.
  -- Read a 64-bit little-endian integer.
  -- Read an unsigned integer with Varint encoding, truncating to 32 bits.
  -- Reading a 32-bit value is equivalent to reading a 64-bit one and casting
  -- it to uint32, but may be more efficient.
  -- Read an unsigned integer with Varint encoding.
  -- Reads a varint off the wire into an "int". This should be used for reading
  -- sizes off the wire (sizes of strings, submessages, bytes fields, etc).
  -- The value from the wire is interpreted as unsigned.  If its value exceeds
  -- the representable value of an integer on this platform, instead of
  -- truncating we return false. Truncating (as performed by ReadVarint32()
  -- above) is an acceptable approach for fields representing an integer, but
  -- when we are parsing a size from the wire, truncating the value would result
  -- in us misparsing the payload.
  -- Read a tag.  This calls ReadVarint32() and returns the result, or returns
  -- zero (which is not a valid tag) if ReadVarint32() fails.  Also, ReadTag
  -- (but not ReadTagNoLastTag) updates the last tag value, which can be checked
  -- with LastTagWas().
  -- Always inline because this is only called in one place per parse loop
  -- but it is called for every iteration of said loop, so it should be fast.
  -- GCC doesn't want to inline this by default.
  -- This usually a faster alternative to ReadTag() when cutoff is a manifest
  -- constant.  It does particularly well for cutoff >= 127.  The first part
  -- of the return value is the tag that was read, though it can also be 0 in
  -- the cases where ReadTag() would return 0.  If the second part is true
  -- then the tag is known to be in [0, cutoff].  If not, the tag either is
  -- above cutoff or is 0.  (There's intentional wiggle room when tag is 0,
  -- because that can arise in several ways, and for best performance we want
  -- to avoid an extra "is tag == 0?" check here.)
  -- Usually returns true if calling ReadVarint32() now would produce the given
  -- value.  Will always return false if ReadVarint32() would not return the
  -- given value.  If ExpectTag() returns true, it also advances past
  -- the varint.  For best performance, use a compile-time constant as the
  -- parameter.
  -- Always inline because this collapses to a small number of instructions
  -- when given a constant parameter, but GCC doesn't want to inline by default.
  -- Like above, except this reads from the specified buffer. The caller is
  -- responsible for ensuring that the buffer is large enough to read a varint
  -- of the expected size. For best performance, use a compile-time constant as
  -- the expected tag parameter.
  -- Returns a pointer beyond the expected tag if it was found, or NULL if it
  -- was not.
  -- Usually returns true if no more bytes can be read.  Always returns false
  -- if more bytes can be read.  If ExpectAtEnd() returns true, a subsequent
  -- call to LastTagWas() will act as if ReadTag() had been called and returned
  -- zero, and ConsumedEntireMessage() will return true.
  -- If the last call to ReadTag() or ReadTagWithCutoff() returned the given
  -- value, returns true.  Otherwise, returns false.
  -- ReadTagNoLastTag/ReadTagWithCutoffNoLastTag do not preserve the last
  -- returned value.
  -- This is needed because parsers for some types of embedded messages
  -- (with field type TYPE_GROUP) don't actually know that they've reached the
  -- end of a message until they see an ENDGROUP tag, which was actually part
  -- of the enclosing message.  The enclosing message would like to check that
  -- tag to make sure it had the right number, so it calls LastTagWas() on
  -- return from the embedded parser to check.
  -- When parsing message (but NOT a group), this method must be called
  -- immediately after MergeFromCodedStream() returns (if it returns true)
  -- to further verify that the message ended in a legitimate way.  For
  -- example, this verifies that parsing did not end on an end-group tag.
  -- It also checks for some cases where, due to optimizations,
  -- MergeFromCodedStream() can incorrectly return true.
  -- Limits ----------------------------------------------------------
  -- Limits are used when parsing length-delimited embedded messages.
  -- After the message's length is read, PushLimit() is used to prevent
  -- the CodedInputStream from reading beyond that length.  Once the
  -- embedded message has been parsed, PopLimit() is called to undo the
  -- limit.
  -- Opaque type used with PushLimit() and PopLimit().  Do not modify
  -- values of this type yourself.  The only reason that this isn't a
  -- struct with private internals is for efficiency.
  -- Places a limit on the number of bytes that the stream may read,
  -- starting from the current position.  Once the stream hits this limit,
  -- it will act like the end of the input has been reached until PopLimit()
  -- is called.
  -- As the names imply, the stream conceptually has a stack of limits.  The
  -- shortest limit on the stack is always enforced, even if it is not the
  -- top limit.
  -- The value returned by PushLimit() is opaque to the caller, and must
  -- be passed unchanged to the corresponding call to PopLimit().
  -- Pops the last limit pushed by PushLimit().  The input must be the value
  -- returned by that call to PushLimit().
  -- Returns the number of bytes left until the nearest limit on the
  -- stack is hit, or -1 if no limits are in place.
  -- Returns current position relative to the beginning of the input stream.
  -- Total Bytes Limit -----------------------------------------------
  -- To prevent malicious users from sending excessively large messages
  -- and causing integer overflows or memory exhaustion, CodedInputStream
  -- imposes a hard limit on the total number of bytes it will read.
  -- Sets the maximum number of bytes that this CodedInputStream will read
  -- before refusing to continue.  To prevent integer overflows in the
  -- protocol buffers implementation, as well as to prevent servers from
  -- allocating enormous amounts of memory to hold parsed messages, the
  -- maximum message length should be limited to the shortest length that
  -- will not harm usability.  The theoretical shortest message that could
  -- cause integer overflows is 512MB.  The default limit is 64MB.  Apps
  -- should set shorter limits if possible.  For backwards compatibility all
  -- negative values get squashed to -1, as other negative values might have
  -- special internal meanings.  An error will always be printed to stderr if
  -- the limit is reached.
  -- This is unrelated to PushLimit()/PopLimit().
  -- Hint:  If you are reading this because your program is printing a
  --   warning about dangerously large protocol messages, you may be
  --   confused about what to do next.  The best option is to change your
  --   design such that excessively large messages are not necessary.
  --   For example, try to design file formats to consist of many small
  --   messages rather than a single large one.  If this is infeasible,
  --   you will need to increase the limit.  Chances are, though, that
  --   your code never constructs a CodedInputStream on which the limit
  --   can be set.  You probably parse messages by calling things like
  --   Message::ParseFromString().  In this case, you will need to change
  --   your code to instead construct some sort of ZeroCopyInputStream
  --   (e.g. an ArrayInputStream), construct a CodedInputStream around
  --   that, then call Message::ParseFromCodedStream() instead.  Then
  --   you can adjust the limit.  Yes, it's more work, but you're doing
  --   something unusual.
  -- The Total Bytes Limit minus the Current Position, or -1 if there
  -- is no Total Bytes Limit.
  -- Recursion Limit -------------------------------------------------
  -- To prevent corrupt or malicious messages from causing stack overflows,
  -- we must keep track of the depth of recursion when parsing embedded
  -- messages and groups.  CodedInputStream keeps track of this because it
  -- is the only object that is passed down the stack during parsing.
  -- Sets the maximum recursion depth.  The default is 100.
  -- Increments the current recursion depth.  Returns true if the depth is
  -- under the limit, false if it has gone over.
  -- Decrements the recursion depth if possible.
  -- Decrements the recursion depth blindly.  This is faster than
  -- DecrementRecursionDepth().  It should be used only if all previous
  -- increments to recursion depth were successful.
  -- Shorthand for make_pair(PushLimit(byte_limit), --recursion_budget_).
  -- Using this can reduce code size and complexity in some cases.  The caller
  -- is expected to check that the second part of the result is non-negative (to
  -- bail out if the depth of recursion is too high) and, if all is well, to
  -- later pass the first part of the result to PopLimit() or similar.
  -- Shorthand for PushLimit(ReadVarint32(&length) ? length : 0).
  -- Helper that is equivalent to: {
  --  bool result = ConsumedEntireMessage();
  --  PopLimit(limit);
  --  UnsafeDecrementRecursionDepth();
  --  return result; }
  -- Using this can reduce code size and complexity in some cases.
  -- Do not use unless the current recursion depth is greater than zero.
  -- Helper that is equivalent to: {
  --  bool result = ConsumedEntireMessage();
  --  PopLimit(limit);
  --  return result; }
  -- Using this can reduce code size and complexity in some cases.
  -- Extension Registry ----------------------------------------------
  -- ADVANCED USAGE:  99.9% of people can ignore this section.
  -- By default, when parsing extensions, the parser looks for extension
  -- definitions in the pool which owns the outer message's Descriptor.
  -- However, you may call SetExtensionRegistry() to provide an alternative
  -- pool instead.  This makes it possible, for example, to parse a message
  -- using a generated class, but represent some extensions using
  -- DynamicMessage.
  -- Set the pool used to look up extensions.  Most users do not need to call
  -- this as the correct pool will be chosen automatically.
  -- WARNING:  It is very easy to misuse this.  Carefully read the requirements
  --   below.  Do not use this unless you are sure you need it.  Almost no one
  --   does.
  -- Let's say you are parsing a message into message object m, and you want
  -- to take advantage of SetExtensionRegistry().  You must follow these
  -- requirements:
  -- The given DescriptorPool must contain m->GetDescriptor().  It is not
  -- sufficient for it to simply contain a descriptor that has the same name
  -- and content -- it must be the *exact object*.  In other words:
  --   assert(pool->FindMessageTypeByName(m->GetDescriptor()->full_name()) ==
  --          m->GetDescriptor());
  -- There are two ways to satisfy this requirement:
  -- 1) Use m->GetDescriptor()->pool() as the pool.  This is generally useless
  --    because this is the pool that would be used anyway if you didn't call
  --    SetExtensionRegistry() at all.
  -- 2) Use a DescriptorPool which has m->GetDescriptor()->pool() as an
  --    "underlay".  Read the documentation for DescriptorPool for more
  --    information about underlays.
  -- You must also provide a MessageFactory.  This factory will be used to
  -- construct Message objects representing extensions.  The factory's
  -- GetPrototype() MUST return non-NULL for any Descriptor which can be found
  -- through the provided pool.
  -- If the provided factory might return instances of protocol-compiler-
  -- generated (i.e. compiled-in) types, or if the outer message object m is
  -- a generated type, then the given factory MUST have this property:  If
  -- GetPrototype() is given a Descriptor which resides in
  -- DescriptorPool::generated_pool(), the factory MUST return the same
  -- prototype which MessageFactory::generated_factory() would return.  That
  -- is, given a descriptor for a generated type, the factory must return an
  -- instance of the generated class (NOT DynamicMessage).  However, when
  -- given a descriptor for a type that is NOT in generated_pool, the factory
  -- is free to return any implementation.
  -- The reason for this requirement is that generated sub-objects may be
  -- accessed via the standard (non-reflection) extension accessor methods,
  -- and these methods will down-cast the object to the generated class type.
  -- If the object is not actually of that type, the results would be undefined.
  -- On the other hand, if an extension is not compiled in, then there is no
  -- way the code could end up accessing it via the standard accessors -- the
  -- only way to access the extension is via reflection.  When using reflection,
  -- DynamicMessage and generated messages are indistinguishable, so it's fine
  -- if these objects are represented using DynamicMessage.
  -- Using DynamicMessageFactory on which you have called
  -- SetDelegateToGeneratedFactory(true) should be sufficient to satisfy the
  -- above requirement.
  -- If either pool or factory is NULL, both must be NULL.
  -- Note that this feature is ignored when parsing "lite" messages as they do
  -- not have descriptors.
  -- Get the DescriptorPool set via SetExtensionRegistry(), or NULL if no pool
  -- has been provided.
  -- Get the MessageFactory set via SetExtensionRegistry(), or NULL if no
  -- factory has been provided.
   package Class_CodedInputStream is
      type CodedInputStream is limited record
         buffer_u : access google.protobuf.binding.google_protobuf_stubs_port_h.uint8;  -- ../../../../src/google/protobuf/io/coded_stream.h:535
         buffer_end_u : access google.protobuf.binding.google_protobuf_stubs_port_h.uint8;  -- ../../../../src/google/protobuf/io/coded_stream.h:536
         input_u : access google.Protobuf.Binding.zero_copy_stream_h.Class_ZeroCopyInputStream.ZeroCopyInputStream;  -- ../../../../src/google/protobuf/io/coded_stream.h:537
         total_bytes_read_u : aliased int;  -- ../../../../src/google/protobuf/io/coded_stream.h:538
         overflow_bytes_u : aliased int;  -- ../../../../src/google/protobuf/io/coded_stream.h:543
         last_tag_u : aliased google.protobuf.binding.google_protobuf_stubs_port_h.uint32;  -- ../../../../src/google/protobuf/io/coded_stream.h:546
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

      function New_CodedInputStream (buffer : access constant google.protobuf.binding.google_protobuf_stubs_port_h.uint8; size : int) return CodedInputStream;  -- ../../../../src/google/protobuf/io/coded_stream.h:1408
      pragma CPP_Constructor (New_CodedInputStream, "_ZN6google8protobuf2io16CodedInputStreamC1EPKhi");

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

      function ReadLittleEndian32 (this : access CodedInputStream; value : access google.protobuf.binding.google_protobuf_stubs_port_h.uint32) return Extensions.bool;  -- ../../../../src/google/protobuf/io/coded_stream.h:995
      pragma Import (CPP, ReadLittleEndian32, "_ZN6google8protobuf2io16CodedInputStream18ReadLittleEndian32EPj");

      function ReadLittleEndian64 (this : access CodedInputStream; value : access google.protobuf.binding.google_protobuf_stubs_port_h.uint64) return Extensions.bool;  -- ../../../../src/google/protobuf/io/coded_stream.h:1008
      pragma Import (CPP, ReadLittleEndian64, "_ZN6google8protobuf2io16CodedInputStream18ReadLittleEndian64EPm");

      function ReadVarint32 (this : access CodedInputStream; value : access google.protobuf.binding.google_protobuf_stubs_port_h.uint32) return Extensions.bool;  -- ../../../../src/google/protobuf/io/coded_stream.h:919
      pragma Import (CPP, ReadVarint32, "_ZN6google8protobuf2io16CodedInputStream12ReadVarint32EPj");

      function ReadVarint64 (this : access CodedInputStream; value : access google.protobuf.binding.google_protobuf_stubs_port_h.uint64) return Extensions.bool;  -- ../../../../src/google/protobuf/io/coded_stream.h:934
      pragma Import (CPP, ReadVarint64, "_ZN6google8protobuf2io16CodedInputStream12ReadVarint64EPm");

      function ReadVarintSizeAsInt (this : access CodedInputStream; value : access int) return Extensions.bool;  -- ../../../../src/google/protobuf/io/coded_stream.h:945
      pragma Import (CPP, ReadVarintSizeAsInt, "_ZN6google8protobuf2io16CodedInputStream19ReadVarintSizeAsIntEPi");

      function ReadTag (this : access CodedInputStream) return google.protobuf.binding.google_protobuf_stubs_port_h.uint32;  -- ../../../../src/google/protobuf/io/coded_stream.h:1021
      pragma Import (CPP, ReadTag, "_ZN6google8protobuf2io16CodedInputStream7ReadTagEv");

      function ReadTagNoLastTag (this : access CodedInputStream) return google.protobuf.binding.google_protobuf_stubs_port_h.uint32;  -- ../../../../src/google/protobuf/io/coded_stream.h:1025
      pragma Import (CPP, ReadTagNoLastTag, "_ZN6google8protobuf2io16CodedInputStream16ReadTagNoLastTagEv");

--        function ReadTagWithCutoff (this : access CodedInputStream; cutoff : google.protobuf.binding.google_protobuf_stubs_port_h.uint32) return google.protobuf.binding.cpp_6_2_1_bits_stl_pair_h.Class_pair.pair;  -- ../../../../src/google/protobuf/io/coded_stream.h:1049
--        pragma Import (CPP, ReadTagWithCutoff, "_ZN6google8protobuf2io16CodedInputStream17ReadTagWithCutoffEj");

--        function ReadTagWithCutoffNoLastTag (this : access CodedInputStream; cutoff : google.protobuf.binding.google_protobuf_stubs_port_h.uint32) return google.protobuf.binding.cpp_6_2_1_bits_stl_pair_h.Class_pair.pair;  -- ../../../../src/google/protobuf/io/coded_stream.h:1054
--        pragma Import (CPP, ReadTagWithCutoffNoLastTag, "_ZN6google8protobuf2io16CodedInputStream26ReadTagWithCutoffNoLastTagEj");

      function ExpectTag (this : access CodedInputStream; expected : google.protobuf.binding.google_protobuf_stubs_port_h.uint32) return Extensions.bool;  -- ../../../../src/google/protobuf/io/coded_stream.h:1119
      pragma Import (CPP, ExpectTag, "_ZN6google8protobuf2io16CodedInputStream9ExpectTagEj");

      function ExpectAtEnd (this : access CodedInputStream) return Extensions.bool;  -- ../../../../src/google/protobuf/io/coded_stream.h:1163
      pragma Import (CPP, ExpectAtEnd, "_ZN6google8protobuf2io16CodedInputStream11ExpectAtEndEv");

      function LastTagWas (this : access CodedInputStream; expected : google.protobuf.binding.google_protobuf_stubs_port_h.uint32) return Extensions.bool;  -- ../../../../src/google/protobuf/io/coded_stream.h:1111
      pragma Import (CPP, LastTagWas, "_ZN6google8protobuf2io16CodedInputStream10LastTagWasEj");

      function ConsumedEntireMessage (this : access CodedInputStream) return Extensions.bool;  -- ../../../../src/google/protobuf/io/coded_stream.h:1115
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

      function ReadVarint32Fallback (this : access CodedInputStream; first_byte_or_zero : google.protobuf.binding.google_protobuf_stubs_port_h.uint32) return google.protobuf.binding.google_protobuf_stubs_port_h.int64;  -- ../../../../src/google/protobuf/io/coded_stream.h:615
      pragma Import (CPP, ReadVarint32Fallback, "_ZN6google8protobuf2io16CodedInputStream20ReadVarint32FallbackEj");

      function ReadVarintSizeAsIntFallback (this : access CodedInputStream) return int;  -- ../../../../src/google/protobuf/io/coded_stream.h:616
      pragma Import (CPP, ReadVarintSizeAsIntFallback, "_ZN6google8protobuf2io16CodedInputStream27ReadVarintSizeAsIntFallbackEv");

--        function ReadVarint64Fallback (this : access CodedInputStream) return google.protobuf.binding.cpp_6_2_1_bits_stl_pair_h.Class_pair.pair;  -- ../../../../src/google/protobuf/io/coded_stream.h:617
--        pragma Import (CPP, ReadVarint64Fallback, "_ZN6google8protobuf2io16CodedInputStream20ReadVarint64FallbackEv");

      function ReadVarint32Slow (this : access CodedInputStream; value : access google.protobuf.binding.google_protobuf_stubs_port_h.uint32) return Extensions.bool;  -- ../../../../src/google/protobuf/io/coded_stream.h:618
      pragma Import (CPP, ReadVarint32Slow, "_ZN6google8protobuf2io16CodedInputStream16ReadVarint32SlowEPj");

      function ReadVarint64Slow (this : access CodedInputStream; value : access google.protobuf.binding.google_protobuf_stubs_port_h.uint64) return Extensions.bool;  -- ../../../../src/google/protobuf/io/coded_stream.h:619
      pragma Import (CPP, ReadVarint64Slow, "_ZN6google8protobuf2io16CodedInputStream16ReadVarint64SlowEPm");

      function ReadVarintSizeAsIntSlow (this : access CodedInputStream) return int;  -- ../../../../src/google/protobuf/io/coded_stream.h:620
      pragma Import (CPP, ReadVarintSizeAsIntSlow, "_ZN6google8protobuf2io16CodedInputStream23ReadVarintSizeAsIntSlowEv");

      function ReadLittleEndian32Fallback (this : access CodedInputStream; value : access google.protobuf.binding.google_protobuf_stubs_port_h.uint32) return Extensions.bool;  -- ../../../../src/google/protobuf/io/coded_stream.h:621
      pragma Import (CPP, ReadLittleEndian32Fallback, "_ZN6google8protobuf2io16CodedInputStream26ReadLittleEndian32FallbackEPj");

      function ReadLittleEndian64Fallback (this : access CodedInputStream; value : access google.protobuf.binding.google_protobuf_stubs_port_h.uint64) return Extensions.bool;  -- ../../../../src/google/protobuf/io/coded_stream.h:622
      pragma Import (CPP, ReadLittleEndian64Fallback, "_ZN6google8protobuf2io16CodedInputStream26ReadLittleEndian64FallbackEPm");

      function ReadTagFallback (this : access CodedInputStream; first_byte_or_zero : google.protobuf.binding.google_protobuf_stubs_port_h.uint32) return google.protobuf.binding.google_protobuf_stubs_port_h.uint32;  -- ../../../../src/google/protobuf/io/coded_stream.h:633
      pragma Import (CPP, ReadTagFallback, "_ZN6google8protobuf2io16CodedInputStream15ReadTagFallbackEj");

      function ReadTagSlow (this : access CodedInputStream) return google.protobuf.binding.google_protobuf_stubs_port_h.uint32;  -- ../../../../src/google/protobuf/io/coded_stream.h:634
      pragma Import (CPP, ReadTagSlow, "_ZN6google8protobuf2io16CodedInputStream11ReadTagSlowEv");

      function ReadStringFallback
        (this : access CodedInputStream;
         buffer : Interfaces_CPP.Strings.CPP_String_External;
         size : int) return Extensions.bool;  -- ../../../../src/google/protobuf/io/coded_stream.h:635
      pragma Import (CPP, ReadStringFallback, "_ZN6google8protobuf2io16CodedInputStream18ReadStringFallbackEPNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEi");

      function BufferSize (this : access constant CodedInputStream) return int;  -- ../../../../src/google/protobuf/io/coded_stream.h:1383
      pragma Import (CPP, BufferSize, "_ZNK6google8protobuf2io16CodedInputStream10BufferSizeEv");

      package Static is
         function ReadLittleEndian32FromArray (buffer : access google.protobuf.binding.google_protobuf_stubs_port_h.uint8; value : access google.protobuf.binding.google_protobuf_stubs_port_h.uint32) return access google.protobuf.binding.google_protobuf_stubs_port_h.uint8;  -- ../../../../src/google/protobuf/io/coded_stream.h:959
         pragma Import (CPP, ReadLittleEndian32FromArray, "_ZN6google8protobuf2io16CodedInputStream27ReadLittleEndian32FromArrayEPKhPj");

         function ReadLittleEndian64FromArray (buffer : access google.protobuf.binding.google_protobuf_stubs_port_h.uint8; value : access google.protobuf.binding.google_protobuf_stubs_port_h.uint64) return access google.protobuf.binding.google_protobuf_stubs_port_h.uint8;  -- ../../../../src/google/protobuf/io/coded_stream.h:974
         pragma Import (CPP, ReadLittleEndian64FromArray, "_ZN6google8protobuf2io16CodedInputStream27ReadLittleEndian64FromArrayEPKhPm");

         function ExpectTagFromArray (buffer : access google.protobuf.binding.google_protobuf_stubs_port_h.uint8; expected : google.protobuf.binding.google_protobuf_stubs_port_h.uint32) return access google.protobuf.binding.google_protobuf_stubs_port_h.uint8;  -- ../../../../src/google/protobuf/io/coded_stream.h:1142
         pragma Import (CPP, ExpectTagFromArray, "_ZN6google8protobuf2io16CodedInputStream18ExpectTagFromArrayEPKhj");
      end;

      function ReadLittleEndian32FromArray (buffer : access google.protobuf.binding.google_protobuf_stubs_port_h.uint8; value : access google.protobuf.binding.google_protobuf_stubs_port_h.uint32) return access google.protobuf.binding.google_protobuf_stubs_port_h.uint8 renames Static.ReadLittleEndian32FromArray;

      function ReadLittleEndian64FromArray (buffer : access google.protobuf.binding.google_protobuf_stubs_port_h.uint8; value : access google.protobuf.binding.google_protobuf_stubs_port_h.uint64) return access google.protobuf.binding.google_protobuf_stubs_port_h.uint8 renames Static.ReadLittleEndian64FromArray;

      function ExpectTagFromArray (buffer : access google.protobuf.binding.google_protobuf_stubs_port_h.uint8; expected : google.protobuf.binding.google_protobuf_stubs_port_h.uint32) return access google.protobuf.binding.google_protobuf_stubs_port_h.uint8 renames Static.ExpectTagFromArray;

      kDefaultTotalBytesLimit : aliased int;  -- ../../../../src/google/protobuf/io/coded_stream.h:640
      pragma Import (CPP, kDefaultTotalBytesLimit, "_ZN6google8protobuf2io16CodedInputStream23kDefaultTotalBytesLimitE");

      default_recursion_limit_u : aliased int;  -- ../../../../src/google/protobuf/io/coded_stream.h:642
      pragma Import (CPP, default_recursion_limit_u, "_ZN6google8protobuf2io16CodedInputStream24default_recursion_limit_E");
   end;
   use Class_CodedInputStream;
  -- pointer to the end of the buffer.
  -- total bytes read from input_, including
  -- the current buffer
  -- If total_bytes_read_ surpasses INT_MAX, we record the extra bytes here
  -- so that we can BackUp() on destruction.
  -- LastTagWas() stuff.
  -- result of last ReadTag() or ReadTagWithCutoff().
  -- This is set true by ReadTag{Fallback/Slow}() if it is called when exactly
  -- at EOF, or by ExpectAtEnd() when it returns true.  This happens when we
  -- reach the end of a message and attempt to read another tag.
  -- See EnableAliasing().
  -- Limits
  -- if position = -1, no limit is applied
  -- For simplicity, if the current buffer crosses a limit (either a normal
  -- limit created by PushLimit() or the total bytes limit), buffer_size_
  -- only tracks the number of bytes before that limit.  This field
  -- contains the number of bytes after it.  Note that this implies that if
  -- buffer_size_ == 0 and buffer_size_after_limit_ > 0, we know we've
  -- hit a limit.  However, if both are zero, it doesn't necessarily mean
  -- we aren't at a limit -- the buffer may have ended exactly at the limit.
  -- Maximum number of bytes to read, period.  This is unrelated to
  -- current_limit_.  Set using SetTotalBytesLimit().
  -- Current recursion budget, controlled by IncrementRecursionDepth() and
  -- similar.  Starts at recursion_limit_ and goes down: if this reaches
  -- -1 we are over budget.
  -- Recursion depth limit, set by SetRecursionLimit().
  -- See SetExtensionRegistry().
  -- Private member functions.
  -- Advance the buffer by a given number of bytes.
  -- Back up input_ to the current buffer position.
  -- Recomputes the value of buffer_size_after_limit_.  Must be called after
  -- current_limit_ or total_bytes_limit_ changes.
  -- Writes an error message saying that we hit total_bytes_limit_.
  -- Called when the buffer runs out to request more data.  Implies an
  -- Advance(BufferSize()).
  -- When parsing varints, we optimize for the common case of small values, and
  -- then optimize for the case when the varint fits within the current buffer
  -- piece. The Fallback method is used when we can't use the one-byte
  -- optimization. The Slow method is yet another fallback when the buffer is
  -- not large enough. Making the slow path out-of-line speeds up the common
  -- case by 10-15%. The slow path is fairly uncommon: it only triggers when a
  -- message crosses multiple buffers.  Note: ReadVarint32Fallback() and
  -- ReadVarint64Fallback() are called frequently and generally not inlined, so
  -- they have been optimized to avoid "out" parameters.  The former returns -1
  -- if it fails and the uint32 it read otherwise.  The latter has a bool
  -- indicating success or failure as part of its return type.
  -- Fallback/slow methods for reading tags. These do not update last_tag_,
  -- but will set legitimate_message_end_ if we are at the end of the input
  -- stream.
  -- Return the size of the buffer.
  -- 100 by default.
  -- Class which encodes and writes binary data which is composed of varint-
  -- encoded integers and fixed-width pieces.  Wraps a ZeroCopyOutputStream.
  -- Most users will not need to deal with CodedOutputStream.
  -- Most methods of CodedOutputStream which return a bool return false if an
  -- underlying I/O error occurs.  Once such a failure occurs, the
  -- CodedOutputStream is broken and is no longer useful. The Write* methods do
  -- not return the stream status, but will invalidate the stream if an error
  -- occurs. The client can probe HadError() to determine the status.
  -- Note that every method of CodedOutputStream which writes some data has
  -- a corresponding static "ToArray" version. These versions write directly
  -- to the provided buffer, returning a pointer past the last written byte.
  -- They require that the buffer has sufficient capacity for the encoded data.
  -- This allows an optimization where we check if an output stream has enough
  -- space for an entire message before we start writing and, if there is, we
  -- call only the ToArray methods to avoid doing bound checks for each
  -- individual value.
  -- i.e., in the example above:
  --   CodedOutputStream coded_output = new CodedOutputStream(raw_output);
  --   int magic_number = 1234;
  --   char text[] = "Hello world!";
  --   int coded_size = sizeof(magic_number) +
  --                    CodedOutputStream::VarintSize32(strlen(text)) +
  --                    strlen(text);
  --   uint8* buffer =
  --       coded_output->GetDirectBufferForNBytesAndAdvance(coded_size);
  --   if (buffer != NULL) {
  --     // The output stream has enough space in the buffer: write directly to
  --     // the array.
  --     buffer = CodedOutputStream::WriteLittleEndian32ToArray(magic_number,
  --                                                            buffer);
  --     buffer = CodedOutputStream::WriteVarint32ToArray(strlen(text), buffer);
  --     buffer = CodedOutputStream::WriteRawToArray(text, strlen(text), buffer);
  --   } else {
  --     // Make bound-checked writes, which will ask the underlying stream for
  --     // more space as needed.
  --     coded_output->WriteLittleEndian32(magic_number);
  --     coded_output->WriteVarint32(strlen(text));
  --     coded_output->WriteRaw(text, strlen(text));
  --   }
  --   delete coded_output;
  -- Create an CodedOutputStream that writes to the given ZeroCopyOutputStream.
  -- Destroy the CodedOutputStream and position the underlying
  -- ZeroCopyOutputStream immediately after the last byte written.
  -- Trims any unused space in the underlying buffer so that its size matches
  -- the number of bytes written by this stream. The underlying buffer will
  -- automatically be trimmed when this stream is destroyed; this call is only
  -- necessary if the underlying buffer is accessed *before* the stream is
  -- destroyed.
  -- Skips a number of bytes, leaving the bytes unmodified in the underlying
  -- buffer.  Returns false if an underlying write error occurs.  This is
  -- mainly useful with GetDirectBufferPointer().
  -- Sets *data to point directly at the unwritten part of the
  -- CodedOutputStream's underlying buffer, and *size to the size of that
  -- buffer, but does not advance the stream's current position.  This will
  -- always either produce a non-empty buffer or return false.  If the caller
  -- writes any data to this buffer, it should then call Skip() to skip over
  -- the consumed bytes.  This may be useful for implementing external fast
  -- serialization routines for types of data not covered by the
  -- CodedOutputStream interface.
  -- If there are at least "size" bytes available in the current buffer,
  -- returns a pointer directly into the buffer and advances over these bytes.
  -- The caller may then write directly into this buffer (e.g. using the
  -- *ToArray static methods) rather than go through CodedOutputStream.  If
  -- there are not enough bytes available, returns NULL.  The return pointer is
  -- invalidated as soon as any other non-const method of CodedOutputStream
  -- is called.
  -- Write raw bytes, copying them from the given buffer.
  -- Like WriteRaw()  but will try to write aliased data if aliasing is
  -- turned on.
  -- Like WriteRaw()  but writing directly to the target array.
  -- This is _not_ inlined, as the compiler often optimizes memcpy into inline
  -- copy loops. Since this gets called by every field with string or bytes
  -- type, inlining may lead to a significant amount of code bloat, with only a
  -- minor performance gain.
  -- Equivalent to WriteRaw(str.data(), str.size()).
  -- Like WriteString()  but writing directly to the target array.
  -- Write the varint-encoded size of str followed by str.
  -- Instructs the CodedOutputStream to allow the underlying
  -- ZeroCopyOutputStream to hold pointers to the original structure instead of
  -- copying, if it supports it (i.e. output->AllowsAliasing() is true).  If the
  -- underlying stream does not support aliasing, then enabling it has no
  -- affect.  For now, this only affects the behavior of
  -- WriteRawMaybeAliased().
  -- NOTE: It is caller's responsibility to ensure that the chunk of memory
  -- remains live until all of the data has been consumed from the stream.
  -- Write a 32-bit little-endian integer.
  -- Like WriteLittleEndian32()  but writing directly to the target array.
  -- Write a 64-bit little-endian integer.
  -- Like WriteLittleEndian64()  but writing directly to the target array.
  -- Write an unsigned integer with Varint encoding.  Writing a 32-bit value
  -- is equivalent to casting it to uint64 and writing it as a 64-bit value,
  -- but may be more efficient.
  -- Like WriteVarint32()  but writing directly to the target array.
  -- Write an unsigned integer with Varint encoding.
  -- Like WriteVarint64()  but writing directly to the target array.
  -- Equivalent to WriteVarint32() except when the value is negative,
  -- in which case it must be sign-extended to a full 10 bytes.
  -- Like WriteVarint32SignExtended()  but writing directly to the target array.
  -- This is identical to WriteVarint32(), but optimized for writing tags.
  -- In particular, if the input is a compile-time constant, this method
  -- compiles down to a couple instructions.
  -- Always inline because otherwise the aformentioned optimization can't work,
  -- but GCC by default doesn't want to inline this.
  -- Like WriteTag()  but writing directly to the target array.
  -- Returns the number of bytes needed to encode the given value as a varint.
  -- Returns the number of bytes needed to encode the given value as a varint.
  -- If negative, 10 bytes.  Otheriwse, same as VarintSize32().
  -- Compile-time equivalent of VarintSize32().
   package Class_CodedOutputStream is
      type CodedOutputStream is limited record
         output_u : access google.Protobuf.binding.zero_copy_stream_h.Class_ZeroCopyOutputStream.ZeroCopyOutputStream;  -- ../../../../src/google/protobuf/io/coded_stream.h:874
         buffer_u : access google.protobuf.binding.google_protobuf_stubs_port_h.uint8;  -- ../../../../src/google/protobuf/io/coded_stream.h:875
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

      function GetDirectBufferForNBytesAndAdvance (this : access CodedOutputStream; size : int) return access google.protobuf.binding.google_protobuf_stubs_port_h.uint8;  -- ../../../../src/google/protobuf/io/coded_stream.h:1182
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

      procedure WriteLittleEndian32 (this : access CodedOutputStream; value : google.protobuf.binding.google_protobuf_stubs_port_h.uint32);  -- ../../../../src/google/protobuf/io/coded_stream.h:764
      pragma Import (CPP, WriteLittleEndian32, "_ZN6google8protobuf2io17CodedOutputStream19WriteLittleEndian32Ej");

      procedure WriteLittleEndian64 (this : access CodedOutputStream; value : google.protobuf.binding.google_protobuf_stubs_port_h.uint64);  -- ../../../../src/google/protobuf/io/coded_stream.h:768
      pragma Import (CPP, WriteLittleEndian64, "_ZN6google8protobuf2io17CodedOutputStream19WriteLittleEndian64Em");

      procedure WriteVarint32 (this : access CodedOutputStream; value : google.protobuf.binding.google_protobuf_stubs_port_h.uint32);  -- ../../../../src/google/protobuf/io/coded_stream.h:1256
      pragma Import (CPP, WriteVarint32, "_ZN6google8protobuf2io17CodedOutputStream13WriteVarint32Ej");

      procedure WriteVarint64 (this : access CodedOutputStream; value : google.protobuf.binding.google_protobuf_stubs_port_h.uint64);  -- ../../../../src/google/protobuf/io/coded_stream.h:1269
      pragma Import (CPP, WriteVarint64, "_ZN6google8protobuf2io17CodedOutputStream13WriteVarint64Em");

      procedure WriteVarint32SignExtended (this : access CodedOutputStream; value : google.protobuf.binding.google_protobuf_stubs_port_h.int32);  -- ../../../../src/google/protobuf/io/coded_stream.h:1214
      pragma Import (CPP, WriteVarint32SignExtended, "_ZN6google8protobuf2io17CodedOutputStream25WriteVarint32SignExtendedEi");

      procedure WriteTag (this : access CodedOutputStream; value : google.protobuf.binding.google_protobuf_stubs_port_h.uint32);  -- ../../../../src/google/protobuf/io/coded_stream.h:1282
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

      procedure WriteVarint32SlowPath (this : access CodedOutputStream; value : google.protobuf.binding.google_protobuf_stubs_port_h.uint32);  -- ../../../../src/google/protobuf/io/coded_stream.h:899
      pragma Import (CPP, WriteVarint32SlowPath, "_ZN6google8protobuf2io17CodedOutputStream21WriteVarint32SlowPathEj");

      procedure WriteVarint64SlowPath (this : access CodedOutputStream; value : google.protobuf.binding.google_protobuf_stubs_port_h.uint64);  -- ../../../../src/google/protobuf/io/coded_stream.h:900
      pragma Import (CPP, WriteVarint64SlowPath, "_ZN6google8protobuf2io17CodedOutputStream21WriteVarint64SlowPathEm");

      package Static is
         function WriteRawToArray
           (buffer : System.Address;
            size : int;
            target : access google.protobuf.binding.google_protobuf_stubs_port_h.uint8) return access google.protobuf.binding.google_protobuf_stubs_port_h.uint8;  -- ../../../../src/google/protobuf/io/coded_stream.h:742
         pragma Import (CPP, WriteRawToArray, "_ZN6google8protobuf2io17CodedOutputStream15WriteRawToArrayEPKviPh");

         function WriteStringToArray (str : Interfaces_CPP.Strings.CPP_String_External; target : access google.protobuf.binding.google_protobuf_stubs_port_h.uint8) return access google.protobuf.binding.google_protobuf_stubs_port_h.uint8;  -- ../../../../src/google/protobuf/io/coded_stream.h:1332
         pragma Import (CPP, WriteStringToArray, "_ZN6google8protobuf2io17CodedOutputStream18WriteStringToArrayERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEPh");

         function WriteStringWithSizeToArray (str : Interfaces_CPP.Strings.CPP_String_External; target : access google.protobuf.binding.google_protobuf_stubs_port_h.uint8) return access google.protobuf.binding.google_protobuf_stubs_port_h.uint8;  -- ../../../../src/google/protobuf/io/coded_stream.h:749
         pragma Import (CPP, WriteStringWithSizeToArray, "_ZN6google8protobuf2io17CodedOutputStream26WriteStringWithSizeToArrayERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEEPh");

         function WriteLittleEndian32ToArray (value : google.protobuf.binding.google_protobuf_stubs_port_h.uint32; target : access google.protobuf.binding.google_protobuf_stubs_port_h.uint8) return access google.protobuf.binding.google_protobuf_stubs_port_h.uint8;  -- ../../../../src/google/protobuf/io/coded_stream.h:1223
         pragma Import (CPP, WriteLittleEndian32ToArray, "_ZN6google8protobuf2io17CodedOutputStream26WriteLittleEndian32ToArrayEjPh");

         function WriteLittleEndian64ToArray (value : google.protobuf.binding.google_protobuf_stubs_port_h.uint64; target : access google.protobuf.binding.google_protobuf_stubs_port_h.uint8) return access google.protobuf.binding.google_protobuf_stubs_port_h.uint8;  -- ../../../../src/google/protobuf/io/coded_stream.h:1236
         pragma Import (CPP, WriteLittleEndian64ToArray, "_ZN6google8protobuf2io17CodedOutputStream26WriteLittleEndian64ToArrayEmPh");

         function WriteVarint32ToArray (value : google.protobuf.binding.google_protobuf_stubs_port_h.uint32; target : access google.protobuf.binding.google_protobuf_stubs_port_h.uint8) return access google.protobuf.binding.google_protobuf_stubs_port_h.uint8;  -- ../../../../src/google/protobuf/io/coded_stream.h:1192
         pragma Import (CPP, WriteVarint32ToArray, "_ZN6google8protobuf2io17CodedOutputStream20WriteVarint32ToArrayEjPh");

         function WriteVarint64ToArray (value : google.protobuf.binding.google_protobuf_stubs_port_h.uint64; target : access google.protobuf.binding.google_protobuf_stubs_port_h.uint8) return access google.protobuf.binding.google_protobuf_stubs_port_h.uint8;  -- ../../../../src/google/protobuf/io/coded_stream.h:1203
         pragma Import (CPP, WriteVarint64ToArray, "_ZN6google8protobuf2io17CodedOutputStream20WriteVarint64ToArrayEmPh");

         function WriteVarint32SignExtendedToArray (value : google.protobuf.binding.google_protobuf_stubs_port_h.int32; target : access google.protobuf.binding.google_protobuf_stubs_port_h.uint8) return access google.protobuf.binding.google_protobuf_stubs_port_h.uint8;  -- ../../../../src/google/protobuf/io/coded_stream.h:1218
         pragma Import (CPP, WriteVarint32SignExtendedToArray, "_ZN6google8protobuf2io17CodedOutputStream32WriteVarint32SignExtendedToArrayEiPh");

         function WriteTagToArray (value : google.protobuf.binding.google_protobuf_stubs_port_h.uint32; target : access google.protobuf.binding.google_protobuf_stubs_port_h.uint8) return access google.protobuf.binding.google_protobuf_stubs_port_h.uint8;  -- ../../../../src/google/protobuf/io/coded_stream.h:1286
         pragma Import (CPP, WriteTagToArray, "_ZN6google8protobuf2io17CodedOutputStream15WriteTagToArrayEjPh");

         function VarintSize32 (value : google.protobuf.binding.google_protobuf_stubs_port_h.uint32) return google.protobuf.binding.stddef_h.size_t;  -- ../../../../src/google/protobuf/io/coded_stream.h:1291
         pragma Import (CPP, VarintSize32, "_ZN6google8protobuf2io17CodedOutputStream12VarintSize32Ej");

         function VarintSize64 (value : google.protobuf.binding.google_protobuf_stubs_port_h.uint64) return google.protobuf.binding.stddef_h.size_t;  -- ../../../../src/google/protobuf/io/coded_stream.h:1301
         pragma Import (CPP, VarintSize64, "_ZN6google8protobuf2io17CodedOutputStream12VarintSize64Em");

         function VarintSize32SignExtended (value : google.protobuf.binding.google_protobuf_stubs_port_h.int32) return google.protobuf.binding.stddef_h.size_t;  -- ../../../../src/google/protobuf/io/coded_stream.h:1311
         pragma Import (CPP, VarintSize32SignExtended, "_ZN6google8protobuf2io17CodedOutputStream24VarintSize32SignExtendedEi");

         function IsDefaultSerializationDeterministic return Extensions.bool;  -- ../../../../src/google/protobuf/io/coded_stream.h:867
         pragma Import (CPP, IsDefaultSerializationDeterministic, "_ZN6google8protobuf2io17CodedOutputStream35IsDefaultSerializationDeterministicEv");

         procedure SetDefaultSerializationDeterministic;  -- ../../../../src/google/protobuf/io/coded_stream.h:910
         pragma Import (CPP, SetDefaultSerializationDeterministic, "_ZN6google8protobuf2io17CodedOutputStream36SetDefaultSerializationDeterministicEv");
      end;

      function WriteRawToArray
        (buffer : System.Address;
         size : int;
         target : access google.protobuf.binding.google_protobuf_stubs_port_h.uint8) return access google.protobuf.binding.google_protobuf_stubs_port_h.uint8 renames Static.WriteRawToArray;

      function WriteStringToArray (str : Interfaces_CPP.Strings.CPP_String_External; target : access google.protobuf.binding.google_protobuf_stubs_port_h.uint8) return access google.protobuf.binding.google_protobuf_stubs_port_h.uint8 renames Static.WriteStringToArray;

      function WriteStringWithSizeToArray (str : Interfaces_CPP.Strings.CPP_String_External; target : access google.protobuf.binding.google_protobuf_stubs_port_h.uint8) return access google.protobuf.binding.google_protobuf_stubs_port_h.uint8 renames Static.WriteStringWithSizeToArray;

      function WriteLittleEndian32ToArray (value : google.protobuf.binding.google_protobuf_stubs_port_h.uint32; target : access google.protobuf.binding.google_protobuf_stubs_port_h.uint8) return access google.protobuf.binding.google_protobuf_stubs_port_h.uint8 renames Static.WriteLittleEndian32ToArray;

      function WriteLittleEndian64ToArray (value : google.protobuf.binding.google_protobuf_stubs_port_h.uint64; target : access google.protobuf.binding.google_protobuf_stubs_port_h.uint8) return access google.protobuf.binding.google_protobuf_stubs_port_h.uint8 renames Static.WriteLittleEndian64ToArray;

      function WriteVarint32ToArray (value : google.protobuf.binding.google_protobuf_stubs_port_h.uint32; target : access google.protobuf.binding.google_protobuf_stubs_port_h.uint8) return access google.protobuf.binding.google_protobuf_stubs_port_h.uint8 renames Static.WriteVarint32ToArray;

      function WriteVarint64ToArray (value : google.protobuf.binding.google_protobuf_stubs_port_h.uint64; target : access google.protobuf.binding.google_protobuf_stubs_port_h.uint8) return access google.protobuf.binding.google_protobuf_stubs_port_h.uint8 renames Static.WriteVarint64ToArray;

      function WriteVarint32SignExtendedToArray (value : google.protobuf.binding.google_protobuf_stubs_port_h.int32; target : access google.protobuf.binding.google_protobuf_stubs_port_h.uint8) return access google.protobuf.binding.google_protobuf_stubs_port_h.uint8 renames Static.WriteVarint32SignExtendedToArray;

      function WriteTagToArray (value : google.protobuf.binding.google_protobuf_stubs_port_h.uint32; target : access google.protobuf.binding.google_protobuf_stubs_port_h.uint8) return access google.protobuf.binding.google_protobuf_stubs_port_h.uint8 renames Static.WriteTagToArray;

      function VarintSize32 (value : google.protobuf.binding.google_protobuf_stubs_port_h.uint32) return google.protobuf.binding.stddef_h.size_t renames Static.VarintSize32;

      function VarintSize64 (value : google.protobuf.binding.google_protobuf_stubs_port_h.uint64) return google.protobuf.binding.stddef_h.size_t renames Static.VarintSize64;

      function VarintSize32SignExtended (value : google.protobuf.binding.google_protobuf_stubs_port_h.int32) return google.protobuf.binding.stddef_h.size_t renames Static.VarintSize32SignExtended;

      function IsDefaultSerializationDeterministic return Extensions.bool renames Static.IsDefaultSerializationDeterministic;

      procedure SetDefaultSerializationDeterministic renames Static.SetDefaultSerializationDeterministic;

      default_serialization_deterministic_u : aliased google.protobuf.binding.google_protobuf_stubs_atomicops_h.AtomicWord;  -- ../../../../src/google/protobuf/io/coded_stream.h:884
      pragma Import (CPP, default_serialization_deterministic_u, "_ZN6google8protobuf2io17CodedOutputStream36default_serialization_deterministic_E");
   end;
   use Class_CodedOutputStream;
  -- Returns the total number of bytes written since this object was created.
  -- Returns true if there was an underlying I/O error since this object was
  -- created.
  -- Deterministic serialization, if requested, guarantees that for a given
  -- binary, equal messages will always be serialized to the same bytes. This
  -- implies:
  --   . repeated serialization of a message will return the same bytes
  --   . different processes of the same binary (which may be executing on
  --     different machines) will serialize equal messages to the same bytes.
  -- Note the deterministic serialization is NOT canonical across languages; it
  -- is also unstable across different builds with schema changes due to unknown
  -- fields. Users who need canonical serialization, e.g., persistent storage in
  -- a canonical form, fingerprinting, etc., should define their own
  -- canonicalization specification and implement the serializer using
  -- reflection APIs rather than relying on this API.
  -- If determinisitc serialization is requested, the serializer will
  -- sort map entries by keys in lexicographical order or numerical order.
  -- (This is an implementation detail and may subject to change.)
  -- There are two ways to determine whether serialization should be
  -- deterministic for this CodedOutputStream.  If SetSerializationDeterministic
  -- has not yet been called, then the default comes from the global default,
  -- which is false, until SetDefaultSerializationDeterministic has been called.
  -- Otherwise, SetSerializationDeterministic has been called, and the last
  -- value passed to it is all that matters.
  -- See above.  Also, note that users of this CodedOutputStream may need to
  -- call IsSerializationDeterministic() to serialize in the intended way.  This
  -- CodedOutputStream cannot enforce a desire for deterministic serialization
  -- by itself.
  -- Sum of sizes of all buffers seen so far.
  -- Whether an error occurred during output.
  -- See EnableAliasing().
  -- See SetSerializationDeterministic() regarding these three fields.
  -- Conceptually, default_serialization_deterministic_ is an atomic bool.
  -- Advance the buffer by a given number of bytes.
  -- Called when the buffer runs out to request more data.  Implies an
  -- Advance(buffer_size_).
  -- Like WriteRaw() but may avoid copying if the underlying
  -- ZeroCopyOutputStream supports it.
  -- If this write might cross the end of the buffer, we compose the bytes first
  -- then use WriteRaw().
  -- See above.  Other projects may use "friend" to allow them to call this.
  -- After SetDefaultSerializationDeterministic() completes, all protocol
  -- buffer serializations will be deterministic by default.  Thread safe.
  -- However, the meaning of "after" is subtle here: to be safe, each thread
  -- that wants deterministic serialization by default needs to call
  -- SetDefaultSerializationDeterministic() or ensure on its own that another
  -- thread has done so.
   procedure MapTestForceDeterministic;  -- ../../../../src/google/protobuf/io/coded_stream.h:909
   pragma Import (CPP, MapTestForceDeterministic, "_ZN6google8protobuf8internal25MapTestForceDeterministicEv");

  -- inline methods ====================================================
  -- The vast majority of varints are only one byte.  These inline
  -- methods optimize for that case.
  -- static
  -- static
  -- In performance-sensitive code we can expect cutoff to be a compile-time
  -- constant, and things like "cutoff >= kMax1ByteVarint" to be evaluated at
  -- compile time.
  -- Hot case: buffer_ non_empty, buffer_[0] in [1, 128).
  -- TODO(gpike): Is it worth rearranging this? E.g., if the number of fields
  -- is large enough then is it better to check for the two-byte case first?
  -- Other hot case: cutoff >= 0x80, buffer_ has at least two bytes available,
  -- and tag is two bytes.  The latter is tested by bitwise-and-not of the
  -- first byte and the second byte.
  -- It might make sense to test for tag == 0 now, but it is so rare that
  -- that we don't bother.  A varint-encoded 0 should be one byte unless
  -- the encoder lost its mind.  The second part of the return value of
  -- this function is allowed to be either true or false if the tag is 0,
  -- so we don't have to check for tag == 0.  We may need to check whether
  -- it exceeds cutoff.
  -- Slow path
  -- Don't bother optimizing for larger values.
  -- If we are at a limit we know no more bytes can be read.  Otherwise, it's
  -- hard to say without calling Refresh(), and we'd rather not do that.
  -- Pretend we called ReadTag()...
  -- ... and it hit EOF.
  -- Fast path:  We have enough bytes left in the buffer to guarantee that
  -- this write won't cross the end, so we can skip the checks.
  -- Fast path:  We have enough bytes left in the buffer to guarantee that
  -- this write won't cross the end, so we can skip the checks.
  -- This computes value == 0 ? 1 : floor(log2(value)) / 7 + 1
  -- Use an explicit multiplication to implement the divide of
  -- a number in the 1..31 range.
  -- Explicit OR 0x1 to avoid calling Bits::Log2FloorNonZero(0), which is
  -- undefined.
  -- This computes value == 0 ? 1 : floor(log2(value)) / 7 + 1
  -- Use an explicit multiplication to implement the divide of
  -- a number in the 1..63 range.
  -- Explicit OR 0x1 to avoid calling Bits::Log2FloorNonZero(0), which is
  -- undefined.
  -- TODO(kenton):  Make this a symbolic constant.
  -- Eagerly Refresh() so buffer space is immediately available.
  -- Note that setting current_limit_ == size is important to prevent some
  -- code paths from trying to access input_ and segfaulting.
  -- namespace io
  -- namespace protobuf
  -- namespace google
end google.protobuf.binding.coded_stream_h;
