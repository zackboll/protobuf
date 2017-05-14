pragma Ada_2005;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with Interfaces.C.Strings;
with Interfaces.C.Extensions;

package google.protobuf.binding.cpp_exception is

  -- Exception Handling support header for -*- C++ -*-
  -- Copyright (C) 1995-2016 Free Software Foundation, Inc.
  -- This file is part of GCC.
  -- GCC is free software; you can redistribute it and/or modify
  -- it under the terms of the GNU General Public License as published by
  -- the Free Software Foundation; either version 3, or (at your option)
  -- any later version.
  -- GCC is distributed in the hope that it will be useful,
  -- but WITHOUT ANY WARRANTY; without even the implied warranty of
  -- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  -- GNU General Public License for more details.
  -- Under Section 7 of GPL version 3, you are granted additional
  -- permissions described in the GCC Runtime Library Exception, version
  -- 3.1, as published by the Free Software Foundation.
  -- You should have received a copy of the GNU General Public License and
  -- a copy of the GCC Runtime Library Exception along with this program;
  -- see the files COPYING3 and COPYING.RUNTIME respectively.  If not, see
  -- <http://www.gnu.org/licenses/>.
  --* @file exception
  -- *  This is a Standard C++ Library header.
  --  

  --*
  --   * @defgroup exceptions Exceptions
  --   * @ingroup diagnostics
  --   *
  --   * Classes and functions for reporting errors via exception classes.
  --   * @{
  --    

  --*
  --   *  @brief Base class for all library exceptions.
  --   *
  --   *  This is the base class for all exceptions thrown by the standard
  --   *  library, and by certain language expressions.  You are free to derive
  --   *  your own %exception classes, or use a different hierarchy, or to
  --   *  throw non-class data (e.g., fundamental types).
  --    

   package Class_c_exception is
      type c_exception is tagged limited record
         null;
      end record;
      pragma Import (CPP, c_exception);

      --function operator_as (this : access c_exception'Class; arg2 : access constant c_exception'Class) return access c_exception;  -- /tools/x86_64/gnatpro2017/include/c++/6.2.1/exception:60
      --pragma Import (CPP, operator_as, "_ZNSt9exceptionaSERKS_");

      function New_c_exception return c_exception;  -- /tools/x86_64/gnatpro2017/include/c++/6.2.1/exception:63
      pragma CPP_Constructor (New_c_exception, "_ZNSt9exceptionC1Ev");

      procedure Delete_c_exception (this : access c_exception);  -- /tools/x86_64/gnatpro2017/include/c++/6.2.1/exception:64
      pragma Import (CPP, Delete_c_exception, "_ZNSt9exceptionD1Ev");

      function what (this : access constant c_exception) return Interfaces.C.Strings.chars_ptr;  -- /tools/x86_64/gnatpro2017/include/c++/6.2.1/exception:69
      pragma Import (CPP, what, "_ZNKSt9exception4whatEv");
   end;
   use Class_c_exception;
  --* Returns a C-style character string describing the general cause
  --     *  of the current error.   

  --* If an %exception is thrown which is not listed in a function's
  --   *  %exception specification, one of these may be thrown.   

   package Class_bad_exception is
      type bad_exception is limited new c_exception with record
         null;
      end record;
      pragma Import (CPP, bad_exception);

      function New_bad_exception return bad_exception;  -- /tools/x86_64/gnatpro2017/include/c++/6.2.1/exception:77
      pragma CPP_Constructor (New_bad_exception, "_ZNSt13bad_exceptionC1Ev");

      procedure Delete_bad_exception (this : access bad_exception);  -- /tools/x86_64/gnatpro2017/include/c++/6.2.1/exception:81
      pragma Import (CPP, Delete_bad_exception, "_ZNSt13bad_exceptionD1Ev");

      function what (this : access constant bad_exception) return Interfaces.C.Strings.chars_ptr;  -- /tools/x86_64/gnatpro2017/include/c++/6.2.1/exception:85
      pragma Import (CPP, what, "_ZNKSt13bad_exception4whatEv");
   end;
   use Class_bad_exception;
  -- This declaration is not useless:
  -- http://gcc.gnu.org/onlinedocs/gcc-3.0.2/gcc_6.html#SEC118
  -- See comment in eh_exception.cc.
  --/ If you write a replacement %terminate handler, it must be of this type.
   type terminate_handler is access procedure;
   pragma Convention (C, terminate_handler);  -- /tools/x86_64/gnatpro2017/include/c++/6.2.1/exception:89

  --/ If you write a replacement %unexpected handler, it must be of this type.
   type unexpected_handler is access procedure;
   pragma Convention (C, unexpected_handler);  -- /tools/x86_64/gnatpro2017/include/c++/6.2.1/exception:92

  --/ Takes a new handler function as an argument, returns the old function.
   function set_terminate (arg1 : terminate_handler) return terminate_handler;  -- /tools/x86_64/gnatpro2017/include/c++/6.2.1/exception:95
   pragma Import (CPP, set_terminate, "_ZSt13set_terminatePFvvE");

  --/ Return the current terminate handler.
   function get_terminate return terminate_handler;  -- /tools/x86_64/gnatpro2017/include/c++/6.2.1/exception:99
   pragma Import (CPP, get_terminate, "_ZSt13get_terminatev");

  --* The runtime will call this function if %exception handling must be
  --   *  abandoned for any reason.  It can also be called by the user.   

   procedure c_terminate;  -- /tools/x86_64/gnatpro2017/include/c++/6.2.1/exception:104
   pragma Import (CPP, c_terminate, "_ZSt9terminatev");

  --/ Takes a new handler function as an argument, returns the old function.
   function set_unexpected (arg1 : unexpected_handler) return unexpected_handler;  -- /tools/x86_64/gnatpro2017/include/c++/6.2.1/exception:107
   pragma Import (CPP, set_unexpected, "_ZSt14set_unexpectedPFvvE");

  --/ Return the current unexpected handler.
   function get_unexpected return unexpected_handler;  -- /tools/x86_64/gnatpro2017/include/c++/6.2.1/exception:111
   pragma Import (CPP, get_unexpected, "_ZSt14get_unexpectedv");

  --* The runtime will call this function if an %exception is thrown which
  --   *  violates the function's %exception specification.   

   procedure unexpected;  -- /tools/x86_64/gnatpro2017/include/c++/6.2.1/exception:116
   pragma Import (CPP, unexpected, "_ZSt10unexpectedv");

  --* [18.6.4]/1:  'Returns true after completing evaluation of a
  --   *  throw-expression until either completing initialization of the
  --   *  exception-declaration in the matching handler or entering @c unexpected()
  --   *  due to the throw; or after entering @c terminate() for any reason
  --   *  other than an explicit call to @c terminate().  [Note: This includes
  --   *  stack unwinding [15.2].  end note]'
  --   *
  --   *  2: 'When @c uncaught_exception() is true, throwing an
  --   *  %exception can result in a call of @c terminate()
  --   *  (15.5.1).'
  --    

   function uncaught_exception return Extensions.bool;  -- /tools/x86_64/gnatpro2017/include/c++/6.2.1/exception:129
   pragma Import (CPP, uncaught_exception, "_ZSt18uncaught_exceptionv");

  --/ The number of uncaught exceptions.
   function uncaught_exceptions return int;  -- /tools/x86_64/gnatpro2017/include/c++/6.2.1/exception:134
   pragma Import (CPP, uncaught_exceptions, "_ZSt19uncaught_exceptionsv");

  -- @} group exceptions
  -- namespace std
  --*
  --   *  @brief A replacement for the standard terminate_handler which
  --   *  prints more information about the terminating exception (if any)
  --   *  on stderr.
  --   *
  --   *  @ingroup exceptions
  --   *
  --   *  Call
  --   *   @code
  --   *     std::set_terminate(__gnu_cxx::__verbose_terminate_handler)
  --   *   @endcode
  --   *  to use.  For more info, see
  --   *  http://gcc.gnu.org/onlinedocs/libstdc++/manual/bk01pt02ch06s02.html
  --   *
  --   *  In 3.4 and later, this is on by default.
  --    

   --  skipped func __verbose_terminate_handler

  -- namespace
  -- extern "C++"
end google.protobuf.binding.cpp_exception;
