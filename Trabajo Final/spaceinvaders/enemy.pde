class Enemy {
  float x, y;
  float w, h;
  boolean alive = true;
  color c;
  
  Enemy(float startX, float startY) {
    x = startX;
    y = startY;
    w = 40;
    h = 20;
    c = color(255, 0, 0);
  }
  
  void display() {
    if (alive) {
      fill(c);
      rect(x, y, w, h);
    }
  }
  
  void move() {
    y += 0.7;
    if (y > height) {
      alive = false;
    }
  }
  
  void changeColor() {
    c = color(random(255), random(255), random(255));
  }
  
  boolean hits(Player p) {
    return alive && x < p.x + p.w && x + w > p.x && y < p.y + p.h && y + h > p.y;
  }
}
