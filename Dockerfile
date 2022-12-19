FROM ubuntu:latest
ENV JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64"
RUN apt-get update -y && \
    apt install default-jdk -y && \
    apt-get install maven -y
WORKDIR /home/petclinic/target/
COPY target/*jar /home/petclinic/target/app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","app.jar"]
