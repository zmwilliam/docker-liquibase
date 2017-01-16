#!/usr/bin/env bash

CONTAINER_NAME="mlaccetti-liquibase"
REFERENCE_DB_CONTAINER="some_postgresql_container"
LIQUIBASE_CHANGELOGS="$(pwd)/db/changelog"
LIQUIBASE_CHANGELOG_FILE="db.changelog.postgresql.sql"
DB_CONNECTION_USERNAME="username"
DB_CONNECTION_PASSWORD="password"
DB_CONNECTION_HOST="db"
DB_CONNECTION_PORT="5432"
DB_CONNECTION_NAME="some-db"
DB_SCHEMA_NAME="public"
DIFF_TYPES="data"

docker run -it --rm \
  --name ${CONTAINER_NAME} \
  --link ${REFERENCE_DB_CONTAINER}:db \
  -e DB_CONNECTION_USERNAME="${DB_CONNECTION_USERNAME}" \
  -e DB_CONNECTION_PASSWORD="${DB_CONNECTION_PASSWORD}" \
  -e DB_CONNECTION_HOST="${DB_CONNECTION_HOST}" \
  -e DB_CONNECTION_PORT="${DB_CONNECTION_PORT}" \
  -e DB_CONNECTION_NAME="${DB_CONNECTION_NAME}" \
  -v /${LIQUIBASE_CHANGELOGS}:/changelogs \
  -e DB_SCHEMA_NAME=${DB_SCHEMA_NAME} \
  -e DIFF_TYPES=${DIFF_TYPES} \
  mlaccetti/liquibase \
  "generate"
