#!/usr/bin/env bash
#
# Sub command
#
set -u
SUB_COMMAND_LIST="subcommand ${SUB_COMMAND_LIST}"

#
# usage
#
subcommand_usage() {
  cat <<EOF
Usage: subcommand [OPTIONS]

OPTIONS:

EOF
}

#
# main
#
subcommand() {
  subcommand_usage && exit
}
