# Imagen de documentación (Astro Starlight) como estático con nginx.
# Pensado para NaN Cloud Apps (https://nan.builders/docs/apps) o GitHub Pages.
#
# Build local:
#   docker build -t nan-video-demo .
#   docker run -p 8080:80 nan-video-demo   # → http://localhost:8080
FROM node:22-alpine AS build
WORKDIR /app
COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile
COPY . .
# En NaN Cloud la doc se sirve en la raíz del subdominio.
ENV SITE_BASE=/
ENV SITE_URL=https://hackathon-mlorentedev-nan-video-demo.apps.nan.builders
RUN yarn build

FROM nginx:alpine
COPY --from=build /app/dist/ /usr/share/nginx/html/
EXPOSE 80
