#!/usr/bin/env bash
#
# Log
#

set -u

# progname: Output program's name
# ex)
#  progname="subcommand"
#
progname=${progname:-""}

# LOG_LEVEL
#   0: debug
#   1: info
#   2: warn
#   3: error
LOG_LEVEL=${LOG_LEVEL:-0}

# LOG_PATH: output path
LOG_PATH=${LOG_PATH:-""}

#
# Logger
#
# ex)
#  LOG_LEVEL=0
#  progname="myapps"
#  log_debug "debug message"
#
_datetime() { date +'%Y-%m-%d %H:%M:%S'; }
log_debug() { [ $LOG_LEVEL -le 0 ] && print_log "$(_datetime) [DEBUG]${progname:+" ${progname}:"} $@";  }
log_info()  { [ $LOG_LEVEL -le 1 ] && print_log "$(_datetime) [INFO]${progname:+" ${progname}:"} $@";  }
log_warn()  { [ $LOG_LEVEL -le 2 ] && print_log "$(_datetime) [WARN]${progname:+" ${progname}:"} $@";  }
log_error() { [ $LOG_LEVEL -le 3 ] && print_log "$(_datetime) [ERROR]${progname:+" ${progname}:"} $@"; }
print_log() { if [ -z $LOG_PATH ]; then echo "$@"; else echo "$@" >> $LOG_PATH; fi }
