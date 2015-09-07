#!/usr/bin/env bash
#
# Configuration
#
set -u

load_config() {
  export APP_ROOT=$here/..
  APP_ENV=${APP_ENV:-"development"}
  . $APP_ROOT/conf/environment/${APP_ENV}.sh

  . $APP_ROOT/../util/log.sh
}

load_config
