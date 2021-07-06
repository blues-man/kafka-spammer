FROM maven:3.6.3-jdk-11 AS builder
WORKDIR /opt/app
COPY . .
RUN mvn clean package

FROM registry.access.redhat.com/ubi8/openjdk-11

COPY --from=builder /opt/app/target/ /deployments/

CMD java -jar /deployments/kafkaspammer-runner.jar

EXPOSE 8080
