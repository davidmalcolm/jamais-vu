jv (for "jamais-vu") is a tool for working with the output of
`DejaGnu <http://www.gnu.org/software/dejagnu/>`_.

jv implements various subcommands, rather like "git", "svn", "yum", etc,
using Python's `cmdln <https://pypi.python.org/pypi/cmdln>`_ package::

  $ ./jv
  Usage:
      jv COMMAND [ARGS...]
      jv help [COMMAND]

  Options:
      -h, --help  show this help message and exit

  Commands:
      compare        Compare a "before" run to an "after" run. Accepts a pair...
      dump           Print a dump of one or more .sum files, or directories, ...
      find           Locate a test, by name, in the given .sum files or direc...
      help (?)       give detailed help on a specific sub-command
      summarize      Print a short summary of one or more .sum files or direc...

jv is implemented in Python 3.

Summaries of .sum files
-----------------------
Summarizing an individual .sum file::

  $ ./jv summarize ../gcc-build-options/test/control/x86_64-unknown-linux-gnu/build/gcc/testsuite/gcc/gcc.sum
  ../gcc-build-options/test/control/x86_64-unknown-linux-gnu/build/gcc/testsuite/gcc/gcc.sum
  ------------------------------------------------------------------------------------------

   FAIL: 33 tests
   PASS: 107818 tests
   XFAIL: 263 tests
   XPASS: 40 tests
   UNSUPPORTED: 1801 tests

Summarizing a directory of .sum files::

  $ ./jv summarize testdata/test/control/
  testdata/test/control/build/gcc/testsuite/g++/g++.sum
  -----------------------------------------------------
  
   PASS: 58218 tests
   XFAIL: 292 tests
   UNSUPPORTED: 1024 tests
  
  testdata/test/control/build/gcc/testsuite/gcc/gcc.sum
  -----------------------------------------------------
  
   FAIL: 56 tests
   PASS: 99153 tests
   XFAIL: 248 tests
   XPASS: 2 tests
   UNSUPPORTED: 1638 tests
  
  testdata/test/control/build/gcc/testsuite/gfortran/gfortran.sum
  ---------------------------------------------------------------
  
   FAIL: 15458 tests
   PASS: 11246 tests
   XFAIL: 30 tests
   UNTESTED: 1752 tests
   UNRESOLVED: 53 tests
   UNSUPPORTED: 753 tests
  
  testdata/test/control/build/gcc/testsuite/objc/objc.sum
  -------------------------------------------------------
  
   FAIL: 984 tests
   PASS: 471 tests
   UNRESOLVED: 4 tests
   UNSUPPORTED: 98 tests
  
  testdata/test/control/build/x86_64-unknown-linux-gnu/boehm-gc/testsuite/boehm-gc.sum
  ------------------------------------------------------------------------------------
  
   PASS: 12 tests
   UNSUPPORTED: 1 tests
  
  testdata/test/control/build/x86_64-unknown-linux-gnu/libatomic/testsuite/libatomic.sum
  --------------------------------------------------------------------------------------
  
   PASS: 54 tests
  
  testdata/test/control/build/x86_64-unknown-linux-gnu/libffi/testsuite/libffi.sum
  --------------------------------------------------------------------------------
  
   PASS: 1801 tests
   UNSUPPORTED: 55 tests
  
  testdata/test/control/build/x86_64-unknown-linux-gnu/libgomp/testsuite/libgomp.sum
  ----------------------------------------------------------------------------------
  
   PASS: 621 tests
  
  testdata/test/control/build/x86_64-unknown-linux-gnu/libstdc++-v3/testsuite/libstdc++.sum
  -----------------------------------------------------------------------------------------
  
   FAIL: 1 tests
   PASS: 9792 tests
   XFAIL: 40 tests
   UNSUPPORTED: 222 tests


Dumps of .sum files
-------------------

Dumping the .sum files below a directory, grouping by result::

  $ ./jv dump testdata/test/control/
  testdata/test/control/build/gcc/testsuite/g++/g++.sum
  -----------------------------------------------------
  
   FAIL: 0 tests
   -------------
  
  
   PASS: 58218 tests
   -----------------
  
    ./array-1.H  -O2 (test for excess errors)
    ./array-1.H  -O2 -g (test for excess errors)
    ./array-1.H  -g (test for excess errors)
    ./empty.H  -O2 (test for excess errors)
    ./empty.H  -O2 -g (test for excess errors)
    ./empty.H  -g (test for excess errors)
    ./externc-1.H  -O2 (test for excess errors)
  (etc; snipped)

    
