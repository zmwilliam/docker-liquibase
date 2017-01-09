#!/bin/bash -e

./scripts/liquibase_setup.sh

echo "Processing liquibase task..."
case "$1" in
    "diff" )
        ./scripts/liquibase_diff.sh
        ;;
    "update" )
        ./scripts/liquibase_update.sh
        ;;
    "generate" )
        ./scripts/liquibase_generate.sh
        ;;
esac
