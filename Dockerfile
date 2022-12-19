FROM ubuntu:latest
ENV JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64"
RUN apt-get update -y && \
    apt install default-jdk -y && \
    apt-get install maven -y
WORKDIR /home/petclinic/target/
COPY target /home/petclinic/target/
EXPOSE 8080
#CMD [ "mvn","spring-boot:run","-Dspring-boot.run.profiles=mysql" ]
ENTRYPOINT ["java","-jar","*.jar"]
