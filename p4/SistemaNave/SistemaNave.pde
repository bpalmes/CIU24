// import gifAnimation.*;
float ang;

Planeta star1;

Planeta tierra;
Planeta marte;
Planeta venus;
Planeta jupiter;
Planeta luna;

Planeta satellite1;

PImage backgroundTexture;

PImage solTexture;

PImage tierraTexture;
PImage marteTexture;
PImage venusTexture;
PImage jupiterTexture;
PImage lunaTexture;

float rotateX, rotateY;

// Coordenadas del vector de la camara
float yaw = -180;
float pitch = 10;
float hDist, vDist;
float dist;

PVector dir = new PVector(0, 0, 1);
PVector camaraPos = new PVector(width / 2, height / 2 - 100, (height / 2.0) / tan(PI * 30.0 / 180.0));
PVector navePos = new PVector(0, 0, 0);

PVector up = new PVector(0, 1, 0);

boolean w = false, s = false, a = false, d = false;
boolean arriba = false, abajo = false, izquierda = false, derecha = false;

float step = 5.0;

int tras_x, tras_y, tras_z, zoom;
boolean nave;

// GifMaker gif;
int gifCount = 0;
PShape ship;

void setup() {
  size(736, 368, P3D);
  stroke(0);
  backgroundTexture = loadImage("space.jpg");
  solTexture = loadImage("sol.jpg");
  venusTexture = loadImage("venus.jpg");
  jupiterTexture = loadImage("jupiter.jpg");
  tierraTexture = loadImage("tierra.jpg");
  lunaTexture = loadImage("luna.jpg");
  ship = createShape(BOX, 20);
  // Nuevo camara
  tras_x = width / 2;
  tras_y = height / 2;
  tras_z = -800;
  zoom = 10000;
  nave = false;
  ////////////////////////////////////
  
  ang = 0;
  rotateX = 0;
  rotateY = 0;
}

void draw() {
  background(backgroundTexture);
  
  textSize(16);
  textAlign(RIGHT, TOP);
  fill(255);
  text("Brian Palmés Gómez", width - 20, 20);
  
  // translate(width/2, height/2, -500);
  textSize(40);
  text("-Pulsa N para activar la nave", -width / 2 - 500, height / 2 + 200);
  
  if (nave) {
    // Modo nave on
    actualizarCamara();
    camera(camaraPos.x, camaraPos.y, camaraPos.z, navePos.x, navePos.y, navePos.z, up.x, up.y, up.z);
    
    pushMatrix();
    translate(navePos.x, navePos.y, navePos.z);
    shape(ship);
    popMatrix();
    
  } else {
    camera(0, 0, -tras_z, 0, 0, 0, 0, 1, 0);
    
    pushMatrix();
    translate(0, 0, 0);
    textSize(40);
    text("-Pulsa N para activar la nave---- Usa +  y - para el zoom", -width / 2 - 500, height / 2 + 200);
    fill(255);
    stroke(255);
    popMatrix();
  }
  
  pushMatrix();
  star1 = new Planeta(solTexture, 2, 0, 0, 100, 0);
  popMatrix();
  pushMatrix();
  venus = new Planeta(venusTexture, 1, -1.3, -200, 20, 0);
  popMatrix();
  pushMatrix();
  tierra = new Planeta(tierraTexture, 1.2, 2, -400, 35, -8);
  luna = new Planeta(lunaTexture, 2, -2, -70, 10, 5);
  popMatrix();
  pushMatrix();
  marte = new Planeta(marteTexture, 0.9, -1.75, -500, 25, 0);
  popMatrix();
  pushMatrix();
  jupiter = new Planeta(jupiterTexture, 1.4, 1, -600, 65, -5);
  popMatrix();
  pushMatrix();
  luna = new Planeta(marteTexture, 1.2, -2.3, -800, 30, 10);
  popMatrix();
  
  ang = ang + 0.25;
  if (ang > 1000) {
    ang = 0;
  }
  // gif();
}

void keyPressed() {
  if (key == 'N') {
    nave = !nave;
  } else if (key == 'W') {
    w = true;
  } else if (key == 'S') {
    s = true;
  } else if (key == 'A') {
    a = true;
  } else if (key == 'D') {
    d = true;
  } else if (keyCode == UP) {
    arriba = true;
  } else if (keyCode == DOWN) {
    abajo = true;
  } else if (keyCode == LEFT) {
    izquierda = true;
  } else if (keyCode == RIGHT) {
    derecha = true;
  }
}

void keyReleased() {
  if (key == 'W') {
    w = false;
  }
  if (key == 'S') {
    s = false;
  }
  if (key == 'A') {
    a = false;
  }
  if (key == 'D') {
    d = false;
  }
  if (keyCode == UP) {
    arriba = false;
  }
  if (keyCode == DOWN) {
    abajo = false;
  }
  if (keyCode == LEFT) {
    izquierda = false;
  }
  if (keyCode == RIGHT) {
    derecha = false;
  }
}

void updateShipVectors() {
  hDist = dist * cos(radians(pitch));
  vDist = dist * sin(radians(pitch));
  camaraPos.y = navePos.y + vDist;
  camaraPos.x = navePos.x + hDist * sin(radians(yaw));
  camaraPos.z = navePos.z + hDist * cos(radians(yaw));
  dir.x = sin(radians(yaw)) * cos(radians(pitch));
  dir.z = cos(radians(yaw)) * cos(radians(pitch));
  dir.y = sin(radians(pitch));
  dir.normalize();
}

void actualizarCamara() { // cambiar el valor para aumentar la velocidad
  if (w) {
    navePos.add(PVector.mult(dir, 1));
  }
  
  if (s) {
    navePos.sub(PVector.mult(dir, 1));
  }
  
  if (a) {
    PVector producto = new PVector();
    PVector.cross(dir, up, producto);
    producto.normalize();
    navePos.sub(PVector.mult(producto,1));
  }
  
  if (d) {
    PVector producto = new PVector();
    PVector.cross(dir, up, producto);
    producto.normalize();
    navePos.add(PVector.mult(producto, 1));
  }
  
  if (arriba) {
    pitch -= 1;
    pitch = pitch % 360;
  }
  
  if (abajo) {
    pitch += 1;
    pitch = pitch % 360;
  }
  
  if (izquierda) {
    yaw -= 1;
    yaw = yaw % 360;
  }
  
  if (derecha) {
    yaw += 1;
    yaw = yaw % 360;
  }
  
  updateShipVectors();
}
