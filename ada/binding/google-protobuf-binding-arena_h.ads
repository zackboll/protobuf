pragma Ada_2005;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with System;
with google.protobuf.binding.stddef_h;
with Interfaces.C.Strings;
with google.protobuf.binding.google_protobuf_stubs_port_h;
limited with google.protobuf.binding.cpp_typeinfo;
with google.protobuf.binding.google_protobuf_stubs_atomicops_h;
with Interfaces.C.Extensions;
with google.protobuf.binding.google_protobuf_stubs_mutex_h;
--  with google.protobuf.binding.cpp_6_2_1_bits_stl_pair_h;
--  with google.protobuf.binding.google_protobuf_stubs_template_util_h;
with google.protobuf.binding.google_protobuf_stubs_atomic_sequence_num_h;

package google.protobuf.binding.arena_h is

   --  skipped empty struct Message

   --  skipped empty struct ArenaString

   --  skipped empty struct LazyField

   procedure arena_free (object : System.Address; size : google.protobuf.binding.stddef_h.size_t);  -- ../../../src/google/protobuf/arena.h:82
   pragma Import (CPP, arena_free, "_ZN6google8protobuf8internal10arena_freeEPvm");

   package Class_ArenaOptions is
      type ArenaOptions is limited record
         start_block_size : aliased google.protobuf.binding.stddef_h.size_t;  -- ../../../src/google/protobuf/arena.h:98
         max_block_size : aliased google.protobuf.binding.stddef_h.size_t;  -- ../../../src/google/protobuf/arena.h:104
         initial_block : Interfaces.C.Strings.chars_ptr;  -- ../../../src/google/protobuf/arena.h:110
         initial_block_size : aliased google.protobuf.binding.stddef_h.size_t;  -- ../../../src/google/protobuf/arena.h:113
         block_alloc : access function (arg1 : google.protobuf.binding.stddef_h.size_t) return System.Address;  -- ../../../src/google/protobuf/arena.h:120
         block_dealloc : access procedure (arg1 : System.Address; arg2 : google.protobuf.binding.stddef_h.size_t);  -- ../../../src/google/protobuf/arena.h:124
         on_arena_init : access function (arg1 : System.Address) return System.Address;  -- ../../../src/google/protobuf/arena.h:135
         on_arena_reset : access procedure
              (arg1 : System.Address;
               arg2 : System.Address;
               arg3 : google.protobuf.binding.google_protobuf_stubs_port_h.uint64);  -- ../../../src/google/protobuf/arena.h:136
         on_arena_destruction : access procedure
              (arg1 : System.Address;
               arg2 : System.Address;
               arg3 : google.protobuf.binding.google_protobuf_stubs_port_h.uint64);  -- ../../../src/google/protobuf/arena.h:137
         on_arena_allocation : access procedure
              (arg1 : access constant google.protobuf.binding.cpp_typeinfo.Class_type_info.type_info;
               arg2 : google.protobuf.binding.google_protobuf_stubs_port_h.uint64;
               arg3 : System.Address);  -- ../../../src/google/protobuf/arena.h:145
      end record;
      pragma Import (CPP, ArenaOptions);

      function New_ArenaOptions return ArenaOptions;  -- ../../../src/google/protobuf/arena.h:147
      pragma CPP_Constructor (New_ArenaOptions, "_ZN6google8protobuf12ArenaOptionsC1Ev");

      kDefaultStartBlockSize : aliased google.protobuf.binding.stddef_h.size_t;  -- ../../../src/google/protobuf/arena.h:162
      pragma Import (CPP, kDefaultStartBlockSize, "_ZN6google8protobuf12ArenaOptions22kDefaultStartBlockSizeE");

      kDefaultMaxBlockSize : aliased google.protobuf.binding.stddef_h.size_t;  -- ../../../src/google/protobuf/arena.h:163
      pragma Import (CPP, kDefaultMaxBlockSize, "_ZN6google8protobuf12ArenaOptions20kDefaultMaxBlockSizeE");
   end;
   use Class_ArenaOptions;
   --  skipped empty struct MockArena

