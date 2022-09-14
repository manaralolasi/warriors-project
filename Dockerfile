FROM maven:3.8.6-openjdk-11
ENV DB_URL=44.208.36.48
ENV DB_PORT=3306
ENV DB_NAME=project
ENV DB_USERNAME=team
ENV DB_PASSWORD=Password123#@!
WORKDIR /app
ADD pom.xml .
RUN ["/usr/local/bin/mvn-entrypoint.sh","mvn","verify","clean","--fail-never"]
COPY . .
RUN mvn package
EXPOSE 8080
ENTRYPOINT ["java","-jar","target/book-0.0.1-SNAPSHOT.jar"]
