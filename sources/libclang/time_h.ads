pragma Ada_2005;
pragma Style_Checks (Off);

with Interfaces.C; use Interfaces.C;
with bits_types_h;
with Interfaces.C.Strings;
with stddef_h;
with System;
with xlocale_h;

package time_h is

   TIME_UTC : constant := 1;  --  /usr/include/time.h:182

   subtype clock_t is bits_types_h.uu_clock_t;  -- /usr/include/time.h:59

   subtype time_t is bits_types_h.uu_time_t;  -- /usr/include/time.h:75

   subtype clockid_t is bits_types_h.uu_clockid_t;  -- /usr/include/time.h:91

   subtype timer_t is bits_types_h.uu_timer_t;  -- /usr/include/time.h:103

   type timespec is record
      tv_sec : aliased bits_types_h.uu_time_t;  -- /usr/include/time.h:122
      tv_nsec : aliased bits_types_h.uu_syscall_slong_t;  -- /usr/include/time.h:123
   end record;
   pragma Convention (C_Pass_By_Copy, timespec);  -- /usr/include/time.h:120

   type tm is record
      tm_sec : aliased int;  -- /usr/include/time.h:135
      tm_min : aliased int;  -- /usr/include/time.h:136
      tm_hour : aliased int;  -- /usr/include/time.h:137
      tm_mday : aliased int;  -- /usr/include/time.h:138
      tm_mon : aliased int;  -- /usr/include/time.h:139
      tm_year : aliased int;  -- /usr/include/time.h:140
      tm_wday : aliased int;  -- /usr/include/time.h:141
      tm_yday : aliased int;  -- /usr/include/time.h:142
      tm_isdst : aliased int;  -- /usr/include/time.h:143
      tm_gmtoff : aliased long;  -- /usr/include/time.h:146
      tm_zone : Interfaces.C.Strings.chars_ptr;  -- /usr/include/time.h:147
   end record;
   pragma Convention (C_Pass_By_Copy, tm);  -- /usr/include/time.h:133

   type itimerspec is record
      it_interval : aliased timespec;  -- /usr/include/time.h:163
      it_value : aliased timespec;  -- /usr/include/time.h:164
   end record;
   pragma Convention (C_Pass_By_Copy, itimerspec);  -- /usr/include/time.h:161

   --  skipped empty struct sigevent

   subtype pid_t is bits_types_h.uu_pid_t;  -- /usr/include/time.h:174

   function clock return clock_t;  -- /usr/include/time.h:189
   pragma Import (C, clock, "clock");

   function time (arg1 : access time_t) return time_t;  -- /usr/include/time.h:192
   pragma Import (C, time, "time");

   function difftime (arg1 : time_t; arg2 : time_t) return double;  -- /usr/include/time.h:195
   pragma Import (C, difftime, "difftime");

   function mktime (arg1 : access tm) return time_t;  -- /usr/include/time.h:199
   pragma Import (C, mktime, "mktime");

   function strftime
     (arg1 : Interfaces.C.Strings.chars_ptr;
      arg2 : stddef_h.size_t;
      arg3 : Interfaces.C.Strings.chars_ptr;
      arg4 : System.Address) return stddef_h.size_t;  -- /usr/include/time.h:205
   pragma Import (C, strftime, "strftime");

   function strftime_l
     (arg1 : Interfaces.C.Strings.chars_ptr;
      arg2 : stddef_h.size_t;
      arg3 : Interfaces.C.Strings.chars_ptr;
      arg4 : System.Address;
      arg5 : xlocale_h.uu_locale_t) return stddef_h.size_t;  -- /usr/include/time.h:223
   pragma Import (C, strftime_l, "strftime_l");

   function gmtime (arg1 : access time_t) return access tm;  -- /usr/include/time.h:239
   pragma Import (C, gmtime, "gmtime");

   function localtime (arg1 : access time_t) return access tm;  -- /usr/include/time.h:243
   pragma Import (C, localtime, "localtime");

   function gmtime_r (arg1 : access time_t; arg2 : access tm) return access tm;  -- /usr/include/time.h:249
   pragma Import (C, gmtime_r, "gmtime_r");

   function localtime_r (arg1 : access time_t; arg2 : access tm) return access tm;  -- /usr/include/time.h:254
   pragma Import (C, localtime_r, "localtime_r");

   function asctime (arg1 : System.Address) return Interfaces.C.Strings.chars_ptr;  -- /usr/include/time.h:261
   pragma Import (C, asctime, "asctime");

   function ctime (arg1 : access time_t) return Interfaces.C.Strings.chars_ptr;  -- /usr/include/time.h:264
   pragma Import (C, ctime, "ctime");

   function asctime_r (arg1 : System.Address; arg2 : Interfaces.C.Strings.chars_ptr) return Interfaces.C.Strings.chars_ptr;  -- /usr/include/time.h:272
   pragma Import (C, asctime_r, "asctime_r");

   function ctime_r (arg1 : access time_t; arg2 : Interfaces.C.Strings.chars_ptr) return Interfaces.C.Strings.chars_ptr;  -- /usr/include/time.h:276
   pragma Import (C, ctime_r, "ctime_r");

   tzname : array (0 .. 1) of Interfaces.C.Strings.chars_ptr;  -- /usr/include/time.h:289
   pragma Import (C, tzname, "tzname");

   procedure tzset;  -- /usr/include/time.h:293
   pragma Import (C, tzset, "tzset");

   daylight : aliased int;  -- /usr/include/time.h:297
   pragma Import (C, daylight, "daylight");

   timezone : aliased long;  -- /usr/include/time.h:298
   pragma Import (C, timezone, "timezone");

   function stime (arg1 : access time_t) return int;  -- /usr/include/time.h:304
   pragma Import (C, stime, "stime");

   function timegm (arg1 : access tm) return time_t;  -- /usr/include/time.h:319
   pragma Import (C, timegm, "timegm");

   function timelocal (arg1 : access tm) return time_t;  -- /usr/include/time.h:322
   pragma Import (C, timelocal, "timelocal");

   function dysize (arg1 : int) return int;  -- /usr/include/time.h:325
   pragma Import (C, dysize, "dysize");

   function nanosleep (arg1 : System.Address; arg2 : access timespec) return int;  -- /usr/include/time.h:334
   pragma Import (C, nanosleep, "nanosleep");

   function clock_getres (arg1 : clockid_t; arg2 : access timespec) return int;  -- /usr/include/time.h:339
   pragma Import (C, clock_getres, "clock_getres");

   function clock_gettime (arg1 : clockid_t; arg2 : access timespec) return int;  -- /usr/include/time.h:342
   pragma Import (C, clock_gettime, "clock_gettime");

   function clock_settime (arg1 : clockid_t; arg2 : System.Address) return int;  -- /usr/include/time.h:345
   pragma Import (C, clock_settime, "clock_settime");

   function clock_nanosleep
     (arg1 : clockid_t;
      arg2 : int;
      arg3 : System.Address;
      arg4 : access timespec) return int;  -- /usr/include/time.h:353
   pragma Import (C, clock_nanosleep, "clock_nanosleep");

   function clock_getcpuclockid (arg1 : pid_t; arg2 : access clockid_t) return int;  -- /usr/include/time.h:358
   pragma Import (C, clock_getcpuclockid, "clock_getcpuclockid");

   function timer_create
     (arg1 : clockid_t;
      arg2 : System.Address;
      arg3 : System.Address) return int;  -- /usr/include/time.h:363
   pragma Import (C, timer_create, "timer_create");

   function timer_delete (arg1 : timer_t) return int;  -- /usr/include/time.h:368
   pragma Import (C, timer_delete, "timer_delete");

   function timer_settime
     (arg1 : timer_t;
      arg2 : int;
      arg3 : System.Address;
      arg4 : access itimerspec) return int;  -- /usr/include/time.h:371
   pragma Import (C, timer_settime, "timer_settime");

   function timer_gettime (arg1 : timer_t; arg2 : access itimerspec) return int;  -- /usr/include/time.h:376
   pragma Import (C, timer_gettime, "timer_gettime");

   function timer_getoverrun (arg1 : timer_t) return int;  -- /usr/include/time.h:380
   pragma Import (C, timer_getoverrun, "timer_getoverrun");

   function timespec_get (arg1 : access timespec; arg2 : int) return int;  -- /usr/include/time.h:386
   pragma Import (C, timespec_get, "timespec_get");

end time_h;
