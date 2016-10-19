#!/usr/bin/env bash

DB_CONTAINER="some_postgresql_container"
LIQUIBASE_CHANGELOGS="$(pwd)/db/changelog"
LIQUIBASE_CHANGELOG_FILE="db.changelog.postgresql.sql"
DB_HOST="db"
DB_PORT="5432"
DB_NAME="some-db"
DB_USERNAME="username"
DB_PASSWORD="password"
DB_SCHEMA_NAME="public"

docker run -it \
  --rm \
  --name mlaccetti-liquibase \
  --link ${DB_CONTAINER}:db \
  -v ${LIQUIBASE_CHANGELOGS}:/changelogs \
  -e CHANGELOG_FILE=${LIQUIBASE_CHANGELOG_FILE} \
  -e DB_HOST=${DB_HOST} \
  -e DB_PORT=${DB_PORT} \
  -e DB_NAME=${DB_NAME} \
  -e DB_ENV_POSTGRES_USER=${DB_USERNAME} \
  -e DB_ENV_POSTGRES_PASSWORD=${DB_PASSWORD} \
  -e DB_SCHEMA_NAME=${DB_SCHEMA_NAME} \
  -e DIFF_TYPES=data \
  mlaccetti/liquibase \
  "generate"
