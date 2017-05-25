
#include <google/protobuf/io/coded_stream.h>
#include <google/protobuf/io/zero_copy_stream.h>
#include <google/protobuf/stubs/port.h>


#ifdef __cplusplus
extern "C" {
#endif

// TODO : Some symbols are incorrectly eliminated and cause linkage errors
//        to the C++ runtime library.  Compiling these unused prototypes
//        seems to resolve the issue, but not sure why.

/******************************************************************************/

  google::protobuf::io::CodedInputStream *
    Google_Protobuf_Ada_New_Coded_Input_Stream_From_Zero_Copy_Stream
      (google::protobuf::io::ZeroCopyInputStream *input)
  {
    return new google::protobuf::io::CodedInputStream (input);
  }

/******************************************************************************/

  google::protobuf::io::CodedInputStream *
    Google_Protobuf_Ada_New_Coded_Input_Stream
      (const google::protobuf::uint8* buffer, int size)
  {
    return new google::protobuf::io::CodedInputStream(buffer, size);
  }

/******************************************************************************/

  bool Google_Protobuf_Ada_ConsumedEntireMessage
    (google::protobuf::io::CodedInputStream *is)
  {
    return is->ConsumedEntireMessage();
  }

/******************************************************************************/

  google::protobuf::uint8*
    Google_Protobuf_Ada_GetDirectBufferForNBytesAndAdvance
      (google::protobuf::io::CodedOutputStream *os, int size)
  {
    return os->GetDirectBufferForNBytesAndAdvance(size);
  }

/******************************************************************************/

  bool Google_Protobuf_Ada_IsSerializationDeterministic
    (google::protobuf::io::CodedOutputStream *os)
  {
    return os->IsSerializationDeterministic();
  }

/******************************************************************************/

  int Google_Protobuf_Ada_OutputStream_ByteCount
    (google::protobuf::io::CodedOutputStream *os)
  {
    return os->ByteCount();
  }

/******************************************************************************/

  bool Google_Protobuf_Ada_OutputStream_HadError
    (google::protobuf::io::CodedOutputStream *os)
  {
    return os->HadError();
  }

/******************************************************************************/

#ifdef __cplusplus
}
#endif
