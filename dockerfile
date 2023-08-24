FROM centos:7
RUN yum -y update
RUN yum install -y && \
  java-1.8.0-openjdk && \
  java-1.8.0-openjdk-devel && \
  epel-release && \
  curl && \
  unzip
RUN curl -O https://archive.apache.org/dist/tomcat/tomcat-8/v8.5.73/bin/apache-tomcat-8.5.92.tar.gz /opt
WORKDIR /opt
RUN tar -xvf apache-tomcat-8.5.92.tar.gz
WORKDIR /opt/apache-tomcat-8.5.92
ADD https://s3-us-west-2.amazonaws.com/studentapi-cit/student.war webapps/
ADD https://s3-us-west-2.amazonaws.com/studentapi-cit/mysql-connector.jar lib/
COPY context.xml conf/context.xml
RUN yum install mariadb -y
RUN mysql -h http://studentapp.cvtqqrqicqly.us-east-1.rds.amazonaws.com -u admin -padmin123
RUN show databases;
RUN CREATE DATABASE studentapp;
RUN use studentapp;
RUN CREATE TABLE if not exists students(student_id INT NOT NULL AUTO_INCREMENT, student_name VARCHAR(100) NOT NULL, student_addr VARCHAR(100) NOT NULL, student_age VARCHAR(3) NOT NULL, student_qual VARCHAR(20) NOT NULL, student_percent VARCHAR(10) NOT NULL, student_year_passed VARCHAR(10) NOT NULL, PRIMARY KEY (student_id));
RUN exit;
EXPOSE 8080
EXPOSE 3306
RUN ./bin/catalina.sh run



