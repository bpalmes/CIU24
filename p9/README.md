# Pong Controlado con Sensor Infrarrojo

## Descripción

Este proyecto consiste en programar una interfaz que utilice la información de distancia suministrada por el sensor infrarrojo Sharp GP2D12 o similar, capturada a través del Arduino, para controlar el movimiento del juego Pong implementado con Processing.

## Instalación

Para ejecutar este proyecto, sigue estos pasos:

1. **Descargar el código**:
   - Clona o descarga el repositorio que contiene el código fuente.

2. **Instalar Processing**:
   - Ve al [sitio oficial de Processing](https://processing.org/download/) y descarga la versión correspondiente a tu sistema operativo.
   - Instala Processing siguiendo las instrucciones proporcionadas en el sitio.

3. **Configurar el Arduino**:
   - Conecta tu sensor infrarrojo Sharp GP2D12 al Arduino según las especificaciones del sensor y del Arduino.
   - Sube el siguiente código al Arduino para leer los valores del sensor y enviarlos a Processing a través del puerto serial:
    
     void setup() {
       Serial.begin(9600);
     }

     void loop() {
       int sensorValue = analogRead(A0);
       Serial.println(sensorValue);
       delay(50);
     }
   
   - Conecta tu placa Arduino a tu computadora.

4. **Preparar los archivos necesarios en Processing**:
   - Asegúrate de que el archivo de Processing esté configurado para leer desde el puerto serial correcto.

5. **Abrir el proyecto en Processing**:
   - Abre Processing y carga el archivo `.pde` del proyecto.

## Uso

Para utilizar este proyecto, sigue estas instrucciones:

1. **Iniciar el juego**:
   - Ejecuta el código en Processing.
   - Haz clic con el ratón en la ventana del juego para comenzar.

2. **Controlar el juego con el sensor infrarrojo**:
   - Mueve tu mano o un objeto delante del sensor infrarrojo para controlar la posición vertical de la paleta del jugador 1.
   - La posición del jugador 1 se mapea de acuerdo con los valores mínimo y máximo del sensor.
   
   -INCOMPLETO presenta fallos demasiada sensibilidad no siempre baja del todo no sé si es problema del sensor 

3. **Controles adicionales**:
   - Jugador 2 puede usar las teclas `W` (arriba) y `S` (abajo) para mover la paleta.
   - Usa las flechas `arriba` y `abajo` para mover la paleta del jugador 2.
   - `Espacio`: Pausa el juego.
   - `R`: Reinicia el juego.
   - `Escape`: Cierra la aplicación.

## Licencia

Este proyecto está licenciado bajo la licencia Creative Commons. Para más detalles, consulta el archivo [LICENSE](LICENSE).

## Autores

- **Brian Palmés Gómez** - Autor y desarrollador principal.

