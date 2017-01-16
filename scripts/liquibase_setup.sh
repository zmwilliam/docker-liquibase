#!/bin/bash

echo "Setting up liquibase..."
: ${DB_CONNECTION_USERNAME?"DB_CONNECTION_USERNAME not set"}
: ${DB_CONNECTION_PASSWORD?"DB_CONNECTION_PASSWORD not set"}

#Setting some defaults
: ${DB_CONNECTION_HOST:=$DB_PORT_5432_TCP_ADDR}
: ${DB_CONNECTION_PORT:=$DB_PORT_5432_TCP_PORT}
: ${DB_CONNECTION_NAME:=postgres}

cat <<CONF > /opt/liquibase/liquibase.properties
  driver: org.postgresql.Driver
  classpath:/opt/jdbc_drivers/postgresql.jar
  url: jdbc:postgresql://$DB_CONNECTION_HOST:$DB_CONNECTION_PORT/$DB_CONNECTION_NAME
  username: DB_CONNECTION_USERNAME
  password: DB_CONNECTION_PASSWORD
  logLevel: info
CONF

echo "Setup complete."