--     type Arena;
   type InternalIsArenaConstructableHelper is record
      null;
   end record;
   pragma Convention (C_Pass_By_Copy, InternalIsArenaConstructableHelper);
   type Block is record
      owner : System.Address;  -- ../../../src/google/protobuf/arena.h:550
      next : access Block;  -- ../../../src/google/protobuf/arena.h:552
      pos : aliased google.protobuf.binding.stddef_h.size_t;  -- ../../../src/google/protobuf/arena.h:555
      size : aliased google.protobuf.binding.stddef_h.size_t;  -- ../../../src/google/protobuf/arena.h:556
   end record;
   pragma Convention (C_Pass_By_Copy, Block);
   type ThreadCache is record
      last_lifecycle_id_seen : aliased google.protobuf.binding.google_protobuf_stubs_port_h.int64;  -- ../../../src/google/protobuf/arena.h:569
      last_block_used_u : access Block;  -- ../../../src/google/protobuf/arena.h:570
   end record;
   pragma Convention (C_Pass_By_Copy, ThreadCache);
   type InternalIsDestructorSkippableHelper is record
      null;
   end record;
   pragma Convention (C_Pass_By_Copy, InternalIsDestructorSkippableHelper);
   type Node is record
      elem : System.Address;  -- ../../../src/google/protobuf/arena.h:917
      cleanup : access procedure (arg1 : System.Address);  -- ../../../src/google/protobuf/arena.h:918
      next : access Node;  -- ../../../src/google/protobuf/arena.h:919
   end record;
   pragma Convention (C_Pass_By_Copy, Node);
   package Class_Arena is
      type Arena is limited record
         lifecycle_id_u : aliased google.protobuf.binding.google_protobuf_stubs_port_h.int64;  -- ../../../src/google/protobuf/arena.h:908
         blocks_u : aliased google.protobuf.binding.google_protobuf_stubs_atomicops_h.AtomicWord;  -- ../../../src/google/protobuf/arena.h:910
         hint_u : aliased google.protobuf.binding.google_protobuf_stubs_atomicops_h.AtomicWord;  -- ../../../src/google/protobuf/arena.h:911
         space_allocated_u : aliased google.protobuf.binding.google_protobuf_stubs_port_h.uint64;  -- ../../../src/google/protobuf/arena.h:912
         cleanup_list_u : aliased google.protobuf.binding.google_protobuf_stubs_atomicops_h.AtomicWord;  -- ../../../src/google/protobuf/arena.h:922
         owns_first_block_u : aliased Extensions.bool;  -- ../../../src/google/protobuf/arena.h:925
         blocks_lock_u : aliased google.protobuf.binding.google_protobuf_stubs_mutex_h.Class_Mutex.Mutex;  -- ../../../src/google/protobuf/arena.h:926
         hooks_cookie_u : System.Address;  -- ../../../src/google/protobuf/arena.h:942
         options_u : aliased ArenaOptions;  -- ../../../src/google/protobuf/arena.h:944
      end record;
      pragma Import (CPP, Arena);

      function New_Arena (options : access constant ArenaOptions) return Arena;  -- ../../../src/google/protobuf/arena.h:228
      pragma CPP_Constructor (New_Arena, "_ZN6google8protobuf5ArenaC1ERKNS0_12ArenaOptionsE");

      function New_Arena return Arena;  -- ../../../src/google/protobuf/arena.h:234
      pragma CPP_Constructor (New_Arena, "_ZN6google8protobuf5ArenaC1Ev");

      procedure Delete_Arena (this : access Arena);  -- ../../../src/google/protobuf/arena.h:242
      pragma Import (CPP, Delete_Arena, "_ZN6google8protobuf5ArenaD1Ev");

      function SpaceAllocated (this : access constant Arena) return google.protobuf.binding.google_protobuf_stubs_port_h.uint64;  -- ../../../src/google/protobuf/arena.h:466
      pragma Import (CPP, SpaceAllocated, "_ZNK6google8protobuf5Arena14SpaceAllocatedEv");

      function SpaceUsed (this : access constant Arena) return google.protobuf.binding.google_protobuf_stubs_port_h.uint64;  -- ../../../src/google/protobuf/arena.h:471
      pragma Import (CPP, SpaceUsed, "_ZNK6google8protobuf5Arena9SpaceUsedEv");

