FROM maven:3.9.5-eclipse-temurin-11-focal AS build
WORKDIR /build
ARG MYSQL_ROOT_PASSWORD=password
COPY . .
RUN cp src/main/resources/application-prod.properties src/main/resources/application-prod2.properties
RUN sed -e 's,{{password}},'${MYSQL_ROOT_PASSWORD}',g;' src/main/resources/application-prod2.properties > src/main/resources/application-prod.properties
RUN mvn clean package -Dmaven.test.skip

FROM ubuntu/jre:17-22.04_edge
WORKDIR /app
COPY --from=build /build/target/cardatabase-0.0.1-SNAPSHOT.jar .
CMD ["-Djava.io.tmpdir=/home/app", "-jar", "cardatabase-0.0.1-SNAPSHOT.jar"]
