# NaN Video Pipeline

De un tema a un video corto narrado (9:16), usando solo los modelos del cluster NaN.

## Desarrollo local

```bash
yarn install
yarn dev        # http://localhost:4321
```

## Docker

```bash
docker build -t nan-video-demo .
docker run -p 8080:80 nan-video-demo   # http://localhost:8080
```

## Desplegar en NaN Cloud Apps

1. Conecta este repo en el panel de NaN Cloud
2. Build context: `.`, puerto: `80`
3. URL asignada automáticamente (`*.apps.nan.builders`)
