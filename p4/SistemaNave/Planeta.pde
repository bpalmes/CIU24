class Planeta{
  
  PShape body;
  PImage texture;
  float rotation;
  float translation;
  float orbitRadius;
  float bodyRadius;
  float tilt;
  
  PVector position;


  Planeta(PImage texture, float rotation, float translation, float orbitRadius, float bodyRadius, float tilt){
    this.texture = texture;
    this.rotation = rotation;
    this.translation = translation;
    this.orbitRadius = orbitRadius;
    this.bodyRadius = bodyRadius;  
    this.tilt = tilt; 
    createBody();
    setMovement();
  }
  
  void createBody(){    
    beginShape();
    body = createShape(SPHERE, bodyRadius);
    body.setStroke(255);
    body.setTexture(texture);
    endShape(CLOSE);
  }
  
  void setMovement(){
    rotateZ(radians(tilt));
    rotateY(radians(ang * translation));
    translate(orbitRadius, 0, 0);
    rotateY(radians(ang * rotation));
    shape(body);
  }
  
  float getTranslation(){
    return translation;
  }
}
