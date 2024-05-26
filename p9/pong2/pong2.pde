import processing.serial.*;

Serial myPort;  // Objeto de la clase Serial
float sensorValue = 0;  // Valor del sensor recibido desde Arduino
float minSensorValue = 1023; // Inicializar al máximo valor posible del sensor
float maxSensorValue = 0;    // Inicializar al mínimo valor posible del sensor

// Variables existentes del juego Pong
float ballX, ballY, ballWidth, ballHeight;
float ballSpeedX, ballSpeedY;
int playerWidth, playerHeight, playerSpeed;
int player1X, player1Y, player2X, player2Y;
boolean player1Up, player1Down, player2Up, player2Down;
int player1Score = 0;
int player2Score = 0;
int winScore = 10;
boolean start, win;
PFont font;

void setup() {
  win = false;
  size(1152, 640);
  ballX = width / 2; 
  ballY = height / 2;
  ballWidth = 20;
  ballHeight = 20;
  ballSpeedX = 5.0;
  ballSpeedY = 4.0;
  playerWidth = 30;
  playerHeight = 100;
  player1X = playerWidth;
  player1Y = height / 2 - playerHeight / 2;
  player2X = width - playerWidth * 2;
  player2Y = height / 2 - playerHeight / 2;
  playerSpeed = 5;
  
  String portName = "COM3"; // Especifica el puerto COM explícitamente
  try {
    myPort = new Serial(this, portName, 9600); // Inicializa la comunicación serial
  } catch (Exception e) {
    println("Error abriendo el puerto serial: " + e.getMessage());
  }
}

void draw() {
  if (mousePressed) start = true;
  
  drawField(255);
  scores();
  drawPlayers();
  gameOver();
  
  if (start) {
    drawBall();
    moveBall();
    control();
    Players();
    controlPlayers();
    contactWithPlayer();
  } else if (!win) {
    clickToStart();
  }

  // Leer datos del sensor
  if (myPort != null && myPort.available() > 0) {
    String inString = myPort.readStringUntil('\n');
    if (inString != null) {
      inString = trim(inString);
      if (inString.length() > 0) {
        sensorValue = float(inString); // Convertir el valor del sensor a float

        // Actualizar los valores mínimos y máximos del sensor
        if (sensorValue < minSensorValue) {
          minSensorValue = sensorValue;
        }
        if (sensorValue > maxSensorValue) {
          maxSensorValue = sensorValue;
        }
        
        // Imprimir los valores del sensor para depuración
        println("Valor del sensor: " + sensorValue + " Min: " + minSensorValue + " Max: " + maxSensorValue);
        
        // Ajustar el mapeo usando los valores mínimo y máximo reales del sensor
        player1Y = int(map(sensorValue, 60, 460, 20, height - playerHeight - 20)); 
        println("Posición del jugador: " + player1Y); // Imprimir la posición del jugador para depuración
      }
    }
  }
}

void drawField(int n) {
  fill(n);
  background(0);
  stroke(1000);
  rect(20, 20, width - 40, 20);
  rect(20, height - 40, width - 40, 20);
  
  for (int i = 2; i <= 52; i += 2)
    rect(width / 2, 20 * i, 20, 20);
}

void clickToStart() {
  fill(255);
  textSize(30);
  text("Click to start", width / 2 + 30, height / 3 - 40);
}

void drawBall() {
  rect(ballX, ballY, ballWidth, ballHeight);
}

void moveBall() {
  ballX = ballX + ballSpeedX;
  ballY = ballY + ballSpeedY;
}

void control() {
  if (ballX > width - ballWidth) {
    setup();
    ballSpeedX = -ballSpeedX;
    player1Score = player1Score + 1;
  } else if (ballX < ballWidth / 2) {
    setup();
    player2Score = player2Score + 1;
  }
  
  if (ballY > height - 40 - ballHeight) {
    ballSpeedY = -ballSpeedY;
  } else if (ballY < 40) {
    ballSpeedY = -ballSpeedY;
  }
}

void drawPlayers() {
  rect(player1X, player1Y, playerWidth, playerHeight);
  rect(player2X, player2Y, playerWidth, playerHeight);
}

void Players() {
  if (player1Up) {
    player1Y = player1Y - playerSpeed;
  } else if (player1Down) {
    player1Y = player1Y + playerSpeed;
  }
  
  if (player2Up) {
    player2Y = player2Y - playerSpeed;
  } else if (player2Down) {
    player2Y = player2Y + playerSpeed;
  }
}

void controlPlayers() {
  if (player1Y < 45) {
    player1Y = 45;
  } else if (player1Y + playerHeight > height - 45) {
    player1Y = height - (playerHeight + 45);
  }
  
  if (player2Y < 45) {
    player2Y = 45;
  } else if (player2Y + playerHeight > height - 45) {
    player2Y = height - (playerHeight + 45);
  }
}

void contactWithPlayer() {
  if (ballX < player1X + playerWidth && ballY < player1Y + playerHeight && ballY + ballHeight > player1Y) {
    if (ballSpeedX < 0) {
      ballSpeedX = -ballSpeedX * 1.05;
    }
  } else if (ballX + ballWidth > player2X && ballY < player2Y + playerHeight && ballY + ballHeight > player2Y) {
    if (ballSpeedX > 0) {
      ballSpeedX = -ballSpeedX * 1.05;
    }
  }
}

void scores() {
  textSize(100);
  text(player1Score, 100, 110);
  text(player2Score, width - 130, 110);
}

void gameOver() {
  if (player1Score == winScore) {
    gameOverPage("Player 1 wins!");
  } else if (player2Score == winScore) {
    gameOverPage("Player 2 wins!");
  }
}

void gameOverPage(String text) {
  start = false;
  ballSpeedX = 0.0;
  ballSpeedY = 0.0;
  
  if (!win) {
    win = true;
  }
  
  drawField(0);
  fill(255);
  textSize(60);
  text("Fin de la partida", width / 2 - 140, height / 3 - 40);
  text(text, width / 2 - 200, height / 3);
  text("\nClick para empezar", width / 2 - 290, height / 3 + 40);
  
  if (mousePressed) {
    win = false;
    player1Score = 0;
    player2Score = 0;
    ballSpeedX = 5.0;
    ballSpeedY = 4.0;
  }
}

void keyPressed() {
  if (key == 'w' || key == 'W') {
    player1Up = true;
  } else if (key == 's' || key == 'S') {
    player1Down = true;
  }
  
  if (keyCode == UP) {
    player2Up = true;
  } else if (keyCode == DOWN) {
    player2Down = true;
  }
}

void keyReleased() {
  if (key == 'w' || key == 'W') {
    player1Up = false;
  } else if (key == 's' || key == 'S') {
    player1Down = false;
  }
  
  if (keyCode == UP) {
    player2Up = false;
  } else if (keyCode == DOWN) {
    player2Down = false;
  }
}

// Cerrar el puerto serial al finalizar el programa
void dispose() {
  if (myPort != null) {
    myPort.stop();
  }
  super.dispose();
}
