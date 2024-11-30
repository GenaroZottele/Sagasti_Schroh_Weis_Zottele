# Proyecto Flutter: Gestion de Entretenimiento

## Descripcion
Este proyecto es una aplicación Flutter que centraliza información sobre entretenimiento. Permite gestionar y visualizar datos de:

- Actores destacados. Gason Sagasti
- Películas próximas a estrenar en el cine. Genaro Weis
- Catálogo general de películas. Santiago Schroh
- Series de televisión. Genaro Zottele

Cada módulo cuenta con su propia funcionalidad específica, como listas de registros, detalles individuales y opciones para interactuar (marcar como favoritos, editar descripciones, etc.).

Como adicional, el proyecto no consume ninguna api, los mocks estan hardcodeados y corre desde chrome (no andriod).

## Estructura del Proyecto
El proyecto está dividido en varias secciones principales para facilitar su mantenimiento y comprensión:

### Carpetas Principales
- **assets/**: Contiene los recursos multimedia como imágenes y fondos.
  - **actores/**: Imagenes de actores.
  - **movies/**: Portadas de peliculas en tendencia.
  - **posters_estrenos/**: Portadas de peliculas próximas a estrenarse.
  - **images/**: Portadas de series de tv.
- **lib/**: Carpeta principal del código fuente.
  - **helpers/**: Código auxiliar, como manejo de preferencias (modo oscuro).
  - **mocks/**: Datos simulados para poblar las pantallas.
  - **screens/**: Pantallas de la aplicación.
  - **widgets/**: Widgets reutilizables.

## Funcionalidades Principales

1. **Módulo de Actores**
   - Lista de actores destacados con imágenes y descripciones.
   - Posibilidad de marcar actores como favoritos.
   - Pantalla de detalles para editar descripciones.

2. **Películas Próximas a Estrenar**
   - Lista de estrenos con sus posters y fechas de lanzamiento.
   - Detalles sobre la sinopsis y clasificación de cada película.
   - Se pueden marcar peliculas favoritas.

3. **Películas en Tendencia**
   - Lista de películas disponibles con datos como género, duración y año de lanzamiento.
   - Se pueden marcar películas como vistas o favoritas.

4. **Series de TV**
   - Lista de series de televisión con temporadas y episodios.
   - Descripción breve de cada serie y opción de favoritos.

## Estructura Técnica
- **Framework**: Flutter.
- **Estado**: Manejado principalmente mediante widgets con estado (StatefulWidget) y listas dinámicas.
- **Datos**: Mock estáticos simulados en archivos Dart.

## Como Correr el Proyecto
1. Clonar el repositorio. link: (`https://github.com/GenaroZottele/Sagasti_Schroh_Weis_Zottele.git`)
2. Asumimos que Flutter esta instalado.
3. Ejecutar el comando:  `flutter pub get`         
