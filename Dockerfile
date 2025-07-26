# Use OpenJDK base image
FROM openjdk:17-jdk-slim

# Set working directory
WORKDIR /home/sharon/springbootapp

# Copy jar file
COPY target/springbootapp-1.0.0.jar app.jar

# Expose port
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]

