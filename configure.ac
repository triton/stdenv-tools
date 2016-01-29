#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

# Autoconf
AC_PREREQ([2.64])
AC_INIT([stdenv-tools], [0.0.0], [https://github.com/triton/stdenv-tools], [stdenv-tools], [william@wkennington.com])

AC_CONFIG_HEADERS([config])
AC_CONFIG_MACRO_DIR([m4])
AC_CONFIG_AUX_DIR([build-aux])

AM_INIT_AUTOMAKE([1.11 foreign dist-xz no-dist-gzip parallel-tests subdir-objects silent-rules tar-ustar])
AM_SILENT_RULES([yes])

LT_PREREQ([2.2])
LT_INIT

AC_PROG_CXX
AC_PROG_CXX_C_O
AX_CXX_COMPILE_STDCXX_11(, mandatory)
AC_LANG([C++])

PKG_PROG_PKG_CONFIG

PKG_CHECK_MODULES([rapidjson], RapidJSON >= 1.0.0)
saved_CFLAGS="$CFLAGS"
CFLAGS="$rapidjson_CFLAGS"
AC_CHECK_HEADER(
  [rapidjson/reader.h],
  [true],
  [AC_MSG_FAILURE([rapidjson/reader.h not found])],
)
CFLAGS="$saved_CFLAGS"

AC_CHECK_HEADER(
  [libpkgconf/libpkgconf.h],
  [true],
  [AC_MSG_FAILURE([libpkgconf/libpkgconf.h not found])],
)
AC_CHECK_LIB(
  [pkgconf],
  [pkgconf_pkg_find],
  [AC_SUBST([PKGCONF_LIBS], [-lpkgconf])],
  [AC_MSG_FAILURE([pkgconf not found])]
)

AC_CONFIG_FILES([
  Makefile
  src/Makefile
  test/Makefile
])
AC_OUTPUT
