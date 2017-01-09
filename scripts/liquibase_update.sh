#!/bin/bash
: ${CHANGELOG_FILE:="changelogs.xml"}

echo "Applying changes to the database from changelog $CHANGELOG_FILE..."
liquibase --changeLogFile="$CHANGELOG_FILE" update

echo "Changes applied."
