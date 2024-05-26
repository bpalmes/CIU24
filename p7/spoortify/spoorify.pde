import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer song;
AudioMetaData data;
BeatDetect beat;
FFT fft;

BeatLine beatLine;

boolean paused, ended, muted;

PImage bg;


void setup() {
  size(900, 600, P3D);
  bg = loadImage("black.jpg");
  beatLine = new BeatLine();
  ended = false;
  muted = false;
  minim = new Minim(this);
  song = minim.loadFile("music/letitbe.mp3");
  data = song.getMetaData();
  fft = new FFT(song.bufferSize(), song.sampleRate());
  beat = new BeatDetect(song.bufferSize(), song.sampleRate());
  beat.setSensitivity(100);
  song.play();
}

void draw() {
  background(bg);
  if (song.isPlaying()) {
    fft.forward(song.mix);
    beat.detect(song.mix);
    beatLine.show();
    showTimeLine();
    ended = song.position() == song.length();
  }
  infoStatus();
  showHelp();
}

void infoStatus() {
  textAlign(CENTER);
  fill(255, 255, 255);
  textSize(32);

  if (paused) {
    textSize(25);
    text("PAUSA", width / 2, height / 2 - 50);
    textSize(25);
    text("Pulsa espacio para continuar.", width / 2, height / 2);
  }
  if (ended) {
    textSize(25);
    text("Fin", width / 2, height / 2 - 50);
    textSize(12);
    text("Pulsa R para reiniciar la cancion o Esc para salir", width / 2, height / 2 + 50);
  }
  if (muted) {
    textSize(25);
    text("MUTE", width / 2, height / 2 - 50);
  }
}

void showTimeLine() {
  colorMode(RGB, 255, 255, 255);
  stroke(120);
  strokeWeight(4);
  line(50, height - 100, width - 50, height - 100);
  float position = map(song.position(), 0, song.length(), 50, width - 50);
  stroke(45, 110, 165);
  line(50, height - 100, position, height - 100);
  textSize(18);
  fill(255, 255, 255);
  text(TimeToString(song.length()), width - 100, height - 80);
  text(TimeToString(song.position()), 100, height - 80);
  strokeWeight(1);
}

String TimeToString(int milisecond) {
  String second = nf(milisecond / 1000 % 60, 2);
  String minutes = nf(milisecond / 1000 / 60, 2);
  return minutes + ":" + second;
}

void showHelp() {
  textAlign(LEFT);
  textSize(12);
  fill(255);
  text("Pulsa la tecla A o B para retrasar o adelantar la reproduccion 10s", 10, 20);
  text("Con la tecla M puede silenciar la cancion", 10, 40);
  text("Con la P se pausa la cancion", 10, 60);
  text("Escape para cerrar la App", 10, 80);
}

void keyPressed() {
  if (key == 'a') song.skip(-10000);
  if (key == 'd') song.skip(10000);
  if (key == 'r') song.rewind();
  if (key == 'm') {
    if (song.isMuted()) {
      song.unmute();
      muted = false;
    } else {
      song.mute();
      muted = true;
    }
  }
  if (key == 'p') {
    song.pause();
    paused = true;
  }
  if (key == ' ') {
    song.play();
    paused = false;
  }
}
