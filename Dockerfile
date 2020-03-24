FROM tomcat:9-jdk8
EXPOSE 8080
LABEL maintainer="lasencio@gmu.edu"
COPY swe645-hw2-luis.war /usr/local/tomcat/webapps/
EXPOSE 8080
CMD ["catalina.sh", "run"]
