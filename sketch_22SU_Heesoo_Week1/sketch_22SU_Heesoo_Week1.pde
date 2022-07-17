// 20211184 Hee Soo Yang
// WK1 : Changes made from tutorial-01_processing-introduction2.pdf
// example 19.3 Polygon Scribble

import java.util.Calendar;  // to export the screenshots of the results as .png file

int points = 10;  // number of points guiding the shape of polygon
float[] angle1 = new float[points];
float[] angle2 = new float[points];  // two angles to determine three coordinates
float[] x = new float[points];
float[] y = new float[points];
float[] z = new float[points];  // three coordinates to describe 3D shape

float variance = 10;
int iterations = 100;  // this two parts are the same as the example, while
float border = 10;  // this is the border to keep the shape in the screen size
boolean pause = false;
// and this boolean variable makes the draw() function pause/play when space bar is pressed

void setup() {
  size(800, 800, P3D);  // 3D
  noFill();
  frameRate(15);  // slow down the framRate to 15fps
}

/*
Instead of using the specific points for the starting point as the example,
I chose to randomly pick two angles for a point
and set its x, y, z values.

The radius for each polygon is also set randomly.
*/

void draw() {
  background(255);  // Since I removed the noLoop() function, background() should be in the draw() section
  translate(width/2, height/2, 0);  // move the origin to the center of the sketch
  
  // randomly set the radius and the points
  float radius = random(50, width/2 - border);
  for (int i = 0; i < points; i++) {
    angle1[i] = random(0, TWO_PI);
    angle2[i] = random(0, PI/2);
    x[i] = cos(angle1[i]) * radius;
    y[i] = sin(angle1[i]) * radius;
    z[i] = - cos(angle2[i]) * radius;
  }
  
  // vary the coordinate values for each point
  for (int a = 0; a < iterations; a++) {
    for (int i = 0; i < points; i++) {
      x[i] += random(-variance, variance);
      y[i] += random(-variance, variance);
      z[i] += random(-variance, variance);
    }
    
    // if the user click the mouse button, the color of the polygons are randomly changed
    // and also be more thicker,
    // while normally it is set to be dark grey with thin lines
    if (mousePressed) {
      stroke(random(255), random(255), random(255), 50);
      strokeWeight(3);
    } else {
      stroke(0, 20);
      strokeWeight(1.5);
    }
    
    // draw the shape with the z coordinate
    beginShape();
    curveVertex(x[points-1], y[points-1], z[points-1]);
    for (int i = 0; i < points; i++) {
      curveVertex(x[i], y[i], z[i]);
    }
    curveVertex(x[0], y[0], z[0]);
    curveVertex(x[1], y[1], z[1]);
    endShape();
  }
}

void keyPressed() {
  if (key == 's' || key == 'S') {  // when 'S' is pressed, the program saves the result as a .png file
    saveFrame(timestamp() + ".png");
  } else if (key == ' ') {  // and when the space bar is pressed, the program is paused/played
    pause = !pause;
    if (pause) {
      noLoop();
    } else {
      loop();
    }
  }
}

/*

*** Here's Something I want to improve ***

This program doesn't let me save the screenshot of the program with the 'S' key
when the program is paused by pressing space bar.
How can I solve this problem
and be able to save the screenshot even though it is paused?

*/

// this function is for saving the screenshots
String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1td_%1$tH%1$tM%1$tS", now);
}
