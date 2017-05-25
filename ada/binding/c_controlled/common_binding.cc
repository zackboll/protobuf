
#include <google/protobuf/stubs/common.h>

#ifdef __cplusplus
extern "C" {
#endif

// TODO : Some symbols are incorrectly eliminated and cause linkage errors
//        to the C++ runtime library.  Compiling these unused prototypes
//        seems to resolve the issue, but not sure why.

  google::protobuf::FatalException *
    Google_Protobuf_Ada_New_FatalException (const char* filename,
                                            int line,
					    const std::string& message)
  {
    return new google::protobuf::FatalException(filename, line, message);
  }

#ifdef __cplusplus
}
#endif
