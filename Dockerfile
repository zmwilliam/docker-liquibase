FROM openjdk:8-jre-alpine

LABEL maintainer="zmwilliam"

RUN apk add --update curl bash && \
    rm -rf /var/cache/apk/*

# Create a directory for liquibase
RUN mkdir -p /opt/liquibase /opt/jdbc_drivers

WORKDIR /opt/liquibase

ENV LIQUIBASE_VERSION 3.5.3

# Get liquibase
RUN curl -LS \
    https://github.com/liquibase/liquibase/releases/download/liquibase-parent-${LIQUIBASE_VERSION}/liquibase-${LIQUIBASE_VERSION}-bin.tar.gz \
    | tar -xz && \
    chmod +x /opt/liquibase/liquibase && \
    ln -s /opt/liquibase/liquibase /usr/local/bin/

ENV POSTGRESQL_VERSION 42.1.4

# Get the postgres JDBC driver
RUN curl -LS \
    https://search.maven.org/remotecontent?filepath=org/postgresql/postgresql/${POSTGRESQL_VERSION}/postgresql-${POSTGRESQL_VERSION}.jar \
    -o /opt/jdbc_drivers/postgresql.jar

# Add command scripts
ADD scripts /opt/liquibase/scripts
RUN chmod -R +x /opt/liquibase/scripts
RUN ln -s /opt/liquibase/scripts/liquibase_command /usr/local/bin/liquibasecmd

VOLUME /changelogs

ENTRYPOINT ["./scripts/liquibase_command.sh"]
