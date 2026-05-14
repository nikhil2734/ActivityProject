FROM tomcat:10.1-jdk17

# 1. Clean out the default apps
RUN rm -rf /usr/local/tomcat/webapps/*

# 2. Copy your UI and WEB-INF structure
COPY ./web /usr/local/tomcat/webapps/ROOT
COPY ./WEB-INF /usr/local/tomcat/webapps/ROOT/WEB-INF

# 3. Copy your source code
COPY ./src /usr/local/tomcat/src

# 4. Create the classes directory if it doesn't exist
RUN mkdir -p /usr/local/tomcat/webapps/ROOT/WEB-INF/classes

# 5. COMPILE the Java files (This replaces the ones you deleted)
RUN javac -cp "/usr/local/tomcat/lib/*" -d /usr/local/tomcat/webapps/ROOT/WEB-INF/classes /usr/local/tomcat/src/*.java

EXPOSE 8080
CMD ["catalina.sh", "run"]
