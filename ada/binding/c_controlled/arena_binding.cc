
#include <google/protobuf/arena.h>
#include <google/protobuf/message_lite.h>

// Use extended namespace names to avoid polution

extern "C" {

  void Google_Protobuf_Ada_Arena_Own_Message_Lite
    (::google::protobuf::Arena* arena,
     ::google::protobuf::MessageLite* message) {
   // (void *object) {
    //::google::protobuf::Arena* arena = (::google::protobuf::Arena*) object;
    arena->Own(message);
  }

}
