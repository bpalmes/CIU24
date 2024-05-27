import ddf.minim.*;
import ddf.minim.analysis.*;
import processing.serial.*;

Player player;
ArrayList<Bullet> bullets;
ArrayList<Enemy> enemies;
Planet planet1, planet2;
int score = 0;
boolean gameOver = false;

PImage backgroundTexture;
PShader myShader;
Serial myPort;
int threshold = 190; // Umbral para disparar

void setup() {
  size(800, 600, P2D);
  setupAudio();
  player = new Player();
  bullets = new ArrayList<Bullet>();
  enemies = new ArrayList<Enemy>();
  backgroundTexture = loadImage("space.jpg");
  
  // Crear planetas con velocidades de traslación
  planet1 = new Planet(width / 2, height / 2, 300, 30, 0.01);
  planet2 = new Planet(width / 2, height / 2, 350, 40, -0.01);
  
  myShader = loadShader("simple.frag", "simple.vert");
  myShader.set("resolution", float(width), float(height));
  
  // Inicializar enemigos
  resetEnemies();
  
  // Configurar comunicación serie
  String portName = Serial.list()[0]; // Selecciona el primer puerto disponible
  myPort = new Serial(this, portName, 9600);
}

void draw() {
  if (gameOver) {
    background(backgroundTexture);
    fill(255, 0, 0);
    textSize(50);
    textAlign(CENTER, CENTER);
    text("Game Over", width / 2, height / 2);
    return;
  }
  
  background(backgroundTexture);
  
  detectBeat();
  
  if (beat.isOnset()) {
    planet1.changeColor();
    planet2.changeColor();
  }
  
  // Dibujar planetas
  planet1.display();
  planet2.display();
  
  player.display();
  
  for (Bullet b : bullets) {
    b.update();
    b.display();
  }
  
  shader(myShader);
  myShader.set("time", millis() / 1000.0);
  
  for (Enemy e : enemies) {
    e.move();
    e.display();
    if (e.hits(player)) {
      gameOver = true;
    }
  }
  
  resetShader();
  
  // Control del jugador
  if (keyPressed) {
    if (key == 'a' || key == 'A') {
      player.move(-1);
    } else if (key == 'd' || key == 'D') {
      player.move(1);
    }
  }
  
  // Verificar colisiones
  for (Bullet b : bullets) {
    for (Enemy e : enemies) {
      if (b.hits(e)) {
        e.alive = false;
        score += 10;
      }
    }
  }
  
  // Eliminar balas inactivas y enemigos muertos
  bullets.removeIf(b -> !b.active);
  enemies.removeIf(e -> !e.alive);
  
  // Verificar si todos los enemigos han sido eliminados
  if (enemies.isEmpty()) {
    resetEnemies();
  }
  
  // Dibujar la puntuación
  fill(255);
  textSize(20);
  text("Score: " + score, 10, 20);
  
  // Leer del puerto serie
  if (myPort.available() > 0) {
    String inString = myPort.readStringUntil('\n');
    if (inString != null) {
      inString = trim(inString);
      int sensorValue = int(inString);
      if (sensorValue > threshold) {
        bullets.add(new Bullet(player.x + player.w / 2, player.y));
      }
    }
  }
}

void keyPressed() {
  if (key == ' ' && !gameOver) {
    bullets.add(new Bullet(player.x + player.w / 2, player.y));
  }
}


void resetEnemies() {
  enemies.clear(); // Limpiar la lista de enemigos
  float offsetX = random(0, width - 300); // Ajuste para la posición x del bloque
  float offsetY = random(0, height / 2 - 100); // Ajuste para la posición y del bloque
  
  for (int i = 0; i < 5; i++) {
    for (int j = 0; j < 3; j++) {
      float x = offsetX + i * 60;
      float y = offsetY + j * 40;
      enemies.add(new Enemy(x, y));
    }
  }
}

void stop() {
  song.close();
  minim.stop();
  super.stop();
}
