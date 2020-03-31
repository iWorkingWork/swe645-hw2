FROM tomcat:9-jdk8
RUN sed -i 's/port="8080"/port="80"/' /usr/local/tomcat/conf/server.xml
EXPOSE 80
LABEL maintainer="lasencio@gmu.edu"
COPY swe645-hw2-luis.war /usr/local/tomcat/webapps/
CMD ["catalina.sh", "run"]
