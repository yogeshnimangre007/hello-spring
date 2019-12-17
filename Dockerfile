FROM maven:3.6-jdk-11 AS build
COPY pom.xml /app
RUN mvn -f /app/pom.xml dependency:resolve
COPY src /app/src
RUN mvn -f /app/pom.xml package

FROM openjdk:11
COPY --from=build /app/target/hello-spring-0.1.0.jar /app/hello-spring-0.1.0.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app/hello-spring-0.1.0.jar"]
