class BeatLine {
  BeatLine() {}

  void show() {
    colorMode(HSB, 360, 100, 100);
    float centerX = width / 2;
    float centerY = height / 2;
    float scaleFactor = 0.5;
    strokeWeight(2);
    for (int i = 0; i < fft.specSize(); i++) {
      float amplitude = fft.getBand(i) * scaleFactor;
      stroke(map(i, 0, fft.specSize(), 0, 360), 100, 100);
      line(centerX - fft.specSize() / 2 + i, centerY, centerX - fft.specSize() / 2 + i, centerY - amplitude);
    }
  }
}
