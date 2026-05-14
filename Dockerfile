FROM tomcat:10.1-jdk17
RUN rm -rf /usr/local/tomcat/webapps/*
# This line copies your UI from the 'web' folder to the server root
COPY ./web /usr/local/tomcat/webapps/ROOT
COPY ./WEB-INF /usr/local/tomcat/webapps/ROOT/WEB-INF
EXPOSE 8080
CMD ["catalina.sh", "run"]
