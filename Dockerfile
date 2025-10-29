FROM alpine:latest

RUN apk update && apk add --no-cache \
    wget \
    unzip

# Descargar y instalar PocketBase
RUN wget -O pocketbase.zip https://github.com/pocketbase/pocketbase/releases/download/v0.22.17/pocketbase_0.22.17_linux_amd64.zip \
    && unzip pocketbase.zip \
    && chmod +x pocketbase \
    && mv pocketbase /usr/local/bin/pocketbase \
    && rm pocketbase.zip

# Crear directorio para datos
WORKDIR /app
RUN mkdir -p /app/pb_data

# Exponer puerto
EXPOSE 8090

# Comando de inicio
CMD ["pocketbase", "serve", "--http=0.0.0.0:8090"]