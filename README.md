## liquibase in docker

Docker image with Liquibase installation.

### quickstart

Check out the `examples` folder for a sample of scripts for Windows/\*NIX that demonstrate the easiest way to get this up and running.

### Support for automation

Additionally the image has a set of scripts that help automating a few liquibase commands:
* _diff_
* _update_

The image comes with a preinstalled postgres jdbc driver.

Linked with a postgres database and provided with a volume, the container can be used
to automatically perform diff and update operations.

### setup and default behavior

The following is an example of the bare minimal to run a container instance. All other examples are an extension.

```bash
docker run -it \
--name $LIQUIBASE_CONTAINER \
--link $REFERENCE_DB_CONTAINER:db \
-e DB_CONNECTION_USERNAME="$DB_CONNECTION_USERNAME" \
-e DB_CONNECTION_PASSWORD="$DB_CONNECTION_PASSWORD" \
-e DB_CONNECTION_HOST="$DB_CONNECTION_HOST" \
-e DB_CONNECTION_PORT="$DB_CONNECTION_PORT" \
-e DB_CONNECTION_NAME="$DB_CONNECTION_NAME" \
-v /$LIQUIBASE_CHANGELOGS:/changelogs \
mlaccetti/liquibase
```

In the shell you can perform the usual `liquibase` operations.

The variables should be set as follows:

LIQUIBASE_CONTAINER - the name the container will be given for easy referencing (optional)  
REFERENCE_DB_CONTAINER - linking to another container is generally optional as everything is setup to use a jdbc connection (optional)  
DB_CONNECTION_USERNAME - the username use to connect a running postgres database  
DB_CONNECTION_PASSWORD - the password use to connect a running postgres database  
DB_CONNECTION_HOST - the host/ip use to connect a running postgres database (optional if linking with a postgres container)  
DB_CONNECTION_PORT - the port use to connect a running postgres database (optional if linking with a postgres container)  
DB_CONNECTION_NAME - the database name use to connect a running postgres database (optional defaults to postgres)  
LIQUIBASE_CHANGELOGS - volume on the host machine, where the changelogs reside  

#### diff

Given diff is an extension to the basic please see "setup and default behavior" for a listing of variables as the following will only explain the new or different variables.

```bash
docker run -it \
--name $LIQUIBASE_CONTAINER \
--link $REFERENCE_DB_CONTAINER:db \
-e DB_CONNECTION_USERNAME="$DB_CONNECTION_USERNAME" \
-e DB_CONNECTION_PASSWORD="$DB_CONNECTION_PASSWORD" \
-e DB_CONNECTION_HOST="$DB_CONNECTION_HOST" \
-e DB_CONNECTION_PORT="$DB_CONNECTION_PORT" \
-e DB_CONNECTION_NAME="$DB_CONNECTION_NAME" \
-v /$LIQUIBASE_CHANGELOGS:/changelogs \
-e CONNECTION_STRING="$CONNECTION_STRING" \
-e DB_USER="$DB_USER" \
-e DB_PASS="$DB_PASS" \
-e LIQUIBASE_INCLUSION_FILE="$LIQUIBASE_INCLUSION_FILE" \
mlaccetti/liquibase \
"diff"
```

The variables should be set as follows:

CONNECTION_STRING - the fully qualified conncetion to a target database  
DB_USER - the user to the target database  
DB_PASS - password to the target database  
LIQUIBASE_INCLUSION_FILE - changelog file name in the _changelogs_ folder, the generated diff file will be added as an include tag to it if provided (optional)  
LIQUIBASE_CHANGELOGS - volume on the host machine, where the generated file will be written  

By running the command above , you'll get on the volume:

1. a new changelog file with the diff results
2. the new changelog file included in the provided include-file


#### update

Given update is an extension to the basic please see "setup and default behavior" for a listing of variables as the following will only explain the new or different variables.

```bash
docker run -it \
--name $LIQUIBASE_CONTAINER \
--link $REFERENCE_DB_CONTAINER:db \
-e DB_CONNECTION_USERNAME="$DB_CONNECTION_USERNAME" \
-e DB_CONNECTION_PASSWORD="$DB_CONNECTION_PASSWORD" \
-e DB_CONNECTION_HOST="$DB_CONNECTION_HOST" \
-e DB_CONNECTION_PORT="$DB_CONNECTION_PORT" \
-e DB_CONNECTION_NAME="$DB_CONNECTION_NAME" \
-v /$LIQUIBASE_CHANGELOGS:/changelogs \
mlaccetti/liquibase\
"update"
```

#### generate

Given generate is an extension to the basic please see "setup and default behavior" for a listing of variables as the following will only explain the new or different variables.

```bash
docker run -it \
--name $LIQUIBASE_CONTAINER \
--link $REFERENCE_DB_CONTAINER:db \
-e DB_CONNECTION_USERNAME="$DB_CONNECTION_USERNAME" \
-e DB_CONNECTION_PASSWORD="$DB_CONNECTION_PASSWORD" \
-e DB_CONNECTION_HOST="$DB_CONNECTION_HOST" \
-e DB_CONNECTION_PORT="$DB_CONNECTION_PORT" \
-e DB_CONNECTION_NAME="$DB_CONNECTION_NAME" \
-v /$LIQUIBASE_CHANGELOGS:/changelogs \
-e DB_SCHEMA_NAME=$DB_SCHEMA_NAME \
-e DIFF_TYPES=data \
mlaccetti/liquibase \
"generate"
```

The variables should be set as follows:
 
SCHEMA_NAME - which schema to run against (optional)  
DIFF_TYPES(optional) - which diff type to use (optional)  
