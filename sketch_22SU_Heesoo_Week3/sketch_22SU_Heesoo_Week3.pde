// 20211184 Hee Soo Yang
// sketch_06_01

import ddf.minim.*;
PImage img[] = new PImage[5];

Minim minim;
AudioPlayer song;

int spacing = 16; // space between lines in pixels
int border = spacing*2; // top, left, right, bottom border
int amplification = 3; // frequency amplification factor
int y = spacing;
float ySteps; // number of lines in y direction
int i = 0;

void setup() {
  size(800, 800);
  strokeWeight(1);
  stroke(0);
  noFill();
  minim = new Minim(this);
  song = minim.loadFile("song.mp3");
  song.play();
  frameRate(10);
  img[0] = loadImage("image0.png");
  img[1] = loadImage("image1.png");
  img[2] = loadImage("image2.png");
  img[3] = loadImage("image3.png");
  img[4] = loadImage("image4.png");
}

void draw() {
  background(0);
  
  int screenSize = int((width-2*border)*(height-1.5*border)/spacing);
  int x = int(map(song.position(), 0, song.length(), 0, screenSize));
  ySteps = x/(width-2*border); // calculate amount of lines
  x -= (width-2*border)*ySteps; // set new x position for each line
  float freqMix = song.mix.get(int(x));
  float freqLeft = song.left.get(int(x));
  float freqRight = song.right.get(int(x));
  float amplitude = song.mix.level();
  float size = 700 + 10 * freqMix * spacing * amplification;
  float red = map(freqLeft, -1, 1, 0, 200);
  float green = map(freqRight, -1, 1, 0, 215);
  float blue = map(freqMix, -1, 1, 0, 55);
  stroke(255, amplitude*155);
  fill(red, green, blue, 200);
  ellipse(width/2, height/2, size, size);
  
  i += 1;
  if (i == 5) {
    i = 0;
  }
  for (int a = 0; a < width; a += 5) {
    for (int b = 0; b < height; b += 5) {
      color c = img[i].pixels[b*img[i].width+a];
      float alpha = alpha(c);
      stroke(0);
      alpha = map(alpha, 0, 255, 5, 1);
      if (alpha <= 1.0) {
        noStroke();
      }
      strokeWeight(alpha);
      point(a, b);
    }
  }
}

void stop() {
  song.close();
  minim.stop();
  super.stop();
}
