# -------- Stage 1: Build --------
FROM maven:3.9.0-eclipse-temurin-17 AS build
WORKDIR /build
 
# Copy pom.xml from the app directory
COPY SmallestSpringApp/pom.xml .
 
# Download dependencies
RUN mvn -B -ntp dependency:go-offline
 
# Copy source code
COPY SmallestSpringApp/src ./src
 
# Build the JAR
RUN mvn -B -ntp clean package -DskipTests
 
# -------- Stage 2: Runtime --------
FROM eclipse-temurin:17-jre
WORKDIR /app
 
COPY --from=build /build/target/*.jar app.jar
 
EXPOSE 8080
ENTRYPOINT ["java","-jar","app.jar"]
