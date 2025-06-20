# Configuración de Variables de Entorno

Este proyecto utiliza variables de entorno para manejar claves API y configuraciones sensibles.

## Configuración de Google Maps API Key por Flavor

El proyecto soporta diferentes API keys para cada flavor usando archivos separados:

- **`.env.dev`** - Para el flavor de desarrollo
- **`.env`** - Para el flavor de producción

### Opción 1: Usando archivos .env separados (Recomendado)

1. Crea el archivo `.env` para producción:

```bash
touch .env
```

2. Crea el archivo `.env.dev` para desarrollo:

```bash
touch .env.dev
```

3. Configura las API keys en cada archivo:

**Archivo `.env` (producción):**

```env
GOOGLE_MAPS_API_KEY=tu_api_key_produccion
```

**Archivo `.env.dev` (desarrollo):**

```env
GOOGLE_MAPS_API_KEY=tu_api_key_desarrollo
```

### Opción 2: Usando local.properties

1. Edita el archivo `android/local.properties`
2. Agrega las líneas:

```properties
GOOGLE_MAPS_API_KEY=tu_api_key_produccion
GOOGLE_MAPS_API_KEY_DEV=tu_api_key_desarrollo
```

### Opción 3: Variables de entorno del sistema

1. Configura las variables de entorno en tu sistema:

```bash
export GOOGLE_MAPS_API_KEY=tu_api_key_produccion
export GOOGLE_MAPS_API_KEY_DEV=tu_api_key_desarrollo
```

## Orden de prioridad por flavor

### Para flavor DEV:

1. `GOOGLE_MAPS_API_KEY` en `.env.dev`
2. `GOOGLE_MAPS_API_KEY_DEV` en variables del sistema
3. `GOOGLE_MAPS_API_KEY_DEV` en `local.properties`
4. `GOOGLE_MAPS_API_KEY` en `.env` (fallback)

### Para flavor PROD:

1. `GOOGLE_MAPS_API_KEY` en `.env`
2. `GOOGLE_MAPS_API_KEY_PROD` en variables del sistema
3. `GOOGLE_MAPS_API_KEY_PROD` en `local.properties`

## Ejecutar con flavors específicos

```bash
# Ejecutar con flavor de desarrollo
flutter run --flavor dev

# Ejecutar con flavor de producción
flutter run --flavor prod

# Build para desarrollo
flutter build apk --flavor dev

# Build para producción
flutter build apk --flavor prod
```

## Variables de entorno disponibles

**Archivo `.env` (producción):**

```env
# Google Maps API Key para producción
GOOGLE_MAPS_API_KEY=tu_api_key_produccion

# Firebase Configuration
FIREBASE_API_KEY=tu_firebase_api_key_prod
FIREBASE_PROJECT_ID=tu_firebase_project_id_prod
FIREBASE_MESSAGING_SENDER_ID=tu_sender_id_prod
FIREBASE_APP_ID=tu_app_id_prod

# Facebook Configuration
FACEBOOK_APP_ID=tu_facebook_app_id_prod
FACEBOOK_CLIENT_TOKEN=tu_facebook_client_token_prod

# GraphQL Endpoint
GRAPHQL_ENDPOINT=https://tu-graphql-endpoint-prod.com/graphql
```

**Archivo `.env.dev` (desarrollo):**

```env
# Google Maps API Key para desarrollo
GOOGLE_MAPS_API_KEY=tu_api_key_desarrollo

# Firebase Configuration
FIREBASE_API_KEY=tu_firebase_api_key_dev
FIREBASE_PROJECT_ID=tu_firebase_project_id_dev
FIREBASE_MESSAGING_SENDER_ID=tu_sender_id_dev
FIREBASE_APP_ID=tu_app_id_dev

# Facebook Configuration
FACEBOOK_APP_ID=tu_facebook_app_id_dev
FACEBOOK_CLIENT_TOKEN=tu_facebook_client_token_dev

# GraphQL Endpoint
GRAPHQL_ENDPOINT=https://tu-graphql-endpoint-dev.com/graphql
```

## Seguridad

- **NUNCA** subas los archivos `.env` y `.env.dev` al repositorio
- Ambos archivos ya están incluidos en `.gitignore`
- Usa diferentes API keys para desarrollo y producción
- Rota las claves API regularmente
- **Recomendado**: Usa API keys con restricciones específicas por flavor

## Verificación

Para verificar que la configuración funciona:

1. Ejecuta `flutter clean`
2. Ejecuta `flutter pub get`
3. Ejecuta `flutter run --flavor dev` (debe usar API key de `.env.dev`)
4. Ejecuta `flutter run --flavor prod` (debe usar API key de `.env`)

Si ves el mapa cargando correctamente en ambos flavors, la configuración está funcionando.

## Configuración recomendada de Google Cloud Console

1. Crea diferentes proyectos o APIs en Google Cloud Console
2. Configura restricciones específicas para cada API key:
   - **DEV**: Restricciones de IP para desarrollo
   - **PROD**: Restricciones de aplicación para producción
3. Usa cuotas diferentes para cada ambiente

## Estructura de archivos recomendada

```
kadesh/
├── .env              # Variables de producción
├── .env.dev          # Variables de desarrollo
├── android/
│   └── local.properties  # Fallback local
└── ...
```