Comparisons
-----------
  
Comparing a before/after pair of GCC builds, where nothing changed::

  $ ./jv compare testdata/test/control/ testdata/test/experiment
  Comparing 9 common .sum files
  -----------------------------

   build/gcc/testsuite/g++/g++.sum : total: 59534 PASS: 58218 XFAIL: 292 UNSUPPORTED: 1024
   build/gcc/testsuite/gcc/gcc.sum : total: 101097 FAIL: 56 PASS: 99153 XFAIL: 248 XPASS: 2 UNSUPPORTED: 1638
   build/gcc/testsuite/gfortran/gfortran.sum : total: 29292 FAIL: 15458 PASS: 11246 XFAIL: 30 UNTESTED: 1752 UNRESOLVED: 53 UNSUPPORTED: 753
   build/gcc/testsuite/objc/objc.sum : total: 1557 FAIL: 984 PASS: 471 UNRESOLVED: 4 UNSUPPORTED: 98
   build/x86_64-unknown-linux-gnu/boehm-gc/testsuite/boehm-gc.sum : total: 13 PASS: 12 UNSUPPORTED: 1
   build/x86_64-unknown-linux-gnu/libatomic/testsuite/libatomic.sum : total: 54 PASS: 54
   build/x86_64-unknown-linux-gnu/libffi/testsuite/libffi.sum : total: 1856 PASS: 1801 UNSUPPORTED: 55
   build/x86_64-unknown-linux-gnu/libgomp/testsuite/libgomp.sum : total: 621 PASS: 621
   build/x86_64-unknown-linux-gnu/libstdc++-v3/testsuite/libstdc++.sum : total: 10055 FAIL: 1 PASS: 9792 XFAIL: 40 UNSUPPORTED: 222

  No differences found in 9 common .sum files

Comparing a before/after pair of GCC builds, where lots of things broke::

  $ ./jv compare \
       ../gcc-build-options/test/control/x86_64-unknown-linux-gnu/build \
       ../gcc-build-options/test/experiment/x86_64-unknown-linux-gnu/build
  sum files that went away: 11
  ----------------------------
  
   ../gcc-build-options/test/control/x86_64-unknown-linux-gnu/build/gcc/testsuite/gfortran/gfortran.sum
   ----------------------------------------------------------------------------------------------------
  
    PASS: 45505 tests
    XFAIL: 52 tests
    UNSUPPORTED: 65 tests
  
   ../gcc-build-options/test/control/x86_64-unknown-linux-gnu/build/gcc/testsuite/go/go.sum
   ----------------------------------------------------------------------------------------
  
    PASS: 7258 tests
    XFAIL: 1 tests
    UNTESTED: 6 tests
    UNSUPPORTED: 1 tests
  
   ../gcc-build-options/test/control/x86_64-unknown-linux-gnu/build/gcc/testsuite/objc/objc.sum
   --------------------------------------------------------------------------------------------
  
    PASS: 2893 tests
    XFAIL: 6 tests
    UNSUPPORTED: 74 tests
  
   ../gcc-build-options/test/control/x86_64-unknown-linux-gnu/build/x86_64-unknown-linux-gnu/boehm-gc/testsuite/boehm-gc.sum
   -------------------------------------------------------------------------------------------------------------------------
  
    PASS: 12 tests
    UNSUPPORTED: 1 tests
  
   ../gcc-build-options/test/control/x86_64-unknown-linux-gnu/build/x86_64-unknown-linux-gnu/libatomic/testsuite/libatomic.sum
   ---------------------------------------------------------------------------------------------------------------------------
  
    PASS: 54 tests
  
   ../gcc-build-options/test/control/x86_64-unknown-linux-gnu/build/x86_64-unknown-linux-gnu/libffi/testsuite/libffi.sum
   ---------------------------------------------------------------------------------------------------------------------
  
    PASS: 1801 tests
    UNSUPPORTED: 55 tests
  
   ../gcc-build-options/test/control/x86_64-unknown-linux-gnu/build/x86_64-unknown-linux-gnu/libgo/libgo.sum
   ---------------------------------------------------------------------------------------------------------
  
    PASS: 122 tests
  
   ../gcc-build-options/test/control/x86_64-unknown-linux-gnu/build/x86_64-unknown-linux-gnu/libgomp/testsuite/libgomp.sum
   -----------------------------------------------------------------------------------------------------------------------
  
    PASS: 2394 tests
  
   ../gcc-build-options/test/control/x86_64-unknown-linux-gnu/build/x86_64-unknown-linux-gnu/libitm/testsuite/libitm.sum
   ---------------------------------------------------------------------------------------------------------------------
  
    PASS: 26 tests
    XFAIL: 3 tests
    UNSUPPORTED: 1 tests
  
   ../gcc-build-options/test/control/x86_64-unknown-linux-gnu/build/x86_64-unknown-linux-gnu/libjava/testsuite/libjava.sum
   -----------------------------------------------------------------------------------------------------------------------
  
    PASS: 2582 tests
    XFAIL: 4 tests
  
   ../gcc-build-options/test/control/x86_64-unknown-linux-gnu/build/x86_64-unknown-linux-gnu/libstdc++-v3/testsuite/libstdc++.sum
   ------------------------------------------------------------------------------------------------------------------------------
  
    PASS: 9987 tests
    XFAIL: 41 tests
    UNSUPPORTED: 222 tests
  
  
  Comparing 4 common .sum files
  -----------------------------
  
   gcc/testsuite/ada/acats/acats.sum : total: 2320->0 (-2320) PASS: 2320->0 (-2320)
   gcc/testsuite/g++/g++.sum : total: 89697->78686 (-11011) FAIL: 3->63613 (+63610) PASS: 86259->1484 (-84775) XFAIL: 439->287 (-152) XPASS: 0->119 (+119) UNRESOLVED: 0->9645 (+9645) UNSUPPORTED: 2996->3623 (+627)
   gcc/testsuite/gcc/gcc.sum : total: 109955->92609 (-17346) FAIL: 33->61520 (+61487) PASS: 107818->1157 (-106661) XFAIL: 263->33 (-230) XPASS: 40->20 (-20) UNRESOLVED: 0->25568 (+25568) UNSUPPORTED: 1801->4469 (+2668)
   gcc/testsuite/gnat/gnat.sum : total: 1244->1243 (-1) FAIL: 0->66 (+66) PASS: 1223->785 (-438) XFAIL: 18->0 (-18) XPASS: 0->18 (+18) UNRESOLVED: 0->370 (+370) UNSUPPORTED: 3->4 (+1)
  
  Tests that went away in gcc/testsuite/g++/g++.sum: 20615
  --------------------------------------------------------
  
   PASS: c-c++-common/Wconversion-real.c -std=gnu++11  (test for warnings, line 23)
   PASS: c-c++-common/Wconversion-real.c -std=gnu++11  (test for warnings, line 24)
   PASS: c-c++-common/Wconversion-real.c -std=gnu++11  (test for warnings, line 25)
  (etc; snipped)


