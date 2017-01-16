FROM openjdk:8-jdk-alpine

MAINTAINER Michael Laccetti <michael@laccetti.com> (https://laccetti.com/)

RUN apk add --update curl bash && \
  rm -rf /var/cache/apk/*

# Create a directory for liquibase
RUN mkdir -p /opt/liquibase /opt/jdbc_drivers

WORKDIR /opt/liquibase

# Grab liquibase
RUN curl -LS \
    https://github.com/liquibase/liquibase/releases/download/liquibase-parent-3.5.3/liquibase-3.5.3-bin.tar.gz \
    | tar -xz && \
    chmod +x /opt/liquibase/liquibase && \
    ln -s /opt/liquibase/liquibase /usr/local/bin/

# Get the postgres JDBC driver
RUN curl -LS \
    https://search.maven.org/remotecontent?filepath=org/postgresql/postgresql/9.4.1211/postgresql-9.4.1211.jar \
    -o /opt/jdbc_drivers/postgresql.jar

# Add command scripts
ADD scripts /opt/liquibase/scripts
RUN chmod -R +x /opt/liquibase/scripts

VOLUME /changelogs

ENTRYPOINT ["./scripts/liquibase_command.sh"]
