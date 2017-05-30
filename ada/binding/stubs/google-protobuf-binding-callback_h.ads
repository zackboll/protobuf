pragma Ada_2005;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with Interfaces.C.Extensions;
with System;

package google.protobuf.binding.callback_h is

   package Class_Closure is
      type Closure is abstract tagged limited record
         null;
      end record;
      pragma Import (CPP, Closure);

      function New_Closure return Closure is abstract;  -- /usr/local/include/google/protobuf/stubs/callback.h:72
      pragma CPP_Constructor (New_Closure, "_ZN6google8protobuf7ClosureC1Ev");

      procedure Delete_Closure (this : access Closure);  -- /usr/local/include/google/protobuf/stubs/callback.h:73
      pragma Import (CPP, Delete_Closure, "_ZN6google8protobuf7ClosureD1Ev");

      procedure Run (this : access Closure) is abstract;  -- /usr/local/include/google/protobuf/stubs/callback.h:75

      procedure operator_as (this : access Closure'Class; arg2 : access constant Closure'Class);  -- /usr/local/include/google/protobuf/stubs/callback.h:78
      pragma Import (CPP, operator_as, "_ZN6google8protobuf7ClosureaSERKS1_");
   end;
   use Class_Closure;
  package Class_FunctionClosure0 is

      type FunctionType is access function return System.Address;

      type FunctionClosure0 is limited new Closure with record
         function_u : FunctionType;  -- /usr/local/include/google/protobuf/stubs/callback.h:134
         self_deleting_u : aliased Extensions.bool;  -- /usr/local/include/google/protobuf/stubs/callback.h:135
      end record;
      pragma Import (CPP, FunctionClosure0);

      function New_FunctionClosure0 (c_function : FunctionType; self_deleting : Extensions.bool) return FunctionClosure0;  -- /usr/local/include/google/protobuf/stubs/callback.h:123
      pragma CPP_Constructor (New_FunctionClosure0, "_ZN6google8protobuf8internal16FunctionClosure0C1EPFvvEb");

      procedure Delete_FunctionClosure0 (this : access FunctionClosure0);  -- /usr/local/include/google/protobuf/stubs/callback.h:125
      pragma Import (CPP, Delete_FunctionClosure0, "_ZN6google8protobuf8internal16FunctionClosure0D1Ev");

      procedure Run (this : access FunctionClosure0);  -- /usr/local/include/google/protobuf/stubs/callback.h:127
      pragma Import (CPP, Run, "_ZN6google8protobuf8internal16FunctionClosure03RunEv");
   end;
   use Class_FunctionClosure0;
   function NewCallback (c_function : access procedure) return access Closure;  -- /usr/local/include/google/protobuf/stubs/callback.h:410
   pragma Import (CPP, NewCallback, "_ZN6google8protobuf11NewCallbackEPFvvE");

   function NewPermanentCallback (c_function : access procedure) return access Closure;  -- /usr/local/include/google/protobuf/stubs/callback.h:415
   pragma Import (CPP, NewPermanentCallback, "_ZN6google8protobuf20NewPermanentCallbackEPFvvE");

   procedure DoNothing;  -- /usr/local/include/google/protobuf/stubs/callback.h:570
   pragma Import (CPP, DoNothing, "_ZN6google8protobuf9DoNothingEv");

end google.protobuf.binding.callback_h;
