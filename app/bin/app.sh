#!/usr/bin/env bash
#
# App
#
set -u
here=$(cd -P -- "$(dirname -- ${BASH_SOURCE:-$0})" && pwd -P)
progname="$(basename -- ${BASH_SOURCE:-$0})"

# Loads setting
. ${here}/../conf/config.sh

SUB_COMMAND=""
SUB_COMMAND_LIST=""

usage() {
  cat<<EOF
Usage: $progname command [<command parameters>]

Commands:
EOF
  for com in $SUB_COMMAND_LIST; do
    echo "  $com"
  done

  cat<<EOF 

For more detail, execute the following command:
  $progname <subcommand> --help

EOF
}

# Loads sub commands.
log_debug "==> load subcommand"
for sub_command in `ls $here/command/*.sh`; do
  log_debug "load: $sub_command"
  . $sub_command
done

if [ $# -eq 0 ] || [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
  usage && exit
fi

SUB_COMMAND="$1"

# Detects called function.
CALL_FUNC=""
for com in $SUB_COMMAND_LIST; do
  if [ "$com" = "$SUB_COMMAND" ]; then
    log_debug "found sub command: $com"
    CALL_FUNC=$com
    break
  fi
done

if [ "$CALL_FUNC" = "" ]; then
  log_error "invalid command: '$SUB_COMMAND'"
  exit 1
else
  log_debug "==> call function $CALL_FUNC"
  $CALL_FUNC "$@"
fi