Locating specific tests
-----------------------
The "find" subcommand will search for tests by name within .sum files
or directories, looking for a match with the given substring.

If a test is located in a .sum file, jv will also look for the
test in the corresponding .log file.

The output contains the filename and line number, e.g. for easy navigation
to the pertinent lines of the log file from Emacs.  This may help with
determining how to reproduce a particular result.

The exit code is the total number of matches found (within both .sum and
.log files).

Example::

  ./jv find "c-c++-common/asan/attrib-1.c  -O0   (test for warnings, line 58)" testdata/test
  testdata/test/control/build/gcc/testsuite/g++/g++.sum:11: PASS: c-c++-common/asan/attrib-1.c  -O0   (test for warnings, line 58)
  testdata/test/control/build/gcc/testsuite/g++/g++.log:34: PASS: c-c++-common/asan/attrib-1.c  -O0   (test for warnings, line 58)
  testdata/test/control/build/gcc/testsuite/gcc/gcc.sum:41766: PASS: c-c++-common/asan/attrib-1.c  -O0   (test for warnings, line 58)
  testdata/test/control/build/gcc/testsuite/gcc/gcc.log:123253: PASS: c-c++-common/asan/attrib-1.c  -O0   (test for warnings, line 58)
  testdata/test/experiment/build/gcc/testsuite/g++/g++.sum:11: PASS: c-c++-common/asan/attrib-1.c  -O0   (test for warnings, line 58)
  testdata/test/experiment/build/gcc/testsuite/g++/g++.log:34: PASS: c-c++-common/asan/attrib-1.c  -O0   (test for warnings, line 58)
  testdata/test/experiment/build/gcc/testsuite/gcc/gcc.sum:41766: PASS: c-c++-common/asan/attrib-1.c  -O0   (test for warnings, line 58)
  testdata/test/experiment/build/gcc/testsuite/gcc/gcc.log:123253: PASS: c-c++-common/asan/attrib-1.c  -O0   (test for warnings, line 58)
