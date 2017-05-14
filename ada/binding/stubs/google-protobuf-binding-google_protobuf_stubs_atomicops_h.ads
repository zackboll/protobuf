pragma Ada_2005;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with google.protobuf.binding.google_protobuf_stubs_port_h;
with google.protobuf.binding.stdint_h;

package google.protobuf.binding.google_protobuf_stubs_atomicops_h is

  -- Protocol Buffers - Google's data interchange format
  -- Copyright 2012 Google Inc.  All rights reserved.
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
  -- The routines exported by this module are subtle.  If you use them, even if
  -- you get the code right, it will depend on careful reasoning about atomicity
  -- and memory ordering; it will be less readable, and harder to maintain.  If
  -- you plan to use these routines, you should have a good reason, such as solid
  -- evidence that performance would otherwise suffer, or there being no
  -- alternative.  You should assume only properties explicitly guaranteed by the
  -- specifications in this file.  You are almost certainly _not_ writing code
  -- just for the x86; if you assume x86 semantics, x86 hardware bugs and
  -- implementations on other archtectures will cause your code to break.  If you
  -- do not know what you are doing, avoid these routines, and use a Mutex.
  -- It is incorrect to make direct assignments to/from an atomic variable.
  -- You should use one of the Load or Store routines.  The NoBarrier
  -- versions are provided when no barriers are needed:
  --   NoBarrier_Store()
  --   NoBarrier_Load()
  -- Although there are currently no compiler enforcement, you are encouraged
  -- to use these.
  -- This header and the implementations for each platform (located in
  -- atomicops_internals_*) must be kept in sync with the upstream code (V8).
  -- Don't include this file for people not concerned about thread safety.
   subtype Atomic32 is google.protobuf.binding.google_protobuf_stubs_port_h.int32;  -- /usr/local/include/google/protobuf/stubs/atomicops.h:75

  -- We need to be able to go between Atomic64 and AtomicWord implicitly.  This
  -- means Atomic64 and AtomicWord should be the same type on 64-bit.
  -- NaCl's intptr_t is not actually 64-bits on 64-bit!
  -- http://code.google.com/p/nativeclient/issues/detail?id=1162
  -- sparcv9's pointer type is 32bits
   subtype Atomic64 is google.protobuf.binding.stdint_h.intptr_t;  -- /usr/local/include/google/protobuf/stubs/atomicops.h:85

  -- Use AtomicWord for a machine-sized pointer.  It will use the Atomic32 or
  -- Atomic64 routines below, depending on your architecture.
   subtype AtomicWord is google.protobuf.binding.stdint_h.intptr_t;  -- /usr/local/include/google/protobuf/stubs/atomicops.h:92

  -- Atomically execute:
  --      result = *ptr;
  --      if (*ptr == old_value)
  --        *ptr = new_value;
  --      return result;
  -- I.e., replace "*ptr" with "new_value" if "*ptr" used to be "old_value".
  -- Always return the old value of "*ptr"
  -- This routine implies no memory barriers.
  -- Atomically store new_value into *ptr, returning the previous value held in
  -- *ptr.  This routine implies no memory barriers.
  -- Atomically increment *ptr by "increment".  Returns the new value of
  -- *ptr with the increment applied.  This routine implies no memory barriers.
  -- These following lower-level operations are typically useful only to people
  -- implementing higher-level synchronization operations like spinlocks,
  -- mutexes, and condition-variables.  They combine CompareAndSwap(), a load, or
  -- a store with appropriate memory-ordering instructions.  "Acquire" operations
  -- ensure that no later memory access can be reordered ahead of the operation.
  -- "Release" operations ensure that no previous memory access can be reordered
  -- after the operation.  "Barrier" operations have both "Acquire" and "Release"
  -- semantics.   A MemoryBarrierInternal() has "Barrier" semantics, but does no
  -- memory access.
  -- This function was renamed from MemoryBarrier to MemoryBarrierInternal
  -- because MemoryBarrier is a define in Windows ARM builds and we do not
  -- undefine it because we call it from this function.
  -- 64-bit atomic operations (only available on 64-bit processors).
  -- namespace internal
  -- namespace protobuf
  -- namespace google
  -- Include our platform specific implementation.
  -- ThreadSanitizer, http://clang.llvm.org/docs/ThreadSanitizer.html.
  -- MSVC.
  -- Solaris
  -- AIX
  -- GCC.
  -- The static_asserts in the C++11 atomics implementation cause it to fail
  -- with certain compilers, e.g. nvcc on macOS. Don't use elsewhere unless
  -- the TODO in that file is addressed.
  -- Unknown.
  -- On some platforms we need additional declarations to make AtomicWord
  -- compatible with our other Atomic* types.
end google.protobuf.binding.google_protobuf_stubs_atomicops_h;
