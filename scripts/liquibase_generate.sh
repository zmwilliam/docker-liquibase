#!/bin/bash
: ${CHANGELOG_FILE:="changelog_diff.xml"}

TS=$(date +%s)
echo "Generating changelog..."
liquibase --diffTypes="$DIFF_TYPES" --defaultSchemaName="$DB_SCHEMA_NAME" --changeLogFile="$CHANGELOG_FILE-$TS" generateChangeLog

echo "Changelog generated into: $CHANGELOG_FILE-$TS."
