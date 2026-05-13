FROM eclipse-temurin:17-jdk

WORKDIR /app

COPY target/*.jar attendance-app.jar

EXPOSE 8080

ENTRYPOINT ["java","-jar","attendance-app.jar"]