--        function SpaceAllocatedAndUsed (this : access constant Arena) return google.protobuf.binding.cpp_6_2_1_bits_stl_pair_h.Class_pair.pair;  -- ../../../src/google/protobuf/arena.h:476
--        pragma Import (CPP, SpaceAllocatedAndUsed, "_ZNK6google8protobuf5Arena21SpaceAllocatedAndUsedEv");

      function Reset (this : access Arena) return google.protobuf.binding.google_protobuf_stubs_port_h.uint64;  -- ../../../src/google/protobuf/arena.h:483
      pragma Import (CPP, Reset, "_ZN6google8protobuf5Arena5ResetEv");

      procedure OwnCustomDestructor
        (this : access Arena;
         object : System.Address;
         destruct : access procedure (arg1 : System.Address));  -- ../../../src/google/protobuf/arena.h:508
      pragma Import (CPP, OwnCustomDestructor, "_ZN6google8protobuf5Arena19OwnCustomDestructorEPvPFvS2_E");

      function AllocateAligned
        (this : access Arena;
         allocated : access constant google.protobuf.binding.cpp_typeinfo.Class_type_info.type_info'Class;
         n : google.protobuf.binding.stddef_h.size_t) return System.Address;  -- ../../../src/google/protobuf/arena.h:880
      pragma Import (CPP, AllocateAligned, "_ZN6google8protobuf5Arena15AllocateAlignedEPKSt9type_infom");

      function AllocateAligned2 (this : access Arena; n : google.protobuf.binding.stddef_h.size_t) return System.Address;  -- ../../../src/google/protobuf/arena.h:883
      pragma Import (CPP, AllocateAligned2, "_ZN6google8protobuf5Arena15AllocateAlignedEm");

      procedure Init (this : access Arena);  -- ../../../src/google/protobuf/arena.h:887
      pragma Import (CPP, Init, "_ZN6google8protobuf5Arena4InitEv");

      function FreeBlocks (this : access Arena) return google.protobuf.binding.google_protobuf_stubs_port_h.uint64;  -- ../../../src/google/protobuf/arena.h:891
      pragma Import (CPP, FreeBlocks, "_ZN6google8protobuf5Arena10FreeBlocksEv");

      procedure AddListNode
        (this : access Arena;
         elem : System.Address;
         cleanup : access procedure (arg1 : System.Address));  -- ../../../src/google/protobuf/arena.h:898
      pragma Import (CPP, AddListNode, "_ZN6google8protobuf5Arena11AddListNodeEPvPFvS2_E");

      procedure CleanupList (this : access Arena);  -- ../../../src/google/protobuf/arena.h:900
      pragma Import (CPP, CleanupList, "_ZN6google8protobuf5Arena11CleanupListEv");

      function ResetInternal (this : access Arena) return google.protobuf.binding.google_protobuf_stubs_port_h.uint64;  -- ../../../src/google/protobuf/arena.h:901
      pragma Import (CPP, ResetInternal, "_ZN6google8protobuf5Arena13ResetInternalEv");

      procedure SetThreadCacheBlock (this : access Arena; the_block : access Block);  -- ../../../src/google/protobuf/arena.h:903
      pragma Import (CPP, SetThreadCacheBlock, "_ZN6google8protobuf5Arena19SetThreadCacheBlockEPNS1_5BlockE");

      procedure AddBlock (this : access Arena; b : access Block);  -- ../../../src/google/protobuf/arena.h:928
      pragma Import (CPP, AddBlock, "_ZN6google8protobuf5Arena8AddBlockEPNS1_5BlockE");

      procedure AddBlockInternal (this : access Arena; b : access Block);  -- ../../../src/google/protobuf/arena.h:931
      pragma Import (CPP, AddBlockInternal, "_ZN6google8protobuf5Arena16AddBlockInternalEPNS1_5BlockE");

      function SlowAlloc (this : access Arena; n : google.protobuf.binding.stddef_h.size_t) return System.Address;  -- ../../../src/google/protobuf/arena.h:932
      pragma Import (CPP, SlowAlloc, "_ZN6google8protobuf5Arena9SlowAllocEm");

      function FindBlock (this : access Arena; me : System.Address) return access Block;  -- ../../../src/google/protobuf/arena.h:933
      pragma Import (CPP, FindBlock, "_ZN6google8protobuf5Arena9FindBlockEPv");

      function NewBlock
        (this : access Arena;
         me : System.Address;
         my_last_block : access Block;
         n : google.protobuf.binding.stddef_h.size_t;
         start_block_size : google.protobuf.binding.stddef_h.size_t;
         max_block_size : google.protobuf.binding.stddef_h.size_t) return access Block;  -- ../../../src/google/protobuf/arena.h:934
      pragma Import (CPP, NewBlock, "_ZN6google8protobuf5Arena8NewBlockEPvPNS1_5BlockEmmm");

      procedure operator_as (this : access Arena; arg2 : access constant Arena);  -- ../../../src/google/protobuf/arena.h:946
      pragma Import (CPP, operator_as, "_ZN6google8protobuf5ArenaaSERKS1_");

      package Static is
         function thread_cache return access ThreadCache;  -- ../../../src/google/protobuf/arena.h:586
         pragma Import (CPP, thread_cache, "_ZN6google8protobuf5Arena12thread_cacheEv");

         function AllocFromBlock (b : access Block; n : google.protobuf.binding.stddef_h.size_t) return System.Address;  -- ../../../src/google/protobuf/arena.h:936
         pragma Import (CPP, AllocFromBlock, "_ZN6google8protobuf5Arena14AllocFromBlockEPNS1_5BlockEm");
      end;

