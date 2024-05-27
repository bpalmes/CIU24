int sensorPin = A0;  // Pin analógico donde está conectado el sensor de distancia
int sensorValue = 0; // Valor leído del sensor

void setup() {
  Serial.begin(9600);  // Inicia la comunicación serial a 9600 baudios
}

void loop() {
  sensorValue = analogRead(sensorPin); // Lee el valor del sensor
  Serial.println(sensorValue);         // Envía el valor leído por el puerto serial
  delay(100);                          // Espera 100 ms antes de la siguiente lectura
}
