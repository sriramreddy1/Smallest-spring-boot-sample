FROM eclipse-temurin:11-jre as runtime 
WORKDIR /app 
COPY target/*.jar app.jar 
ENTRYPOINT ["java","-jar","app.jar"]
