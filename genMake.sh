#Makefile project generator
#
#Usage
#genMake.sh -t miniBMC -v 0.0.1 -m jones.developer@hotmail.com 
#-t [Title]
#-v [Version]
#-v [e-mail Address]
#
#All parameters are required

while getopts t:v:m: option
do
case "${option}"
in
t) TITLE=${OPTARG};;
v) VERSION=${OPTARG};;
m) EMAILADDR=${OPTARG};;

esac
done

mkdir -p $TITLE/src

echo "generate folers and main.c"
echo "#include <config.h>
#include <stdio.h>

int
main (void)
{
  puts (\"Hello World!\");
  puts (\"This is \" PACKAGE_STRING \" .\");
  return 0;
}" > $TITLE/src/main.c

echo "generate README"
echo "This is a demonstration package for GNU Automake.
Type 'info Automake' to read the Automake manual." > $TITLE/README

echo "generate Makefile.am for src"
echo "bin_PROGRAMS = hello
hello_SOURCES = main.c" > $TITLE/src/Makefile.am

echo "generate Makefile.am for $TITLE"
echo "SUBDIRS = src
dist_doc_DATA = README" > $TITLE/Makefile.am

echo "generate configure.ac for $TITLE"
echo "AC_INIT([$TITLE], [$VERSION], [$EMAILADDR])
AM_INIT_AUTOMAKE([-Wall -Werror foreign])
AC_PROG_CC
AC_CONFIG_HEADERS([config.h])
AC_CONFIG_FILES([
 Makefile
 src/Makefile
])
AC_OUTPUT" > $TITLE/configure.ac

echo "run autoreconf to build Makefile"
cd $TITLE
autoreconf --install
cd ..

echo ""
echo "To build:"
echo "cd $TITLE"
echo "./configure"
echo "make"

echo ""
echo "To make distribute:"
echo "cd $TITLE"
echo "make distcheck"


