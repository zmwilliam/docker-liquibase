#!/bin/bash
: ${CHANGELOG_FILE:="changelog_diff.xml"}
: ${CONNECTION_STRING? "please provide the connection string of the base database"}
: ${DB_USER?"Please provide the database user name"}
: ${DB_PASS?"Please provide the database password"}

TS=$(date +%s)
echo "Generating diff..."
liquibase --changeLogFile="$CHANGELOG_FILE-$TS" diffChangeLog \
  --referenceUrl=$CONNECTION_STRING \
  --referenceUsername=$DB_USER \
  --referencePassword=$DB_PASS

echo "Diff generated into $CHANGELOG_FILE-$TS."

if [ ! -z "$LIQUIBASE_INCLUSION_FILE" ] ; then
  if [ -f "$LIQUIBASE_INCLUSION_FILE" ] ; then
    echo "Include newly generated file into the list of changesets";
    sed -i "
      /<\/databaseChangeLog>/ i\
      <include relativeToChangelogFile='true' file=\"$CHANGELOG_FILE-$TS\" />" "$LIQUIBASE_INCLUSION_FILE"
  else
    echo "Liquibase include file doesn't exist: $LIQUIBASE_INCLUSION_FILE"
  fi
else
    echo "Inclusion file not provided."
fi
