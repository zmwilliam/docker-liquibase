#!/bin/bash
: ${CHANGELOG_FILE:="changelog_diff.xml"}

TS=$(date +%s)BASE_FILENAME=$(basename "$CHANGELOG_FILE")
DIR=$(dirname "$CHANGELOG_FILE")
FILE_EXT="${BASE_FILENAME##*.}"
FILE_NAME="${BASE_FILENAME%.*}"

echo "Generating changelog..."
liquibase --diffTypes="$DIFF_TYPES" --defaultSchemaName="$DB_SCHEMA_NAME" --changeLogFile="$DIR/$FILE_NAME-$TS.$FILE_EXT" generateChangeLog

echo "Changelog generated into: $CHANGELOG_FILE-$TS."
