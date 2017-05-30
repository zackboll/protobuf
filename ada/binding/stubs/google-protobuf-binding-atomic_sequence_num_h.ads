pragma Ada_2005;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with google.protobuf.binding.atomicops_h;

package google.protobuf.binding.atomic_sequence_num_h is

   package Class_SequenceNumber is
      type SequenceNumber is limited record
         word_u : aliased google.protobuf.binding.atomicops_h.AtomicWord;  -- /usr/local/include/google/protobuf/stubs/atomic_sequence_num.h:47
      end record;
      pragma Import (CPP, SequenceNumber);

      function New_SequenceNumber return SequenceNumber;  -- /usr/local/include/google/protobuf/stubs/atomic_sequence_num.h:41
      pragma CPP_Constructor (New_SequenceNumber, "_ZN6google8protobuf8internal14SequenceNumberC1Ev");

      function GetNext (this : access SequenceNumber) return google.protobuf.binding.atomicops_h.AtomicWord;  -- /usr/local/include/google/protobuf/stubs/atomic_sequence_num.h:43
      pragma Import (CPP, GetNext, "_ZN6google8protobuf8internal14SequenceNumber7GetNextEv");
   end;
   use Class_SequenceNumber;
end google.protobuf.binding.atomic_sequence_num_h;
