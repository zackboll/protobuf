
#include <google/protobuf/arena.h>
#include <google/protobuf/message_lite.h>

// TODO : Some symbols are incorrectly eliminated and cause linkage errors
//        to the C++ runtime library.  Compiling these unused prototypes
//        seems to resolve the issue, but not sure why.

// Use extended namespace names to avoid polution

#ifdef __cplusplus
extern "C" {
#endif

  void Google_Protobuf_Ada_Arena_Own_Message_Lite
    (::google::protobuf::Arena* arena,
     ::google::protobuf::MessageLite* message)
  {
    arena->Own(message);
  }

#ifdef __cplusplus
}
#endif
