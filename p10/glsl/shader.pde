PShader colorShader, vertexShader;
boolean showVertexEffect = false;
float rotationAngleX = 0;
float rotationAngleY = 0;

float[] planetDistances = {60, 90, 120, 160, 200, 240, 280, 320, 360};
float[] planetSizes = {6, 8, 8, 5, 15, 12, 10, 9, 4};
float[] planetSpeeds = {0.2, 0.16, 0.12, 0.1, 0.06, 0.05, 0.04, 0.036, 0.03};

void setup() {
  size(800, 600, P3D);
  noStroke();
  colorShader = loadShader("colorEffect.glsl");
  vertexShader = loadShader("vertexEffect.glsl", "vertexVert.glsl");
}

void draw() {
  background(0);
  lights();
  translate(width / 2, height / 2);
  rotateX(rotationAngleX);
  rotateY(rotationAngleY);

  // Shader de fragmentos para el Sol
  shader(colorShader);
  colorShader.set("u_time", millis() / 1000.0);
  colorShader.set("u_resolution", float(width), float(height));
  pushMatrix();
  translate(0, 0, 0);
  sphere(50);
  popMatrix();

  // Shader de vértices para los planetas
  if (showVertexEffect) {
    shader(vertexShader);
    vertexShader.set("u_time", millis() / 1000.0);
  } else {
    resetShader();
  }

  // Dibujar planetas
  for (int i = 0; i < 9; i++) {
    pushMatrix();
    rotateY(millis() / 500.0 * planetSpeeds[i]);  // Velocidad duplicada
    translate(planetDistances[i], 0, 0);
    rotateY(millis() / 250.0);  // Velocidad de rotación duplicada
    sphere(planetSizes[i]);
    popMatrix();
  }

  // Mostrar nombre del autor
  resetShader();
  fill(255);
  textSize(16);
  textAlign(RIGHT, TOP);
  text("Brian Palmés Gómez", width - 20, 20);
}

void keyPressed() {
  if (key == 'v') {
    showVertexEffect = !showVertexEffect;
  } else if (key == 'w') {
    rotationAngleX -= 0.1;
  } else if (key == 's') {
    rotationAngleX += 0.1;
  } else if (key == 'a') {
    rotationAngleY -= 0.1;
  } else if (key == 'd') {
    rotationAngleY += 0.1;
  }
}
