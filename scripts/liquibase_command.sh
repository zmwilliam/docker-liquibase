#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

./scripts/liquibase_setup.sh

echo "Processing liquibase task..."
case "$1" in
    "diffChangeLog" ) ./scripts/liquibase_diff_change_log.sh $@ ;;
    "update" ) ./scripts/liquibase_update.sh $@ ;;
    "generateChangeLog" ) ./scripts/liquibase_generate_change_log.sh $@ ;;
    * ) exec "$@" ;;
esac
