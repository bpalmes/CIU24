// Definición de constantes
const int ledPin = LED_BUILTIN; // Pin del LED integrado
const float freqMax = 10; // Frecuencia máxima de parpadeo en Hz
const float freqMin = 1;  // Frecuencia mínima de parpadeo en Hz
const float period = 5000; // Periodo de la señal senoidal en milisegundos

void setup() {
  pinMode(ledPin, OUTPUT); // Configura el pin del LED como salida
}

void loop() {
  // Calcula el tiempo actual
  unsigned long currentTime = millis();
  
  // Calcula la fase de la señal senoidal
  float phase = (2 * PI * currentTime) / period;
  
  // Calcula la frecuencia actual basada en la señal senoidal
  float currentFreq = freqMin + (sin(phase) + 1) / 2 * (freqMax - freqMin);
  
  // Calcula el periodo de parpadeo en función de la frecuencia actual
  float blinkPeriod = 1000.0 / currentFreq;
  
  // Enciende y apaga el LED según el periodo de parpadeo
  digitalWrite(ledPin, HIGH);
  delay(blinkPeriod / 2);
  digitalWrite(ledPin, LOW);
  delay(blinkPeriod / 2);
}
