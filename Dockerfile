FROM maven:3.9-eclipse-temurin-21 AS build
COPY . .
RUN mvn clean package

FROM tomcat:10.1-jdk17
RUN rm -rf /usr/local/tomcat/webapps/*
# This assumes your project builds a .war file
COPY --from=build /target/*.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD ["catalina.sh", "run"]
