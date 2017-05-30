pragma Ada_2005;
pragma Style_Checks (Off);

with System;

package google.protobuf.binding.mutex_h is

--     type Mutex;
   type Internal is null record;
   pragma Convention (C_Pass_By_Copy, Internal);
   package Class_Mutex is
      type Mutex is limited record
         mInternal : System.Address;  -- /usr/local/include/google/protobuf/stubs/mutex.h:68
      end record;
      pragma Import (CPP, Mutex);

      function New_Mutex return Mutex;  -- /usr/local/include/google/protobuf/stubs/mutex.h:51
      pragma CPP_Constructor (New_Mutex, "_ZN6google8protobuf8internal5MutexC1Ev");

      procedure Delete_Mutex (this : access Mutex);  -- /usr/local/include/google/protobuf/stubs/mutex.h:54
      pragma Import (CPP, Delete_Mutex, "_ZN6google8protobuf8internal5MutexD1Ev");

      procedure Lock (this : access Mutex);  -- /usr/local/include/google/protobuf/stubs/mutex.h:57
      pragma Import (CPP, Lock, "_ZN6google8protobuf8internal5Mutex4LockEv");

      procedure Unlock (this : access Mutex);  -- /usr/local/include/google/protobuf/stubs/mutex.h:60
      pragma Import (CPP, Unlock, "_ZN6google8protobuf8internal5Mutex6UnlockEv");

      procedure AssertHeld (this : access Mutex);  -- /usr/local/include/google/protobuf/stubs/mutex.h:64
      pragma Import (CPP, AssertHeld, "_ZN6google8protobuf8internal5Mutex10AssertHeldEv");

      procedure operator_as (this : access Mutex; arg2 : access constant Mutex);  -- /usr/local/include/google/protobuf/stubs/mutex.h:70
      pragma Import (CPP, operator_as, "_ZN6google8protobuf8internal5MutexaSERKS2_");
   end;
   use Class_Mutex;
   package Class_MutexLock is
      type MutexLock is limited record
         mu_u : access Mutex;  -- /usr/local/include/google/protobuf/stubs/mutex.h:87
      end record;
      pragma Import (CPP, MutexLock);

      function New_MutexLock (mu : access Mutex) return MutexLock;  -- /usr/local/include/google/protobuf/stubs/mutex.h:84
      pragma CPP_Constructor (New_MutexLock, "_ZN6google8protobuf8internal9MutexLockC1EPNS1_5MutexE");

      procedure Delete_MutexLock (this : access MutexLock);  -- /usr/local/include/google/protobuf/stubs/mutex.h:85
      pragma Import (CPP, Delete_MutexLock, "_ZN6google8protobuf8internal9MutexLockD1Ev");

      procedure operator_as (this : access MutexLock; arg2 : access constant MutexLock);  -- /usr/local/include/google/protobuf/stubs/mutex.h:88
      pragma Import (CPP, operator_as, "_ZN6google8protobuf8internal9MutexLockaSERKS2_");
   end;
   use Class_MutexLock;
   subtype ReaderMutexLock is MutexLock;  -- /usr/local/include/google/protobuf/stubs/mutex.h:92

   subtype WriterMutexLock is MutexLock;  -- /usr/local/include/google/protobuf/stubs/mutex.h:93

   package Class_MutexLockMaybe is
      type MutexLockMaybe is limited record
         mu_u : access Mutex;  -- /usr/local/include/google/protobuf/stubs/mutex.h:102
      end record;
      pragma Import (CPP, MutexLockMaybe);

      function New_MutexLockMaybe (mu : access Mutex) return MutexLockMaybe;  -- /usr/local/include/google/protobuf/stubs/mutex.h:98
      pragma CPP_Constructor (New_MutexLockMaybe, "_ZN6google8protobuf8internal14MutexLockMaybeC1EPNS1_5MutexE");

      procedure Delete_MutexLockMaybe (this : access MutexLockMaybe);  -- /usr/local/include/google/protobuf/stubs/mutex.h:100
      pragma Import (CPP, Delete_MutexLockMaybe, "_ZN6google8protobuf8internal14MutexLockMaybeD1Ev");

      procedure operator_as (this : access MutexLockMaybe; arg2 : access constant MutexLockMaybe);  -- /usr/local/include/google/protobuf/stubs/mutex.h:103
      pragma Import (CPP, operator_as, "_ZN6google8protobuf8internal14MutexLockMaybeaSERKS2_");
   end;
   use Class_MutexLockMaybe;
end google.protobuf.binding.mutex_h;
