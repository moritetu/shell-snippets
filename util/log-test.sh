#!/usr/bin/env bash

set -u

. log.sh

# easy report
report_result() {
  local exit_status=$?
  local target="$1"
  local error_message=${2:+": $2"}
  if test $exit_status -eq 0; then
    echo "[ok] $target"
  else
    echo "[fail] $target $error_message"
  fi
}

# some easy tests

progname="test-program"
echo "$(log_debug)" | grep "test-program" > /dev/null
report_result "progname" "'test-program' must be printed"

echo "$(log_debug)" | grep "debug" > /dev/null
report_result "log_debug # args are empty" "args must be empty"

echo "$(log_debug)" | grep -v "debug" > /dev/null
report_result "log_debug # args are empty" "args must be empty"

echo "$(log_debug "debug")" | grep "debug" > /dev/null
report_result "log_debug" "'debug' must be printed"

echo "$(log_info "info")" | grep "info" > /dev/null
report_result "log_info" "'info' must be printed"

echo "$(log_warn "warn")" | grep "warn" > /dev/null
report_result "log_warn" "'warn' must be printed"

echo "$(log_error "error")" | grep "error" > /dev/null
report_result "log_error" "'error' must be printed"

echo "$(print_log "print_log")" | grep "print_log" > /dev/null
report_result "print_log" "'print_log' must be printed"

LOG_PATH=test.log
test -e $LOG_PATH && rm $LOG_PATH
print_log "test"
report_result "print_log to $LOG_PATH" "'test' must be written into $LOG_PATH"
/bin/rm $LOG_PATH
LOG_PATH=

LOG_LEVEL=1
echo "$(log_debug "debug")" | grep -v "debug" > /dev/null
report_result "LOG_LEVEL=$LOG_LEVEL" "'debug' must not be printed on LOG_LEVEL=$LOG_LEVEL"

LOG_LEVEL=2
echo "$(log_info "info")" | grep -v "info" > /dev/null
report_result "LOG_LEVEL=$LOG_LEVEL" "'info' must not be printed on LOG_LEVEL=$LOG_LEVEL"

LOG_LEVEL=3
echo "$(log_warn "warn")" | grep -v "warn" > /dev/null
report_result "LOG_LEVEL=$LOG_LEVEL" "'warn' must not be printed on LOG_LEVEL=$LOG_LEVEL"

echo "$(log_error "error")" | grep  "error" > /dev/null
report_result "LOG_LEVEL=$LOG_LEVEL" "'error' must be printed on LOG_LEVEL=$LOG_LEVEL"