--        function CreateMessage (arg1 : access Arena) return access  renames Static.CreateMessage;

--        function CreateMessage (arg1 : access Arena; arg2 : System.Address) return access  renames Static.CreateMessage;

--        function CreateMessage
--          (arg1 : access Arena;
--           arg2 : System.Address;
--           arg3 : System.Address) return access  renames Static.CreateMessage;
--
--        function Create (arg1 : access Arena; arg2 : ) return access  renames Static.Create;
--
--        function Create (arg1 : access Arena) return access  renames Static.Create;
--
--        function Create (arg1 : access Arena; arg2 : System.Address) return access  renames Static.Create;
--
--        function Create
--          (arg1 : access Arena;
--           arg2 : System.Address;
--           arg3 : System.Address) return access  renames Static.Create;
--
--        function Create
--          (arg1 : access Arena;
--           arg2 : System.Address;
--           arg3 : System.Address;
--           arg4 : System.Address) return access  renames Static.Create;
--
--        function Create
--          (arg1 : access Arena;
--           arg2 : System.Address;
--           arg3 : System.Address;
--           arg4 : System.Address;
--           arg5 : System.Address) return access  renames Static.Create;
--
--        function Create
--          (arg1 : access Arena;
--           arg2 : System.Address;
--           arg3 : System.Address;
--           arg4 : System.Address;
--           arg5 : System.Address;
--           arg6 : System.Address) return access  renames Static.Create;
--
--        function Create
--          (arg1 : access Arena;
--           arg2 : System.Address;
--           arg3 : System.Address;
--           arg4 : System.Address;
--           arg5 : System.Address;
--           arg6 : System.Address;
--           arg7 : System.Address) return access  renames Static.Create;
--
--        function Create
--          (arg1 : access Arena;
--           arg2 : System.Address;
--           arg3 : System.Address;
--           arg4 : System.Address;
--           arg5 : System.Address;
--           arg6 : System.Address;
--           arg7 : System.Address;
--           arg8 : System.Address) return access  renames Static.Create;
--
--        function Create
--          (arg1 : access Arena;
--           arg2 : System.Address;
--           arg3 : System.Address;
--           arg4 : System.Address;
--           arg5 : System.Address;
--           arg6 : System.Address;
--           arg7 : System.Address;
--           arg8 : System.Address;
--           arg9 : System.Address) return access  renames Static.Create;

