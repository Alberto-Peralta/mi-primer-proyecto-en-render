FROM alpine:latest

RUN apk add --no-cache \
    ca-certificates \
    unzip \
    wget \
    zip

# Descargar PocketBase
RUN wget https://github.com/pocketbase/pocketbase/releases/download/v0.22.17/pocketbase_0.22.17_linux_amd64.zip \
    && unzip pocketbase_0.22.17_linux_amd64.zip \
    && chmod +x /pocketbase

# Crear directorio para datos
RUN mkdir /pb_data

# Exponer puerto
EXPOSE 8090

# Comando de inicio
CMD ["/pocketbase", "serve", "--http=0.0.0.0:8090"]