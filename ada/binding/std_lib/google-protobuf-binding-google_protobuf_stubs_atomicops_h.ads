pragma Ada_2005;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with google.protobuf.binding.google_protobuf_stubs_port_h;
with google.protobuf.binding.stdint_h;

package google.protobuf.binding.google_protobuf_stubs_atomicops_h is

   subtype Atomic32 is google.protobuf.binding.google_protobuf_stubs_port_h.int32;  -- /usr/local/include/google/protobuf/stubs/atomicops.h:75

   subtype Atomic64 is google.protobuf.binding.stdint_h.intptr_t;  -- /usr/local/include/google/protobuf/stubs/atomicops.h:85

   subtype AtomicWord is google.protobuf.binding.stdint_h.intptr_t;  -- /usr/local/include/google/protobuf/stubs/atomicops.h:92

end google.protobuf.binding.google_protobuf_stubs_atomicops_h;
