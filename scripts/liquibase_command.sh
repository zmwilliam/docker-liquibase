#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

liquibase_setup.sh

echo "Processing liquibase task..."
case "$1" in
    "diffChangeLog" ) liquibase_diff_change_log.sh $@ ;;
    "update" ) liquibase_update.sh $@ ;;
    "generateChangeLog" ) liquibase_generate_change_log.sh $@ ;;
    * ) exec "$@" ;;
esac
