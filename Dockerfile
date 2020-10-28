FROM maven:3.5-jdk-8-alpine AS build

WORKDIR /code

COPY pom.xml /code/pom.xml
RUN ["mvn", "dependency:resolve"]
#RUN ["mvn", "verify"]

# Adding source, compile and package into a fat jar (??)
COPY ["src/main", "/code/src/main"]
RUN ["mvn", "package"]


FROM openjdk:8-jre-alpine

COPY --from=build /code/target/nasa-pic-0.0.1-SNAPSHOT.war /

#CMD ["java", "-XX:+UnlockExperimentalVMOptions", "-XX:+UseCGroupMemoryLimitForHeap", "-jar", "/nasa-pic-0.0.1-SNAPSHOT.war"]
