class Planet {
  float centerX, centerY;
  float orbitRadius;
  float angle; // Ángulo de la órbita
  float rotationSpeed; // Velocidad de la órbita
  float radius;
  color c;
  
  Planet(float centerX, float centerY, float orbitRadius, float radius, float rotationSpeed) {
    this.centerX = centerX;
    this.centerY = centerY;
    this.orbitRadius = orbitRadius;
    this.radius = radius;
    this.angle = 0;
    this.rotationSpeed = rotationSpeed;
    this.c = color(255);
  }
  
  void display() {
    float x = centerX + cos(angle) * orbitRadius;
    float y = centerY + sin(angle) * orbitRadius;
    fill(c);
    ellipse(x, y, radius*2, radius*2);
    angle += rotationSpeed;
  }
  
  void changeColor() {
    c = color(random(100), random(100), random(100));
  }
}
