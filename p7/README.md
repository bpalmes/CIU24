# Reproductor de Música en 3D

## Descripción

Este proyecto consiste en la creación de un reproductor de música que integra gráficos y síntesis de sonido utilizando Processing. El reproductor está inspirado en el estilo de los reproductores de Windows.

## Instalación

Para ejecutar este proyecto, sigue estos pasos:

1. **Descargar el código**:
   - Clona o descarga el repositorio que contiene el código fuente.

2. **Instalar Processing**:
   - Ve al [sitio oficial de Processing](https://processing.org/download/) y descarga la versión correspondiente a tu sistema operativo.
   - Instala Processing siguiendo las instrucciones proporcionadas en el sitio.

3. **Preparar los archivos necesarios**:
   - Asegúrate de que los archivos de música (como `letitbe.mp3`) y las imágenes (como `black.jpg`) estén en las rutas correctas dentro de la carpeta `data` del proyecto.
   - Asegúrate de que la biblioteca Minim esté instalada en Processing. Puedes instalarla a través del menú de bibliotecas en Processing (Sketch -> Import Library... -> Add Library... y busca "Minim").

4. **Abrir el proyecto en Processing**:
   - Abre Processing y carga el archivo `.pde` del proyecto.

## Uso

Para utilizar este proyecto, sigue estas instrucciones:

1. **Interacción con el reproductor**:
   - El reproductor comenzará a reproducir la música automáticamente al iniciar.
   - Usa las siguientes teclas para controlar la reproducción:
     - `A`: Retrocede 10 segundos.
     - `D`: Avanza 10 segundos.
     - `R`: Reinicia la canción.
     - `M`: Silencia o desilencia la canción.
     - `P`: Pausa la canción.
     - `Espacio`: Reanuda la reproducción si está pausada.
     - `Escape`: Cierra la aplicación.

2. **Visualización**:
   - El reproductor muestra una línea de tiempo con el progreso de la canción y los tiempos de inicio y fin.
   - Mensajes de estado indican si la canción está pausada, silenciada o ha finalizado.

## Licencia

Este proyecto está licenciado bajo la licencia Creative Commons. Para más detalles, consulta el archivo [LICENSE](LICENSE).

## Autores

- **Brian Palmés Gómez** - Autor y desarrollador principal.

---
