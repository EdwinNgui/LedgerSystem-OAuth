# Use an official Maven image to build the application
FROM maven:3.9.6-eclipse-temurin-21 AS build

WORKDIR /app

# Copy source code and pom.xml
COPY . .

# Build the project and skip tests
RUN mvn clean package -DskipTests

# Use a lightweight JDK to run the app
FROM eclipse-temurin:21-jre

# Install curl for healthcheck
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy the built jar from the previous stage
COPY --from=build /app/target/*.jar app.jar

# Create a non-root user
RUN useradd -m appuser && chown -R appuser:appuser /app
USER appuser

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
