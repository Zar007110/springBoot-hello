FROM openjdk:17-jdk-alpine3.14

WORKDIR /app

COPY target/demo-0.0.1-SNAPSHOT.jar app.jar

ENTRYPOINT ["java","-jar","app.jar"]
