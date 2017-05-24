pragma Ada_2005;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with google.protobuf.binding.x86_64_linux_gnu_bits_types_h;

package google.protobuf.binding.x86_64_linux_gnu_sys_types_h is

   subtype u_char is google.protobuf.binding.x86_64_linux_gnu_bits_types_h.uu_u_char;  -- /usr/include/x86_64-linux-gnu/sys/types.h:33

   subtype u_short is google.protobuf.binding.x86_64_linux_gnu_bits_types_h.uu_u_short;  -- /usr/include/x86_64-linux-gnu/sys/types.h:34

   subtype u_int is google.protobuf.binding.x86_64_linux_gnu_bits_types_h.uu_u_int;  -- /usr/include/x86_64-linux-gnu/sys/types.h:35

   subtype u_long is google.protobuf.binding.x86_64_linux_gnu_bits_types_h.uu_u_long;  -- /usr/include/x86_64-linux-gnu/sys/types.h:36

   subtype quad_t is google.protobuf.binding.x86_64_linux_gnu_bits_types_h.uu_quad_t;  -- /usr/include/x86_64-linux-gnu/sys/types.h:37

   subtype u_quad_t is google.protobuf.binding.x86_64_linux_gnu_bits_types_h.uu_u_quad_t;  -- /usr/include/x86_64-linux-gnu/sys/types.h:38

   subtype fsid_t is google.protobuf.binding.x86_64_linux_gnu_bits_types_h.uu_fsid_t;  -- /usr/include/x86_64-linux-gnu/sys/types.h:39

   subtype loff_t is google.protobuf.binding.x86_64_linux_gnu_bits_types_h.uu_loff_t;  -- /usr/include/x86_64-linux-gnu/sys/types.h:44

   subtype ino_t is google.protobuf.binding.x86_64_linux_gnu_bits_types_h.uu_ino_t;  -- /usr/include/x86_64-linux-gnu/sys/types.h:48

   subtype ino64_t is google.protobuf.binding.x86_64_linux_gnu_bits_types_h.uu_ino64_t;  -- /usr/include/x86_64-linux-gnu/sys/types.h:55

   subtype dev_t is google.protobuf.binding.x86_64_linux_gnu_bits_types_h.uu_dev_t;  -- /usr/include/x86_64-linux-gnu/sys/types.h:60

   subtype gid_t is google.protobuf.binding.x86_64_linux_gnu_bits_types_h.uu_gid_t;  -- /usr/include/x86_64-linux-gnu/sys/types.h:65

   subtype mode_t is google.protobuf.binding.x86_64_linux_gnu_bits_types_h.uu_mode_t;  -- /usr/include/x86_64-linux-gnu/sys/types.h:70

   subtype nlink_t is google.protobuf.binding.x86_64_linux_gnu_bits_types_h.uu_nlink_t;  -- /usr/include/x86_64-linux-gnu/sys/types.h:75

   subtype uid_t is google.protobuf.binding.x86_64_linux_gnu_bits_types_h.uu_uid_t;  -- /usr/include/x86_64-linux-gnu/sys/types.h:80

   subtype off_t is google.protobuf.binding.x86_64_linux_gnu_bits_types_h.uu_off_t;  -- /usr/include/x86_64-linux-gnu/sys/types.h:86

   subtype off64_t is google.protobuf.binding.x86_64_linux_gnu_bits_types_h.uu_off64_t;  -- /usr/include/x86_64-linux-gnu/sys/types.h:93

   subtype pid_t is google.protobuf.binding.x86_64_linux_gnu_bits_types_h.uu_pid_t;  -- /usr/include/x86_64-linux-gnu/sys/types.h:98

   subtype id_t is google.protobuf.binding.x86_64_linux_gnu_bits_types_h.uu_id_t;  -- /usr/include/x86_64-linux-gnu/sys/types.h:104

   subtype ssize_t is google.protobuf.binding.x86_64_linux_gnu_bits_types_h.uu_ssize_t;  -- /usr/include/x86_64-linux-gnu/sys/types.h:109

   subtype daddr_t is google.protobuf.binding.x86_64_linux_gnu_bits_types_h.uu_daddr_t;  -- /usr/include/x86_64-linux-gnu/sys/types.h:115

   subtype caddr_t is google.protobuf.binding.x86_64_linux_gnu_bits_types_h.uu_caddr_t;  -- /usr/include/x86_64-linux-gnu/sys/types.h:116

   subtype key_t is google.protobuf.binding.x86_64_linux_gnu_bits_types_h.uu_key_t;  -- /usr/include/x86_64-linux-gnu/sys/types.h:122

   subtype useconds_t is google.protobuf.binding.x86_64_linux_gnu_bits_types_h.uu_useconds_t;  -- /usr/include/x86_64-linux-gnu/sys/types.h:136

   subtype suseconds_t is google.protobuf.binding.x86_64_linux_gnu_bits_types_h.uu_suseconds_t;  -- /usr/include/x86_64-linux-gnu/sys/types.h:140

   subtype ulong is unsigned_long;  -- /usr/include/x86_64-linux-gnu/sys/types.h:150

   subtype ushort is unsigned_short;  -- /usr/include/x86_64-linux-gnu/sys/types.h:151

   subtype uint is unsigned;  -- /usr/include/x86_64-linux-gnu/sys/types.h:152

   subtype int8_t is signed_char;  -- /usr/include/x86_64-linux-gnu/sys/types.h:194

   subtype int16_t is short;  -- /usr/include/x86_64-linux-gnu/sys/types.h:195

   subtype int32_t is int;  -- /usr/include/x86_64-linux-gnu/sys/types.h:196

   subtype int64_t is long;  -- /usr/include/x86_64-linux-gnu/sys/types.h:197

   subtype u_int8_t is unsigned_char;  -- /usr/include/x86_64-linux-gnu/sys/types.h:200

   subtype u_int16_t is unsigned_short;  -- /usr/include/x86_64-linux-gnu/sys/types.h:201

   subtype u_int32_t is unsigned;  -- /usr/include/x86_64-linux-gnu/sys/types.h:202

   subtype u_int64_t is unsigned_long;  -- /usr/include/x86_64-linux-gnu/sys/types.h:203

   subtype register_t is long;  -- /usr/include/x86_64-linux-gnu/sys/types.h:205

   subtype blksize_t is google.protobuf.binding.x86_64_linux_gnu_bits_types_h.uu_blksize_t;  -- /usr/include/x86_64-linux-gnu/sys/types.h:228

   subtype blkcnt_t is google.protobuf.binding.x86_64_linux_gnu_bits_types_h.uu_blkcnt_t;  -- /usr/include/x86_64-linux-gnu/sys/types.h:235

   subtype fsblkcnt_t is google.protobuf.binding.x86_64_linux_gnu_bits_types_h.uu_fsblkcnt_t;  -- /usr/include/x86_64-linux-gnu/sys/types.h:239

   subtype fsfilcnt_t is google.protobuf.binding.x86_64_linux_gnu_bits_types_h.uu_fsfilcnt_t;  -- /usr/include/x86_64-linux-gnu/sys/types.h:243

   subtype blkcnt64_t is google.protobuf.binding.x86_64_linux_gnu_bits_types_h.uu_blkcnt64_t;  -- /usr/include/x86_64-linux-gnu/sys/types.h:262

   subtype fsblkcnt64_t is google.protobuf.binding.x86_64_linux_gnu_bits_types_h.uu_fsblkcnt64_t;  -- /usr/include/x86_64-linux-gnu/sys/types.h:263

   subtype fsfilcnt64_t is google.protobuf.binding.x86_64_linux_gnu_bits_types_h.uu_fsfilcnt64_t;  -- /usr/include/x86_64-linux-gnu/sys/types.h:264

end google.protobuf.binding.x86_64_linux_gnu_sys_types_h;
