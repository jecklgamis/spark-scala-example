FROM eclipse-temurin:21-jdk AS build
WORKDIR /app
COPY .mvn .mvn
COPY mvnw pom.xml ./
RUN ./mvnw dependency:go-offline -B
COPY src src
RUN ./mvnw clean package -B -DskipTests

FROM eclipse-temurin:21-jre
WORKDIR /app
COPY --from=build /app/target/spark-scala-example.jar spark-scala-example.jar
ENTRYPOINT ["java", "--add-opens=java.base/java.nio=org.apache.arrow.memory.core,ALL-UNNAMED", "-cp", "spark-scala-example.jar", "spark.examples.SparkConnectApp"]
