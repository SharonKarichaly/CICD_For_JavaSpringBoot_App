Project Structure

<img width="1321" height="659" alt="project-structure" src="https://github.com/user-attachments/assets/888debb0-859b-48a6-8e83-c37d4a6598f9" />


This project, CICD_For_JavaSpringBoot_App, demonstrates a complete CI/CD (Continuous Integration/Continuous Deployment) pipeline for a Java Spring Boot application. Here’s a breakdown of its main components and purpose:

Main Purpose

Automate the process of building, testing, analyzing, packaging, containerizing, and deploying a Spring Boot application using Jenkins and Docker, with code quality checks via SonarQube.

Key Features
Spring Boot Application

The core code is a simple Spring Boot app exposing a /hello endpoint that returns "Hello from Spring Boot!".

Jenkins Pipeline

The Jenkinsfile defines an automated pipeline with these stages:
Clean Workspace: Removes previous build artifacts.
Checkout: Pulls the latest code from GitHub.
Build and Test: Uses Maven to compile and test the code, producing a JAR file.
Static Code Analysis: Integrates with SonarQube for code quality checks.
Build and Push Docker Image: Builds a Docker image from the JAR and pushes it to Docker Hub.
Update Deployment File: Updates the Kubernetes deployment manifest with the new image tag and commits this back to the repository.
Docker Support

The Dockerfile builds a Docker image for the application and exposes port 8080.

GitHub Integration
The pipeline uses GitHub credentials and tokens to interact with the repository, push deployment updates, and manage code versions.

