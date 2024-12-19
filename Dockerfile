# Usando uma imagem base do OpenJDK 21
FROM openjdk:21-jdk-slim

# Definir o diretório de trabalho dentro do contêiner
WORKDIR /app

# Copiar o arquivo JAR gerado para o contêiner
COPY build/libs/*.jar /app/catalog-service.jar

# Expor a porta que a aplicação irá rodar
EXPOSE 8080

# Comando para executar a aplicação
ENTRYPOINT ["java", "-jar", "/app/catalog-service.jar"]
