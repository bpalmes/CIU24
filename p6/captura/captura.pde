import java.lang.*;
import processing.video.*;
import cvimage.*;
import org.opencv.core.*;
//Detectores
import org.opencv.objdetect.CascadeClassifier;
//Máscara del rostro
import org.opencv.face.Face;
import org.opencv.face.Facemark;

Capture cam;
CVImage img;

//Detectores
CascadeClassifier face;
//Máscara del rostro
Facemark fm;
//Nombres
String faceFile, modelFile;

boolean boca = false;
int dim;

void setup() {
  size(640, 480);
  //Cámara
  cam = new Capture(this, width , height);
  cam.start(); 
  
  //OpenCV
  //Carga biblioteca core de OpenCV
  System.loadLibrary(Core.NATIVE_LIBRARY_NAME);
  println(Core.VERSION);
  img = new CVImage(cam.width, cam.height);
  
  //Detectores
  faceFile = "haarcascade_frontalface_default.xml";
  //Modelo de máscara
  modelFile = "face_landmark_model.dat";
  fm = Face.createFacemarkKazemi();
  fm.loadModel(dataPath(modelFile));
  
  dim = cam.width * cam.height;
}

void draw() {  
  if (cam.available()) {
    background(0);
    cam.read();
    
    //Condicion 
    if(boca) {
      umbraliza();
    }
    
    img.copy(cam, 0, 0, cam.width, cam.height, 
    0, 0, img.width, img.height);
    img.copyTo();
    image(img,0,0);
    
    
    Point [] pts = {};
    ArrayList<MatOfPoint2f> shapes = detectFacemarks(cam);
    PVector origin = new PVector(0, 0);
    for (MatOfPoint2f sh : shapes) {
        pts = sh.toArray();
        
    }
    
    boca = bocaAbierta(pts, origin);
  }
  

}



void umbraliza() {
  for (int i = 0; i < dim; i++) {
      float  suma=red(cam.pixels[i])+green(cam.pixels[i])+blue(cam.pixels[i]);
      
      if (suma<255*1.5) {
        cam.pixels[i]=color(0, 0, 0);
      } else {
        cam.pixels[i]=color(255, 255, 255);
      }
  }
  cam.updatePixels();
}

void rgbMax() {
  for (int i = 0; i < dim; i++) {
    
    if(red(cam.pixels[i]) >= blue(cam.pixels[i])) {
      if(red(cam.pixels[i]) >= green(cam.pixels[i])) {
        cam.pixels[i]=color(255, 0, 0);
        
      } else {
        cam.pixels[i]=color(0, 255, 0);
      } 
    } else {
      if(blue(cam.pixels[i]) >= green(cam.pixels[i])) {
        cam.pixels[i]=color(0, 0, 255);
        
      } else {
        cam.pixels[i]=color(0, 255, 0);
      }
    }
  }
  cam.updatePixels();
}

boolean bocaAbierta(Point [] p, PVector o) {
  if(p.length >= 68) return p[67].y + o.y -( p[61].y + o.y) > 10  && p[66].y + o.y -( p[62].y + o.y) > 10 && p[65].y + o.y -( p[63].y + o.y) > 10;
  return false;
}

private ArrayList<MatOfPoint2f> detectFacemarks(PImage i) {
  ArrayList<MatOfPoint2f> shapes = new ArrayList<MatOfPoint2f>();
  CVImage im = new CVImage(i.width, i.height);
  im.copyTo(i);
  MatOfRect faces = new MatOfRect();
  Face.getFacesHAAR(im.getBGR(), faces, dataPath(faceFile)); 
  if (!faces.empty()) {
    fm.fit(im.getBGR(), faces, shapes);
  }
  return shapes;
}


private void drawFacemarks(Point [] p, PVector o) {
  pushStyle();
  noStroke();
  fill(255);
  for (Point pt : p) {
    ellipse((float)pt.x+o.x, (float)pt.y+o.y, 3, 3);
  }
  popStyle();
}
