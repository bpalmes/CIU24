class Bullet {
  float x, y;
  float speed = 5;
  boolean active = true;
  
  Bullet(float startX, float startY) {
    x = startX;
    y = startY;
  }
  
  void update() {
    y -= speed;
    if (y < 0) {
      active = false;
    }
  }
  
  void display() {
    if (active) {
      fill(255);
      rect(x, y, 5, 10);
    }
  }
  
  boolean hits(Enemy e) {
    if (active && e.alive) {
      if (x > e.x && x < e.x + e.w && y > e.y && y < e.y + e.h) {
        active = false;
        return true;
      }
    }
    return false;
  }
}
