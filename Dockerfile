# Usando uma imagem base do OpenJDK 21
FROM openjdk:21-jdk-slim AS build

# Instalar o Gradle manualmente
RUN apt-get update && apt-get install -y wget unzip && \
    wget https://services.gradle.org/distributions/gradle-8.2-bin.zip && \
    unzip gradle-8.2-bin.zip && \
    mv gradle-8.2 /opt/gradle && \
    ln -s /opt/gradle/bin/gradle /usr/bin/gradle

# Definindo o diretório de trabalho dentro do container
WORKDIR /app

# Copiando os arquivos Gradle e código fonte para o container
COPY build.gradle settings.gradle /app/
COPY gradle /app/gradle
COPY src /app/src

# Compilando o projeto e criando o JAR
RUN gradle build -x test

# Usando a mesma imagem base do OpenJDK 21 para rodar a aplicação
FROM openjdk:21-jdk-slim

# Definindo o diretório de trabalho para o runtime
WORKDIR /app

# Copiando o arquivo JAR gerado na fase de build
COPY --from=build /app/build/libs/*.jar /app/catalog-service.jar

# Expondo a porta que a aplicação vai usar
EXPOSE 8080

# Comando para rodar a aplicação
ENTRYPOINT ["java", "-jar", "catalog-service.jar"]
