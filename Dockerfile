#
# First stage
#

FROM maven:3.8.3-openjdk-17 AS build

COPY src /home/app/src
COPY pom.xml /home/app

ARG OPEN_WEATHER_API_KEY
ARG OPEN_WEATHER_API_URL

RUN mvn -f /home/app/pom.xml clean package

#
# second stage
#

FROM openjdk:17-oracle

ARG OPEN_WEATHER_API_KEY
ARG OPEN_WEATHER_API_URL

COPY --from=build /home/app/target/workshop17-0.0.1-SNAPSHOT.jar /usr/local/lib/workshop17.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/usr/local/lib/workshop17.jar"]