// 20211184 Hee Soo Yang

char input[] = new char[6];
String letters = "852963";

float x;
float y;
float border = 100;
float d = 100;
String txt = "";
String brailleascii = " A1B'K2L@CIF/MSP\"E3H9O6R^DJG>NTQ,*5<-U8V.%[$+X!&;:4\\0Z7(_?W]#Y)=";

PFont f;

void reset() {
  for (int i = 0; i < 6; i++) {
    input[i] = 0;
  }
}

char braille_to_char() {
  char output;
  // some examples for demo
  int index = 0;
  for (int i = 0; i < 6; i++) {
    index += input[i] * pow(2, i);
  }
  output = brailleascii.charAt(index);
  return output;
}

void setup() {
  reset();
  size(1000, 500);
  x = width / 2 - d / 2;
  y = (height - border) / 2;
  strokeWeight(20);
  stroke(170);
  f = createFont("Arial", d / 2, true);
  textFont(f);
  fill(0);
}

void draw() {
  background(255);
  
  pushMatrix();
  translate(border/2, border);
  text(txt, 0, 0);
  popMatrix();
  
  pushMatrix();
  translate(x, y);
  for (int b = 0; b < 2; b++) {
    for (int a = 0; a < 3; a++) {
      if (input[a+b*3] == 1) {
        stroke(255, 204, 000, 50);
        strokeWeight(50);
        for (float i = 0; i < 2*PI-0.5; i += PI/3) {
          point(b * d + 25 * cos(i), a * d + 25 * sin(i));
        }
      } else {
        stroke(170);
        strokeWeight(20);
        point(b * d, a * d);
      }
    }
  }
  
  popMatrix();
}

void keyPressed() {
  if(keyCode == BACKSPACE) {
    int len = txt.length();
    if (len > 0) {
      txt = txt.substring(0, len-1);
    }
  }
  else if(key == ENTER) {
    txt += braille_to_char();  // need to save and print out the output
    reset();
  }
  else if(key == 'c' || key == 'C') {
    reset();
  }
  else {
    int pos = letters.indexOf(key);
    if (pos >= 0 && pos < 6) {
      // draw
      
      if (input[pos] == 1) {
        input[pos] = 0;
      } else {
        input[pos] = 1;
      }
    }
  }
}
