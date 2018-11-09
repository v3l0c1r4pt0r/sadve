#!/bin/sh
# SADVE - extract #define value from CLI

# do not tolerate any error
set -e

PROGNAME="$0"

# parse options
TEMP=$(getopt -o 't:dsh' --long 'dec,hex,type:,define,sizeof,help' -n "$0" -- "$@")
if [ $? -ne 0 ]; then
  exit 1
fi

eval set -- "$TEMP"
unset TEMP

while true; do
  case "$1" in
    '-t'|'--type')
      TYPE="$2"
      shift 2
      continue
      ;;
    '--hex')
      TYPE="x"
      shift
      continue
      ;;
    '--dec')
      TYPE="d"
      shift
      continue
      ;;
    '-d'|'--define')
      MODE="define"
      shift
      continue
      ;;
    '-s'|'--sizeof')
      MODE="sizeof"
      shift
      continue
      ;;
    '-h'|'--help')
      cat <<EOF
Usage: $PROGNAME -d|-s SYMBOL HEADER | -h
        -d, --define  Print final value of preprocessor macro
        -s, --sizeof  Print total length of type/struct
            --dec     Print value in decimal form (default)
            --hex     Print value in hexadecimal form
            --type=T  Print value in T form, where T is format string as in
                      printf(3)
        -h, --help    Print this help message and exit
        SYMBOL        Symbol which value is to be examined
        HEADER        Header where symbol is defined
EOF
      exit 0
      ;;
    '--')
      shift
      break
      ;;
    *)
      echo 'Internal error!' >&2
      exit 1
      ;;
  esac
done

# save script location and generate build directory (if not exists)
SCRIPT_DIR="$(pwd)/in/$MODE"
BUILD_DIR="$HOME/.cache/sadve/$MODE"

# out-of-source build
mkdir -p $BUILD_DIR
cd $BUILD_DIR

# prepare vars to fill template
export OUTPUT_INCLUDE="$2"
export OUTPUT_SYMBOL="$1"
export OUTPUT_TYPE="$TYPE"

# build
cmake $SCRIPT_DIR >>$BUILD_DIR/user.log
make >>$BUILD_DIR/user.log

# run program
make run | awk '/BEGIN/{flag=1;next}/END/{flag=0}flag'

# cleanup
cd - &>/dev/null
