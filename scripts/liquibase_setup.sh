#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

echo "Setting up liquibase..."
: ${DATABASE_USERNAME?"ERROR > DATABASE_USERNAME is not set"}
: ${DATABASE_PASSWORD?"ERROR > DATABASE_PASSWORD is not set"}

echo "Setting some defaults..."
: ${DATABASE_HOST:="${DB_PORT_5432_TCP_ADDR}"}
: ${DATABASE_PORT:="${DB_PORT_5432_TCP_PORT}"}
: ${DATABASE_NAME:="postgres"}
: ${DATABASE_URL:="${DATABASE_HOST}:${DATABASE_PORT}/${DATABASE_NAME}"}

cat <<CONF > /opt/liquibase/liquibase.properties
  driver: org.postgresql.Driver
  classpath:/opt/jdbc_drivers/postgresql.jar
  url: jdbc:postgresql://${DATABASE_URL}
  username: ${DATABASE_USERNAME}
  password: ${DATABASE_PASSWORD}
  logLevel: debug
CONF

echo "Setup complete."
