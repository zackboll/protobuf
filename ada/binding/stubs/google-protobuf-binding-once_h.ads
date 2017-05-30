pragma Ada_2005;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with google.protobuf.binding.atomicops_h;
limited with google.protobuf.binding.callback_h;

package google.protobuf.binding.once_h is

   --  unsupported macro: GOOGLE_PROTOBUF_ONCE_INIT ::google::protobuf::ONCE_STATE_UNINITIALIZED
   --  arg-macro: procedure GOOGLE_PROTOBUF_DECLARE_ONCE .google.protobuf.ProtobufOnceType NAME := GOOGLE_PROTOBUF_ONCE_INIT
   --    .google.protobuf.ProtobufOnceType NAME := GOOGLE_PROTOBUF_ONCE_INIT
   subtype ProtobufOnceType is google.protobuf.binding.atomicops_h.AtomicWord;  -- /usr/local/include/google/protobuf/stubs/once.h:118

   procedure GoogleOnceInitImpl (once : access ProtobufOnceType; the_closure : access google.protobuf.binding.callback_h.Class_Closure.Closure'Class);  -- /usr/local/include/google/protobuf/stubs/once.h:123
   pragma Import (CPP, GoogleOnceInitImpl, "_ZN6google8protobuf18GoogleOnceInitImplEPlPNS0_7ClosureE");

   procedure GoogleOnceInit (once : access ProtobufOnceType; init_func : access procedure);  -- /usr/local/include/google/protobuf/stubs/once.h:125
   pragma Import (CPP, GoogleOnceInit, "_ZN6google8protobuf14GoogleOnceInitEPlPFvvE");

   package Class_GoogleOnceDynamic is
      type GoogleOnceDynamic is limited record
         state_u : aliased ProtobufOnceType;  -- /usr/local/include/google/protobuf/stubs/once.h:158
      end record;
      pragma Import (CPP, GoogleOnceDynamic);

      function New_GoogleOnceDynamic return GoogleOnceDynamic;  -- /usr/local/include/google/protobuf/stubs/once.h:145
      pragma CPP_Constructor (New_GoogleOnceDynamic, "_ZN6google8protobuf17GoogleOnceDynamicC1Ev");


   end;
   use Class_GoogleOnceDynamic;
end google.protobuf.binding.once_h;
