pragma Ada_2005;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with Interfaces.C.Strings;
with Interfaces.C.Extensions;
with System;
with google.protobuf.binding.cpp_exception;

package google.protobuf.binding.cpp_typeinfo is

   --  skipped empty struct uu_class_type_info

   package Class_type_info is
      type type_info is tagged limited record
         uu_name : Interfaces.C.Strings.chars_ptr;  -- /tools/x86_64/gnatpro2017/include/c++/6.2.1/typeinfo:171
      end record;
      pragma Import (CPP, type_info);

      procedure Delete_type_info (this : access type_info);  -- /tools/x86_64/gnatpro2017/include/c++/6.2.1/typeinfo:95
      pragma Import (CPP, Delete_type_info, "_ZNSt9type_infoD1Ev");

      function name (this : access constant type_info'Class) return Interfaces.C.Strings.chars_ptr;  -- /tools/x86_64/gnatpro2017/include/c++/6.2.1/typeinfo:99
      pragma Import (CPP, name, "_ZNKSt9type_info4nameEv");

      function before (this : access constant type_info'Class; uu_arg : access constant type_info'Class) return Extensions.bool;  -- /tools/x86_64/gnatpro2017/include/c++/6.2.1/typeinfo:115
      pragma Import (CPP, before, "_ZNKSt9type_info6beforeERKS_");

      function operator_eq (this : access constant type_info'Class; uu_arg : access constant type_info'Class) return Extensions.bool;  -- /tools/x86_64/gnatpro2017/include/c++/6.2.1/typeinfo:120
      pragma Import (CPP, operator_eq, "_ZNKSt9type_infoeqERKS_");

      function operator_ne (this : access constant type_info'Class; uu_arg : access constant type_info'Class) return Extensions.bool;  -- /tools/x86_64/gnatpro2017/include/c++/6.2.1/typeinfo:136
      pragma Import (CPP, operator_ne, "_ZNKSt9type_infoneERKS_");

      function hash_code (this : access constant type_info'Class) return Interfaces.C.size_t;  -- zboll, hand modified from auto-generated
      pragma Import (CPP, hash_code, "_ZNKSt9type_info9hash_codeEv");

      function uu_is_pointer_p (this : access constant type_info) return Extensions.bool;  -- /tools/x86_64/gnatpro2017/include/c++/6.2.1/typeinfo:152
      pragma Import (CPP, uu_is_pointer_p, "_ZNKSt9type_info14__is_pointer_pEv");

      function uu_is_function_p (this : access constant type_info) return Extensions.bool;  -- /tools/x86_64/gnatpro2017/include/c++/6.2.1/typeinfo:155
      pragma Import (CPP, uu_is_function_p, "_ZNKSt9type_info15__is_function_pEv");

      function uu_do_catch
        (this : access constant type_info;
         uu_thr_type : access constant type_info'Class;
         uu_thr_obj : System.Address;
         uu_outer : unsigned) return Extensions.bool;  -- /tools/x86_64/gnatpro2017/include/c++/6.2.1/typeinfo:163
      pragma Import (CPP, uu_do_catch, "_ZNKSt9type_info10__do_catchEPKS_PPvj");

      function uu_do_upcast
        (this : access constant type_info;
         uu_target : System.Address;
         uu_obj_ptr : System.Address) return Extensions.bool;  -- /tools/x86_64/gnatpro2017/include/c++/6.2.1/typeinfo:167
      pragma Import (CPP, uu_do_upcast, "_ZNKSt9type_info11__do_upcastEPKN10__cxxabiv117__class_type_infoEPPv");

--        function New_type_info (uu_n : Interfaces.C.Strings.chars_ptr) return type_info;  -- /tools/x86_64/gnatpro2017/include/c++/6.2.1/typeinfo:173
--        pragma CPP_Constructor (New_type_info, "_ZNSt9type_infoC1EPKc");

      function operator_as (this : access type_info'Class; arg2 : access constant type_info'Class) return access type_info;  -- /tools/x86_64/gnatpro2017/include/c++/6.2.1/typeinfo:177
      pragma Import (CPP, operator_as, "_ZNSt9type_infoaSERKS_");


   end;
   use Class_type_info;
   package Class_bad_cast is
      type bad_cast is limited new google.protobuf.binding.cpp_exception.Class_c_exception.c_exception with record
         null;
      end record;
      pragma Import (CPP, bad_cast);

      function New_bad_cast return bad_cast;  -- /tools/x86_64/gnatpro2017/include/c++/6.2.1/typeinfo:190
      pragma CPP_Constructor (New_bad_cast, "_ZNSt8bad_castC1Ev");

      procedure Delete_bad_cast (this : access bad_cast);  -- /tools/x86_64/gnatpro2017/include/c++/6.2.1/typeinfo:194
      pragma Import (CPP, Delete_bad_cast, "_ZNSt8bad_castD1Ev");

      function what (this : access constant bad_cast) return Interfaces.C.Strings.chars_ptr;  -- /tools/x86_64/gnatpro2017/include/c++/6.2.1/typeinfo:197
      pragma Import (CPP, what, "_ZNKSt8bad_cast4whatEv");
   end;
   use Class_bad_cast;
   package Class_bad_typeid is
      type bad_typeid is limited new google.protobuf.binding.cpp_exception.Class_c_exception.c_exception with record
         null;
      end record;
      pragma Import (CPP, bad_typeid);

      function New_bad_typeid return bad_typeid;  -- /tools/x86_64/gnatpro2017/include/c++/6.2.1/typeinfo:207
      pragma CPP_Constructor (New_bad_typeid, "_ZNSt10bad_typeidC1Ev");

      procedure Delete_bad_typeid (this : access bad_typeid);  -- /tools/x86_64/gnatpro2017/include/c++/6.2.1/typeinfo:211
      pragma Import (CPP, Delete_bad_typeid, "_ZNSt10bad_typeidD1Ev");

      function what (this : access constant bad_typeid) return Interfaces.C.Strings.chars_ptr;  -- /tools/x86_64/gnatpro2017/include/c++/6.2.1/typeinfo:214
      pragma Import (CPP, what, "_ZNKSt10bad_typeid4whatEv");
   end;
   use Class_bad_typeid;
end google.protobuf.binding.cpp_typeinfo;
