#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

: ${CHANGELOG_FILE:="changelogs.xml"}

echo "Applying changes to the database from changelog ${CHANGELOG_FILE}..."
liquibase --changeLogFile="${CHANGELOG_FILE}" --defaultsFile=/opt/liquibase/liquibase.properties update $@

echo "Changes applied."
