#!/usr/bin/env bash
#
# Sub command
#
set -u
SUB_COMMAND_LIST="subcommand2 ${SUB_COMMAND_LIST}"

#
# usage
#
subcommand2_usage() {
  cat <<EOF
Usage: subcommand2 [OPTIONS]

OPTIONS:

EOF
}

#
# main
#
subcommand2() {
  subcommand2_usage && exit
}