--        function CreateArray (arg1 : access Arena; arg2 : google.protobuf.binding.stddef_h.size_t) return access  renames Static.CreateArray;

--        function GetArena (arg1 : System.Address) return access Arena renames Static.GetArena;

      function thread_cache return access ThreadCache renames Static.thread_cache;

--        function SkipDeleteList (arg1 : System.Address) return Extensions.bool renames Static.SkipDeleteList;
--
--        function SkipDeleteList return Extensions.bool renames Static.SkipDeleteList;

--        function CreateMaybeMessage (arg1 : access Arena; arg2 : System.Address) return access  renames Static.CreateMaybeMessage;

--        function CreateMaybeMessage (arg1 : access Arena  -- , ...
--           ) return access  renames Static.CreateMaybeMessage;

--        procedure CreateInArenaStorage (arg1 : System.Address; arg2 : access Arena) renames Static.CreateInArenaStorage;
--
--        procedure CreateInArenaStorageInternal
--          (arg1 : System.Address;
--           arg2 : access Arena;
--           arg3 : google.protobuf.binding.google_protobuf_stubs_template_util_h.Class_true_type.true_type) renames Static.CreateInArenaStorageInternal;
--
--        procedure CreateInArenaStorageInternal
--          (arg1 : System.Address;
--           arg2 : access Arena;
--           arg3 : google.protobuf.binding.google_protobuf_stubs_template_util_h.Class_false_type.false_type) renames Static.CreateInArenaStorageInternal;
--
--        procedure RegisterDestructorInternal
--          (arg1 : System.Address;
--           arg2 : access Arena;
--           arg3 : google.protobuf.binding.google_protobuf_stubs_template_util_h.Class_true_type.true_type) renames Static.RegisterDestructorInternal;
--
--        procedure RegisterDestructorInternal
--          (arg1 : System.Address;
--           arg2 : access Arena;
--           arg3 : google.protobuf.binding.google_protobuf_stubs_template_util_h.Class_false_type.false_type) renames Static.RegisterDestructorInternal;
--
--        function GetArenaInternal (arg1 : System.Address; arg2 : System.Address) return access Arena renames Static.GetArenaInternal;
--
--        function GetArenaInternal (arg1 : System.Address  -- , ...
--           ) return access Arena renames Static.GetArenaInternal;

      function AllocFromBlock (b : access Block; n : google.protobuf.binding.stddef_h.size_t) return System.Address renames Static.AllocFromBlock;

      kHeaderSize : aliased google.protobuf.binding.stddef_h.size_t;  -- ../../../src/google/protobuf/arena.h:573
      pragma Import (CPP, kHeaderSize, "_ZN6google8protobuf5Arena11kHeaderSizeE");

      lifecycle_id_generator_u : aliased google.protobuf.binding.google_protobuf_stubs_atomic_sequence_num_h.Class_SequenceNumber.SequenceNumber;  -- ../../../src/google/protobuf/arena.h:574
      pragma Import (CPP, lifecycle_id_generator_u, "_ZN6google8protobuf5Arena23lifecycle_id_generator_E");

      thread_cache_u : aliased ThreadCache;  -- ../../../src/google/protobuf/arena.h:585
      pragma Import (CPP, thread_cache_u, "_ZN6google8protobuf5Arena13thread_cache_E");
   end;
   use Class_Arena;
end google.protobuf.binding.arena_h;
