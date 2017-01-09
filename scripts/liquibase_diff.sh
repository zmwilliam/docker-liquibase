#!/bin/bash
: ${CHANGELOG_FILE:="changelog_diff.xml"}
: ${CONNECTION_STRING? "please provide the connection string of the base database"}
: ${DB_USER?"Please provide the database user name"}
: ${DB_PASS?"Please provide the database password"}

TS=$(date +%s)
BASE_FILENAME=$(basename "$CHANGELOG_FILE")
DIR=$(dirname "$CHANGELOG_FILE")
FILE_EXT="${BASE_FILENAME##*.}"
FILE_NAME="${BASE_FILENAME%.*}"

echo "Generating diff..."
liquibase --changeLogFile="$DIR/$TS-$FILE_NAME.$FILE_EXT" diffChangeLog \
  --referenceUrl=$CONNECTION_STRING \
  --referenceUsername=$DB_USER \
  --referencePassword=$DB_PASS

echo "Diff generated into $DIR/$TS-$FILE_NAME.$FILE_EXT."

if [ ! -z "$LIQUIBASE_INCLUSION_FILE" ] ; then
  if [ -f "$LIQUIBASE_INCLUSION_FILE" ] ; then
    echo "Include newly generated file into the list of changesets";
    sed -i "
      /<\/databaseChangeLog>/ i\
      <include relativeToChangelogFile='true' file=\"$DIR/$TS-$FILE_NAME.$FILE_EXT\" />" "$LIQUIBASE_INCLUSION_FILE"
  else
    echo "Liquibase include file doesn't exist: $LIQUIBASE_INCLUSION_FILE"
  fi
else
    echo "Inclusion file not provided."
fi
