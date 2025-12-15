
# ----- Builder stage -----
FROM maven:3.9.9-eclipse-temurin-17 AS builder
WORKDIR /app
# Copy pom and sources
COPY pom.xml .
COPY src ./src
# Build
RUN mvn -B -DskipTests package

# ----- Runtime stage -----
FROM eclipse-temurin:17-jre
WORKDIR /app
# Copy artifact from builder (NOT from local context)
COPY --from=builder /app/target/*-runner.jar /app/app.jar
# Or: COPY --from=builder /app/target/*.jar /app/app.jar
EXPOSE 8080
CMD ["java", "-jar", "/app/app.jar"
