FROM centos:7
RUN yum install epel-release -y
RUN yum install java-openjdk -y
ADD https://archive.apache.org/dist/tomcat/tomcat-8/v8.5.73/bin/apache-tomcat-8.5.92.tar.gz /opt/
WORKDIR /opt
RUN tar -xzf apache-tomcat-8.5.92.tar.gz
WORKDIR /opt/apache-tomcat-8.5.92
ADD https://s3-us-west-2.amazonaws.com/studentapi-cit/student.war webapps/
ADD https://s3-us-west-2.amazonaws.com/studentapi-cit/mysql-connector.jar lib/
COPY context.xml conf/context.xml
EXPOSE 8080
CMD ./bin/catalina.sh run



