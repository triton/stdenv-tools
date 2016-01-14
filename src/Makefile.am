lib_LTLIBRARIES = libstdenv-tools.la
include_HEADERS = common/pkgconf.hxx
bin_PROGRAMS = bin/absolute-include bin/absolute-libtool bin/absolute-pkgconfig

libstdenv_tools_la_SOURCES = common/pkgconf.cxx

bin_absolute_include_SOURCES = absolute-include/main.cxx
bin_absolute_include_LDADD = libstdenv-tools.la

bin_absolute_libtool_SOURCES = absolute-libtool/main.cxx
bin_absolute_libtool_LDADD = libstdenv-tools.la

bin_absolute_pkgconfig_SOURCES = absolute-pkgconfig/main.cxx
bin_absolute_pkgconfig_LDADD = libstdenv-tools.la
