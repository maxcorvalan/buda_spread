# Spread API

Este proyecto es una API para calcular y monitorear los spreads de mercado en la plataforma de intercambio Buda.com.

Para comenzar, debes correr en la consola Linux en la carpeta: 

`bundle install`

Luego, crea tu archivo `.env` en la carpeta raiz del proyecto, donde deberás definir SPREAD_API_DATABASE_PASSWORD.

Posteriormente, debes correr

`rails db:create db:migrate`

Y correr el proyecto finalmente con:

`rails s`

## Endpoints

### Markets

- **GET /api/v1/markets/:market_id/spread**: Calcula y devuelve el spread actual para un mercado específico en Buda.com.
  - Parámetros de la URL:
    - `market_id`: ID del mercado en Buda.com.
  - Respuesta exitosa:
    - `market_id`: ID del mercado.
    - `spread`: Valor del spread actual.

- **GET /api/v1/markets/spread_all**: Calcula y devuelve el spread actual para todos los mercados disponibles en Buda.com.
  - Respuesta exitosa:
    - Lista de objetos JSON, cada uno con los siguientes campos:
      - `market_id`: ID del mercado.
      - `spread`: Valor del spread actual.

### Alerts

- **POST /api/v1/alerts**: Crea una alerta para monitorear un spread específico en un mercado.
  - Parámetros de la solicitud:
    - `market_id`: ID del mercado en Buda.com.
    - `spread_value`: Valor del spread a monitorear.
  - Respuesta exitosa:
    - Objeto JSON con los detalles de la alerta creada.

- **GET /api/v1/alerts/:id**: Obtiene los detalles de una alerta específica por su ID.
  - Parámetros de la URL:
    - `id`: ID de la alerta.
  - Respuesta exitosa:
    - Objeto JSON con los detalles de la alerta.

- **PATCH /api/v1/alerts/:id**: Actualiza los detalles de una alerta específica por su ID.
  - Parámetros de la URL:
    - `id`: ID de la alerta.
  - Parámetros de la solicitud:
    - `spread_value`: Nuevo valor del spread a monitorear.
  - Respuesta exitosa:
    - Objeto JSON actualizado con los detalles de la alerta.

- **DELETE /api/v1/alerts/:id**: Elimina una alerta específica por su ID.
  - Parámetros de la URL:
    - `id`: ID de la alerta.
  - Respuesta exitosa:
    - Objeto JSON con un mensaje de confirmación.

### Polling

- **GET /api/v1/polling/:id**: Realiza una solicitud de polling para comparar el spread actual de un mercado con el spread guardado en una alerta específica.
  - Parámetros de la URL:
    - `id`: ID de la alerta.
  - Respuesta exitosa:
    - Mensaje indicando si el spread actual es mayor, menor o igual al spread guardado en la alerta.

## Funcionamiento

1. **Markets**: Los endpoints de Markets permiten calcular el spread actual de un mercado específico o de todos los mercados disponibles en Buda.com.

2. **Alerts**: Los endpoints de Alerts permiten crear, ver, actualizar y eliminar alertas para monitorear spreads en mercados específicos.

3. **Polling**: El endpoint de Polling permite realizar consultas periódicas para comparar el spread actual de un mercado con el spread guardado en una alerta.

## Tecnologías Utilizadas

- Ruby on Rails: Framework de desarrollo web.
- RestClient: Cliente HTTP para realizar solicitudes a la API de Buda.com.

## Autor

Maximiliano Corvalán Muñoz

