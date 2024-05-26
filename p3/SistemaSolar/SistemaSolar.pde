//import gifAnimation.*;
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

PImage satellite1Texture;

boolean drag;

float rotateX, rotateY;

//GifMaker gif;
int gifCount = 0;

void setup()
{
  size(736,368,P3D);
  stroke(0);
  backgroundTexture = loadImage("space.jpg");
  solTexture = loadImage("sol.jpg");
  venusTexture = loadImage("venus.jpg");
  jupiterTexture = loadImage("jupiter.jpg");
  tierraTexture = loadImage("tierra.jpg");
  lunaTexture = loadImage("luna.jpg");
  
  ang = 0;
  rotateX = 0;
  rotateY = 0;
  
  //gif = new GifMaker(this, ".gif");
  //gif.setRepeat(0);
}


void draw()
{
  background(backgroundTexture);
  
  translate(width/2, height/2, -500);
  textSize(60);
  text("- Usa el raton para girar la camara",-width/2-500, height/2+200);
  if (drag) {
    rotateY += mouseX - pmouseX;
    rotateX += mouseY - pmouseY;
  }
  
  rotateY(radians(rotateY));
  rotateX(-radians(rotateX));
  pushMatrix();
  star1 = new Planeta(solTexture, 2, 0, 0, 100, 0);
  popMatrix();
  pushMatrix();
  
  venus = new Planeta(venusTexture, 1, -1.3, -200, 20, 0);
  popMatrix();
  pushMatrix();
  
  tierra= new Planeta(tierraTexture, 1.2, 2, -400, 35, -8);
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


  

  ang=ang+0.25;
  if (ang>1000){
    ang=0;
  }
  //gif();
}
void mouseReleased(){
  drag = false;
}

void mouseDragged(){
  if (mousePressed){
    drag = true;
  }
}
/*
void gif(){
  if(gifCount % 5 == 0 && gifCount > 500){
    gif.addFrame();    
  }
  if(gifCount > 700){
     gif.finish(); 
  }
  gifCount++;
}
*/
