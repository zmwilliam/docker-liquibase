## liquibase in docker

Docker image with Liquibase installation.

### Support for automation

Additionally the image has a set of scripts that help automating a few liquibase commands:
* _diffChangeLog_
* _update_
* _generateChangeLog_

The image comes with a preinstalled postgres jdbc driver.

Linked with a postgres database and provided with a volume, the container can be used
to automatically perform diff and update operations.

### setup and default behavior

The following is an example of the bare minimal to run a container instance. All other examples are an extension.

```bash
docker run -it \
--name ${LIQUIBASE_CONTAINER} \
--link ${REFERENCE_DB_CONTAINER}:db \
-e DATABASE_USERNAME="${DATABASE_USERNAME}" \
-e DATABASE_PASSWORD="${DATABASE_PASSWORD}" \
-e DATABASE_HOST="${DATABASE_HOST}" \
-e DATABASE_PORT="${DATABASE_PORT}" \
-e DATABASE_NAME="${DATABASE_NAME}" \
-v ${LIQUIBASE_CHANGELOGS}:/changelogs \
thematrimix/liquibase
```

or

```bash
docker run -it \
--name ${LIQUIBASE_CONTAINER} \
--link ${REFERENCE_DB_CONTAINER}:db \
-e DATABASE_USERNAME="${DATABASE_USERNAME}" \
-e DATABASE_PASSWORD="${DATABASE_PASSWORD}" \
-e DATABASE_URL="$DATABASE_URL" \
-v ${LIQUIBASE_CHANGELOGS}:/changelogs \
thematrimix/liquibase
```

In the shell you can perform the usual `liquibase` operations.

The variables should be set as follows:

LIQUIBASE_CONTAINER - the name the container will be given for easy referencing (optional)  
REFERENCE_DB_CONTAINER - linking to another container is generally optional as everything is setup to use a jdbc connection (optional)  
DATABASE_USERNAME - the username use to connect a running postgres database  
DATABASE_PASSWORD - the password use to connect a running postgres database  
DATABASE_HOST - the host/ip use to connect a running postgres database (optional if linking with a postgres container)  
DATABASE_PORT - the port use to connect a running postgres database (optional if linking with a postgres container)  
DATABASE_NAME - the database name use to connect a running postgres database (optional defaults to postgres)  
DATABASE_URL - the full connection string minus jdbc:postgresql:// (optional if HOST, PORT, NAME are provided as it will be built)  
LIQUIBASE_CHANGELOGS - volume on the host machine, where the changelogs reside  

#### diffChangeLog

Given diff is an extension to the basic please see "setup and default behavior" for a listing of variables as the following will only explain the new or different variables.

```bash
docker run -it \
--name ${LIQUIBASE_CONTAINER} \
--link ${REFERENCE_DB_CONTAINER}:db \
-e DATABASE_USERNAME="${DATABASE_USERNAME}" \
-e DATABASE_PASSWORD="${DATABASE_PASSWORD}" \
-e DATABASE_HOST="${DATABASE_HOST}" \
-e DATABASE_PORT="${DATABASE_PORT}" \
-e DATABASE_NAME="${DATABASE_NAME}" \
-v ${LIQUIBASE_CHANGELOGS}:/changelogs \
-e REFERENCE_URL="${REFERENCE_URL}" \
-e REFERENCE_USERNAME="${REFERENCE_USERNAME}" \
-e REFERENCE_PASSWORD="${REFERENCE_PASSWORD}" \
-e LIQUIBASE_INCLUSION_FILE="${LIQUIBASE_INCLUSION_FILE}" \
thematrimix/liquibase \
"diffChangeLog"
```

The variables should be set as follows:

REFERENCE_URL - the fully qualified connection to a target database  
REFERENCE_USERNAME - the user to the target database  
REFERENCE_PASSWORD - password to the target database  
LIQUIBASE_INCLUSION_FILE - changelog file name in the _changelogs_ folder, the generated diff file will be added as an include tag to it if provided (optional)  

By running the command above , you'll get on the volume:

1. a new changelog file with the diff results
2. the new changelog file included in the provided include-file


#### update

Given update is an extension to the basic please see "setup and default behavior" for a listing of variables as the following will only explain the new or different variables.

```bash
docker run -it \
--name ${LIQUIBASE_CONTAINER} \
--link ${REFERENCE_DB_CONTAINER}:db \
-e DATABASE_USERNAME="${DATABASE_USERNAME}" \
-e DATABASE_PASSWORD="${DATABASE_PASSWORD}" \
-e DATABASE_HOST="${DATABASE_HOST}" \
-e DATABASE_PORT="${DATABASE_PORT}" \
-e DATABASE_NAME="${DATABASE_NAME}" \
-v ${LIQUIBASE_CHANGELOGS}:/changelogs \
thematrimix/liquibase
"update"
```

#### generateChangeLog

Given generate is an extension to the basic please see "setup and default behavior" for a listing of variables as the following will only explain the new or different variables.

```bash
docker run -it \
--name ${LIQUIBASE_CONTAINER} \
--link ${REFERENCE_DB_CONTAINER}:db \
-e DATABASE_USERNAME="${DATABASE_USERNAME}" \
-e DATABASE_PASSWORD="${DATABASE_PASSWORD}" \
-e DATABASE_HOST="${DATABASE_HOST}" \
-e DATABASE_PORT="${DATABASE_PORT}" \
-e DATABASE_NAME="${DATABASE_NAME}" \
-v ${LIQUIBASE_CHANGELOGS}:/changelogs \
-e DB_SCHEMA_NAME=${DB_SCHEMA_NAME} \
-e DIFF_TYPES=${DIFF_TYPES} \
thematrimix/liquibase \
"generateChangeLog"
```

The variables should be set as follows:
 
SCHEMA_NAME - which schema to run against (optional)  
DIFF_TYPES - which diff type to use (optional)  

The following DIFF_TYPES options are available and can be passed as a comma-separated list:

* tables [DEFAULT]
* columns [DEFAULT]
* views [DEFAULT]
* primaryKeys [DEFAULT]
* indexes [DEFAULT]
* foreignKeys [DEFAULT]
* sequences [DEFAULT]
* data
