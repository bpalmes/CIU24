# Control de Frecuencia de LED con Arduino

## Descripción

Este proyecto consiste en programar un Arduino para generar una pulsación de frecuencia variable en el LED integrado en la placa. La frecuencia de parpadeo del LED sigue una señal senoidal que define su envolvente, de manera que cuando dicha señal alcanza su valor máximo el LED parpadeará a una frecuencia máxima (`freqMax`), mientras que cuando alcanza el valor mínimo parpadeará a una frecuencia mínima (`freqMin`).

Señal Senoidal

Una señal senoidal es una función matemática que describe una oscilación suave y repetitiva. La forma general de una señal senoidal es:

f(t)=A⋅sin⁡(2πft+ϕ)+D

Donde:

    A es la amplitud de la señal.
    f es la frecuencia de la señal en Hz.
    t es el tiempo.
    ϕ es la fase inicial.
    D es el desplazamiento vertical.


    No necesitamos un desplazamiento vertical D ya que queremos que la señal oscile entre 0 y 1.
    La amplitud A será 1  ya que deseamos una señal senoidal normalizada.
    La fase inicial ϕ será 0 para simplificar.
	
	La fase de una señal senoidal en función del tiempo se puede calcular como:

    fase=2πt/T

    Donde:

    t es el tiempo actual.
    T es el periodo de la señal senoidal.
	
	
	Rango de la frecuencia que queremos cubrir.
	(freqMax−freqMin)

    

    Frecuencia Actual:
    freqMin+(sin⁡(phase)+1/2)*(freqMax−freqMin)

    Se ajusta la frecuencia actual para que varíe entre freqMin y freqMax.
	
## Instalación

Para ejecutar este proyecto, sigue estos pasos:

1. **Descargar el código**:
   - Clona o descarga el repositorio que contiene el código fuente.

2. **Instalar el IDE de Arduino**:
   - Ve al [sitio oficial de Arduino](https://www.arduino.cc/en/software) y descarga el IDE de Arduino.
   - Instala el IDE siguiendo las instrucciones proporcionadas en el sitio.

3. **Abrir el proyecto en el IDE de Arduino**:
   - Abre el IDE de Arduino.
   - Carga el archivo `.ino` del proyecto.

4. **Configurar el Arduino**:
   - Conecta tu placa Arduino a tu computadora.
   - Selecciona la placa correcta en el menú `Herramientas` -> `Board`.
  

5. **Carga el código en el Arduino**:
   - Haz clic en el botón `Upload` en el IDE de Arduino para cargar el código en la placa.

## Uso

El código cargado en el Arduino controlará el LED integrado para que parpadee a una frecuencia variable siguiendo una señal senoidal. El LED parpadeará a una frecuencia máxima (`freqMax`) cuando la señal senoidal alcance su valor máximo y a una frecuencia mínima (`freqMin`) cuando la señal senoidal alcance su valor mínimo.

## Licencia

Este proyecto está licenciado bajo la licencia Creative Commons. Para más detalles, consulta el archivo [LICENSE](LICENSE).

## Autores

- **Brian Palmés Gómez** - Autor y desarrollador principal.


