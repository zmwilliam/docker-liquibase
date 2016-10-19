#!/bin/bash
echo "Setting up liquibase ...."
: ${DB_ENV_POSTGRES_USER?"DB_ENV_POSTGRES_USER not set"}
: ${DB_ENV_POSTGRES_PASSWORD?"DB_ENV_POSTGRES_PASSWORD not set"}

cat <<CONF > /opt/liquibase/liquibase.properties
  driver: org.postgresql.Driver
  classpath:/opt/jdbc_drivers/postgresql.jar
  url: jdbc:postgresql://$DB_HOST:$DB_PORT/$DB_NAME
  username: $DB_ENV_POSTGRES_USER
  password: $DB_ENV_POSTGRES_PASSWORD
  logLevel: info
CONF

echo "Setup complete ...."
