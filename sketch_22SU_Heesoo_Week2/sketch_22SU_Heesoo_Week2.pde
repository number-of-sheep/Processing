// 20211184 Hee Soo Yang
// WK2 : Changes made from tutorial-02_processing-imagemapping2.pdf
// example in 7. Abstraction 3: Text

// I changed the code to repeatedly draw the text again and again
// to show the image file gradually

import processing.pdf.*;
import java.util.Calendar;

PFont font;
PImage img;

// text line changed - from notes about processing
String text = "Processing is an open source programming language and environment for people who want to program images, animation, and sound. A Processing program is called a sketch. Sketches are stored in the sketchbook, a folder that is used as the default location for saving all of our projects. If we need to do something that is not available in Processing, we can use a library that adds the functionality we need. Processing uses the upper-left corner for the origin of the window. The behavior of a function is defined by its parameters, a set of arguments enclosed in parentheses. Processing includes a group of functions to draw basic shapes.";
float fontSizeMax = 14;
float fontSizeMin = 8;
float spacing = 5;
float kerning = 8;
int border = 10;
int counter;

void setup() {
  size(1000, 1000);
  background(255);
  font = createFont("Times", 10);
  img = loadImage("image.jpg");
  img.resize(width, height);
  // deleted the noLoop() function to stack up the text visualization
}

void draw() {
  // set the counter to be random point within the text
  counter = int(random(text.length()));
  for (int y = border+5; y < height-border+5; y+=spacing) {
    for (int x = border; x < width-border; x+=kerning) {
      color c = img.get(x, y);
      float b = brightness(c);
      b = map(b, 0, 255, fontSizeMax, fontSizeMin);
      float fontSize = b;
      textFont(font, fontSize);
      fill(c);
      
      char letter = text.charAt(counter);
      text(letter, x, y);
      counter++;
      if (counter == text.length()) {
        counter = 0;
      }
    }
  }
  endRecord();
}

void keyReleased() {
  if (key == 's' || key == 'S') saveFrame(timestamp()+"_##.png");
}

String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}
