FROM maven:3.8.7-eclipse-temurin-17 AS build

WORKDIR /app

# Copy Maven project files
COPY pom.xml .
COPY src ./src

# Build the WAR package
RUN mvn clean package

# Use Tomcat 10 with JDK 17 for runtime
FROM tomcat:10.1.10-jdk17-temurin

#ensure correct permission
RUN mkdir -p /usr/local/tomcat/webapps && \
    chmod -R 777 /usr/local/tomcat/conf
COPY --from=build /app/target/helloworld-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/helloworld.war
