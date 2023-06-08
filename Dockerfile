#
# First stage
#

FROM maven:3.8.3-openjdk-17 AS build

COPY src /home/app/src
COPY pom.xml /home/app

ENV OPEN_WEATHER_API_KEY=d2c10dba6e897642d5f2d6346712e749
ENV OPEN_WEATHER_API_URL=https://api.openweathermap.org/data/2.5/weather

RUN mvn -f /home/app/pom.xml clean package

#
# second stage
#

FROM openjdk:17-oracle

ENV OPEN_WEATHER_API_KEY=d2c10dba6e897642d5f2d6346712e749
ENV OPEN_WEATHER_API_URL=https://api.openweathermap.org/data/2.5/weather

COPY --from=build /home/app/target/workshop17-0.0.1-SNAPSHOT.jar /usr/local/lib/workshop17.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/usr/local/lib/workshop17.jar"]