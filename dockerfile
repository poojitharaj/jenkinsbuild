FROM maven:3.8.4-openjdk-8-slim AS maven_build
WORKDIR /app
COPY pom.xml 
RUN mvn dependency:go-offline
COPY src ./src
RUN mvn package -DskipTests
FROM openjdk:8-jre-slim
WORKDIR /app
COPY --from=maven_build /app/target/sample-1.0.3.jar 
CMD ["java", "-jar", "sample-1.0.3.jar"]
