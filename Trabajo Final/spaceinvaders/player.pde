class Player {
  float x, y;
  float w, h;
  color c;
  
  Player() {
    x = width / 2;
    y = height - 40;
    w = 60;
    h = 20;
    c = color(0, 255, 0);
  }
  
  void display() {
    fill(c);
    rect(x, y, w, h);
  }
  
  void move(float dir) {
    x += dir * 5;
    x = constrain(x, 0, width - w);
  }
  
  void changeColor() {
    c = color(random(255), random(255), random(255));
  }
}
