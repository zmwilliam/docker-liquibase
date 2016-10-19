@ECHO OFF

SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION

:: variables
PUSHD "%~dp0" >NUL && SET CWD=%CD% && POPD >NUL

SET DB_CONTAINER="some_postgresql_container"
SET LIQUIBASE_CHANGELOGS="%PWD%/db/changelog"
SET LIQUIBASE_CHANGELOG_FILE="db.changelog.postgresql.sql"
SET DB_HOST="db"
SET DB_PORT="5432"
SET DB_NAME="some-db"
SET DB_USERNAME="username"
SET DB_PASSWORD="password"
SET DB_SCHEMA_NAME="public"

docker run -it ^
  --rm ^
  --name mlaccetti-liquibase ^
  --link %DB_CONTAINER%:db ^
  -v %LIQUIBASE_CHANGELOGS%:/changelogs ^
  -e CHANGELOG_FILE=%LIQUIBASE_CHANGELOG_FILE% ^
  -e DB_HOST=%DB_HOST% ^
  -e DB_PORT=%DB_PORT% ^
  -e DB_NAME=%DB_NAME% ^
  -e DB_ENV_POSTGRES_USER=%DB_USERNAME% ^
  -e DB_ENV_POSTGRES_PASSWORD=%DB_PASSWORD% ^
  -e DB_SCHEMA_NAME=%DB_SCHEMA_NAME% ^
  -e DIFF_TYPES=data ^
  mlaccetti/liquibase ^
  "generate"
