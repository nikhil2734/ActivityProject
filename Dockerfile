# Use Tomcat with JDK 17 (standard for Jakarta EE apps)
FROM tomcat:10.1-jdk17

# Remove default Tomcat apps to avoid confusion
RUN rm -rf /usr/local/tomcat/webapps/ActivityProject

# Copy your compiled project files into Tomcat's ROOT directory
# This assumes your local folder structure matches the standard WAR layout
COPY ./web /usr/local/tomcat/webapps/ROOT
COPY ./WEB-INF /usr/local/tomcat/webapps/ROOT/WEB-INF

# Render uses port 10000 by default, but Tomcat uses 8080. 
# Render is usually smart enough to detect 8080.
EXPOSE 8080

CMD ["catalina.sh", "run"]
