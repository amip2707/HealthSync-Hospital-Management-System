# Step 1: Build the Java application using Maven
FROM maven:3.8.5-openjdk-17 AS build
COPY . .
RUN mvn clean package

# Step 2: Run the application inside an Apache Tomcat server
FROM tomcat:9.0-jdk17-openjdk-slim
COPY --from=build /target/*.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD ["catalina.sh", "run"]
