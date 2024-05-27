import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer song;
BeatDetect beat;

void setupAudio() {
  minim = new Minim(this);
  song = minim.loadFile("imperial.mp3", 1024);
  song.play();
  
  beat = new BeatDetect();
  beat.setSensitivity(300); // Ajusta la sensibilidad según sea necesario
}

void detectBeat() {
  beat.detect(song.mix);
}
