FROM ubuntu:22.04

# Install required packages
RUN apt update && \
    apt install -y git openjdk-11-jdk maven wget unzip

# Clone the repository and build the WAR file
RUN git clone https://github.com/lahari104/deploying-spring-boot-as-war-on-tomcat.git && \
    cd deploying-spring-boot-as-war-on-tomcat && \
    mvn clean package

# Install Tomcat manually
RUN wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.93/bin/apache-tomcat-9.0.93.tar.gz && \
    tar -xvzf apache-tomcat-9.0.93.tar.gz && \
    mv apache-tomcat-9.0.93 /opt/tomcat9 && \
    cp deploying-spring-boot-as-war-on-tomcat/target/*.war /opt/tomcat9/webapps/

# Set permissions and make sure catalina.sh is executable
RUN chmod +x /opt/tomcat9/bin/catalina.sh

# Expose the default Tomcat port
EXPOSE 8080

# Run Tomcat
CMD ["/opt/tomcat9/bin/catalina.sh", "run"]