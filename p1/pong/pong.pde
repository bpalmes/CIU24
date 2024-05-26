float ballX, ballY, ballWidth, ballHeight;
float ballSpeedX, ballSpeedY;

int playerWidth, playerHeight, playerSpeed;
int player1X, player1Y, player2X, player2Y;
boolean player1Up, player1Down, player2Up, player2Down;

int player1Score = 0;
int player2Score = 0;
int winScore = 10;

boolean start, win;





void setup() {
  win = false;
  size(1152,640);
  ballX = width/2; 
  ballY = height/2;
  ballWidth = 20;
  ballHeight = 20;
  ballSpeedX = 5.0;
  ballSpeedY = 4.0;
  playerWidth = 30;
  playerHeight = 100;
  player1X = playerWidth;
  player1Y = height/2 - playerHeight/2;
  player2X = width - playerWidth*2;
  player2Y = height/2 - playerHeight/2;
  playerSpeed = 5;
  
  
}
//Todo se inicia con el metodo draw()
void draw() {
  
  if(mousePressed) start = true;
  
  drawField(255);
  scores();
  drawPlayers();
  gameOver();
  
  if(start){
    drawBall();
    moveBall();
    control();
    Players();
    controlPlayers();
    contactWithPlayer();
  } else if(!win) clickToStart();
    
}

//Dibujamos el escenario
void drawField(int n){
  fill(n);
  background(0);
  stroke(1000);
  rect(20,20,width-40,20);
  rect(20,height-40,width-40,20);
  
  for(int i = 2; i <= 52; i+=2)
    rect(width/2,20*i,20,20);
}

//Instrucciones para iniciar
void clickToStart(){
  fill(255);
  textSize(30);
  text("Click to start", width/2 + 30, height/3 - 40);
}

//Dimensiones de la pelota
void drawBall() {
  rect(ballX, ballY, ballWidth, ballHeight);
}
//Movimiento de la pelota
void moveBall() {
  ballX = ballX + ballSpeedX;
  ballY = ballY + ballSpeedY;
}

//Juego y mecanica de anotación
void control() {
 if ( ballX > width - ballWidth) {
    
    setup();
    ballSpeedX = -ballSpeedX;
    player1Score = player1Score + 1;
  } else if (ballX < ballWidth/2) {
   
    setup();
    player2Score = player2Score + 1;
  }
  
  if ( ballY > height-40 - ballHeight) {
    
    ballSpeedY = -ballSpeedY;
  } else if ( ballY < 40) {
   
    ballSpeedY = -ballSpeedY;
  }
}

//Dibujar las plataformas de los jugadores
void drawPlayers() {
  rect(player1X, player1Y, playerWidth, playerHeight);
  rect(player2X, player2Y, playerWidth, playerHeight);
}

//movimiento de las plataformas controlado por valores boleanos que cambian si pulsas o no los botones de control
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

//controlador del eje Y de las plataformas
void controlPlayers() {
  if (player1Y < 45) {
    player1Y = 45;
  } else if (player1Y + playerHeight > height-45) {
    player1Y = height - (playerHeight + 45);
  }
  
  if (player2Y < 45) {
    player2Y = 45;
  } else if (player2Y + playerHeight > height-45) {
    player2Y = height - (playerHeight + 45);
  }
}

//Control de colisiones entre la bola y las plataformas de los jugadores
void contactWithPlayer() {
  if (ballX  < player1X + playerWidth && ballY < player1Y + playerHeight && ballY + ballHeight > player1Y ) {
    if (ballSpeedX < 0) {
      
      ballSpeedX = -ballSpeedX*1.05;
    }
  }
  else if (ballX + ballWidth > player2X  && ballY < player2Y + playerHeight && ballY + ballHeight  > player2Y) {
    if (ballSpeedX > 0) {
      
      ballSpeedX = -ballSpeedX*1.05;
    }
  }
}
//MArcadores
void scores() {
  textSize(100);
  text(player1Score, 100, 110);
  text(player2Score, width-130, 110);
}

void gameOver() {
  if(player1Score == winScore) {
    gameOverPage("Player 1 wins!");
  } else if(player2Score == winScore) {
    gameOverPage("Player 2 wins!");
  }
}
//dibujar fin de partida
void gameOverPage(String text) {
  start = false;
  ballSpeedX = 0.0;
  ballSpeedY = 0.0;
  
  if(!win) {
    
    win = true;
  }
  
  drawField(0);
  fill(255);
  textSize(60);
  text("Fin de la partida", width/2 - 140, height/3 - 40);
  text(text, width/2 - 200, height/3);
  text("\nClick para empezar", width/2 - 290, height/3 + 40);
  
  if(mousePressed){
    win = false;
    player1Score = 0;
    player2Score = 0;
    ballSpeedX = 5.0;
    ballSpeedY = 4.0;
  }
}
 
 //Condiciones y botones para jugar
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
