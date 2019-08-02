import java.util.*;

//initialize variables
Random g = new Random();

//new Random().nextInt((max - min) + 1) + min

int r = 100;
int counter = 0;
int howManyCircles = 6;
int[] circleXLocations = new int[howManyCircles];
int[] circleYLocations = new int[howManyCircles];

void addRandomCircleLocations() {
  for (int i = 0; i < howManyCircles; i ++) {
    // in between 40 and 1280 - 40 (so it doesn't draw off screen)
    circleXLocations[i] = g.nextInt((1280 - 40) + 1) + 40;
    // in between 40 and 800 - 40 (so it doesn't draw off screen)
    circleYLocations[i] = g.nextInt((800 - 40) + 1) + 40;
  }
}

void setup() {
  fullScreen();
  background(0);
  frameRate(14);
  addRandomCircleLocations();
}

//Draw one series of circles in a circular shape
void drawCircleSeries(int centerX, int centerY, int randoSize) { 
  //set the math to draw in a circular shape
  float t = millis()/1000.0f;
  if (randoSize == 140) { r = 140; } //if the circles are bigger, make the radius bigger. 
  if (randoSize == 80) { r = 100; } //added this
  int x = (int)(centerX+r*cos(t)); 
  int y = (int)(centerY+r*sin(t)); 

  //set the random size of each individual ellipse (equal width and height)
  int rando = g.nextInt(randoSize);

  //draw an ellipse
  ellipse(x, y, rando, rando); 

  //increment the counter: how many little circles are in the series 
  counter ++;
}

//Draw circle series if it's in between the current last circle number and the next circle number (i.e.: between 90 and 180 for the first and third circle)
//starts drawing circle series after the first circle has stopped, stops drawing circle series before the next circle series starts
void drawCircles(int lowerCounter, int upperCounter, int i) {
  
  int sizeOfCircles = 80;
  //if it is an even i, make it range to be bigger
  if (i % 2 == 0) {
    sizeOfCircles = 140;
  }
  if (counter > lowerCounter && counter <= upperCounter) {
    drawCircleSeries(circleXLocations[i], circleYLocations[i], sizeOfCircles);
  }
}


void draw() {
  ellipseMode(CENTER);
  //random color chooser
  stroke(g.nextInt(256), g.nextInt(256), g.nextInt(256));
  noFill();
  int lowerCounter = 90;
  //draw howManyCircles
  for (int i = 0; i < howManyCircles; i ++) {
    if (i == 0) {
      if (counter <= lowerCounter) {
        drawCircleSeries(circleXLocations[0], circleYLocations[0], 80);
      }
    } else {
      drawCircles(lowerCounter, lowerCounter + 90, i); 
      lowerCounter += 90;
    }
  }
}

void mousePressed() {
  r += 40;
}

void keyPressed() {
  switch(key) {
    //press the SPACE to save a screenshot
  case 32:
    saveFrame();
    break;
  }
}
