FROM maven:3-jdk-11
MAINTAINER Roman Svechnikov <docker@dekinci.com>

ENV WORK_DIR=/app
RUN mkdir -p $WORK_DIR
WORKDIR $WORK_DIR

ADD pom.xml $WORK_DIR
RUN ["mvn", "verify", "clean", "--fail-never"]

ADD . $WORK_DIR
RUN ["mvn", "package"]

FROM openjdk:11
COPY --from=0 /app/target/marketplace.jar /app/marketplace.jar
CMD ["java","-jar","/app/marketplace.jar"]
EXPOSE 10002