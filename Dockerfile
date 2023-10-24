FROM maven:3.9.5-eclipse-temurin-11-focal AS build
WORKDIR /build
COPY . .
RUN mvn clean package -Dmaven.test.skip

FROM ubuntu/jre:17-22.04_edge
WORKDIR /app
COPY --from=build /build/target/cardatabase-0.0.1-SNAPSHOT.jar .
CMD ["-Djava.io.tmpdir=/app", "-jar", "cardatabase-0.0.1-SNAPSHOT.jar"]
