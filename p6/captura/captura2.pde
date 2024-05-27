import oscP5.*;
import netP5.*;
import processing.video.*;

Capture cam;
OscP5 oscP5;
boolean bocaAbierta = false;
int dim;

void setup() {
  size(640, 480);
  
  // Iniciar cámara
  cam = new Capture(this, width, height);
  cam.start();

  // Iniciar OSC
  oscP5 = new OscP5(this, 8338);

  // Dimensión de la imagen
  dim = width * height;
}

void draw() {
  if (cam.available()) {
    cam.read();
    image(cam, 0, 0);
    
    if (bocaAbierta) {
      umbraliza();
    }
  }
}

void umbraliza() {
  cam.loadPixels();
  for (int i = 0; i < cam.pixels.length; i++) {
    float suma = red(cam.pixels[i]) + green(cam.pixels[i]) + blue(cam.pixels[i]);
    cam.pixels[i] = (suma < 255 * 1.5) ? color(0, 0, 0) : color(255, 255, 255);
  }
  cam.updatePixels();
}

// Manejo de mensajes OSC
void oscEvent(OscMessage m) {
  if (m.checkAddrPattern("/gesture/mouth/height")) {
    float mouthHeight = m.get(0).floatValue();
    bocaAbierta = mouthHeight > 0.6; // Ajusta el umbral según sea necesario
  }
}

// Opcional: Visualizar los datos recibidos
void drawFacialLandmarks(float[] points) {
  for (int i = 0; i < points.length; i += 2) {
    float x = points[i] * width;
    float y = points[i + 1] * height;
    ellipse(x, y, 5, 5);
  }
}
