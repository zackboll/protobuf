// TODO : Some symbols are incorrectly eliminated and cause linkage errors
//        to the C++ runtime library.  Compiling these unused prototypes
//        seems to resolve the issue, but not sure why.

#include <exception>
#include <typeinfo>

#ifdef __cplusplus
extern "C" {
#endif

/******************************************************************************/

  std::exception *Google_Protobuf_Ada_New_Exception() {
    return new std::exception();
  }

/******************************************************************************/

  std::bad_exception *Google_Protobuf_Ada_New_Bad_Exception () {
    return new std::bad_exception();
  }

/******************************************************************************/

  std::bad_cast *Google_Protobuf_Ada_New_Bad_Cast () {
    return new std::bad_cast();
  }

/******************************************************************************/

  std::bad_typeid *Google_Protobuf_Ada_New_Bad_TypeID () {
    return new std::bad_typeid();
  }

/******************************************************************************/

#ifdef __cplusplus
}
#endif
