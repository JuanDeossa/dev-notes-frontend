# Usa una imagen base oficial de Node
FROM node:18-alpine

# Establece el directorio de trabajo en la imagen Docker
WORKDIR /app

# Copia el archivo package.json y package-lock.json para instalar las dependencias
COPY package*.json ./

# Instala las dependencias
RUN npm install

# Copia el resto del código de la aplicación
COPY . .

# Compila la aplicación
RUN npm run build

# Usa una imagen ligera de nginx para servir el contenido estático
FROM nginx:alpine
COPY --from=0 /app/dist /usr/share/nginx/html

# Expone el puerto en el que nginx va a correr
EXPOSE 80
