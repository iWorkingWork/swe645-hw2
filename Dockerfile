FROM tomcat:9-jdk8

# Replace port used by tomcat
RUN sed -i 's/port="8080"/port="80"/' /usr/local/tomcat/conf/server.xml
# Expose the web server's port.
EXPOSE 80

LABEL maintainer="lasencio@gmu.edu"

# Copy over my war file to the image.
COPY swe645-hw2-luis.war /usr/local/tomcat/webapps/

# Start up the tomcat server
CMD ["catalina.sh", "run"]
