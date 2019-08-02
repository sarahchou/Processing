// Drawing Machine
// Have at least two inputs (key, mouse, mic, vid) and one of each:
// rect, ellipse, line, custom shape.

// Set initial variable values
int color_value = 255;
int bg = 255;
int size_value = 10;
boolean isCircles = true;
boolean isRects = true;
boolean isCustomShapes = false;

// Set the background to white on a fullscreen.
void setup() {
  fullScreen();
  background(255);
}


// Draw shapes of different colors, sizes and placement on screen
void draw() {

  // Ellipses will be shades of red
  if (isCircles) {
    ellipseMode(CENTER);
    fill(color_value, color_value - 51, color_value - 51);
    ellipse(mouseX - (size_value * 15), mouseY + (size_value * 15), size_value + 10, size_value + 10);
    fill(color_value, color_value - 102, color_value - 102);
    ellipse(mouseX - (size_value * 10), mouseY + (size_value * 10), size_value + 20, size_value + 20);
    fill(color_value, color_value - 153, color_value - 153);
    ellipse(mouseX - (size_value * 5), mouseY + (size_value * 5), size_value + 30, size_value + 30);
    fill(color_value, color_value - 204, color_value - 204);
    ellipse(mouseX, mouseY, size_value + 40, size_value + 40);
    fill(color_value, 0, 0);
    ellipse(mouseX + (size_value * 5), mouseY + (size_value * 5), size_value + 30, size_value + 30);
    fill(color_value - 51, 0, 0);
    ellipse(mouseX + (size_value * 10), mouseY + (size_value * 10), size_value + 20, size_value + 20);
    fill(color_value - 102, 0, 0);
    ellipse(mouseX + (size_value * 15), mouseY + (size_value * 15), size_value + 10, size_value + 10);
  }
  // Rectangles will be shades of blue
  if (isRects) {
    rectMode(CENTER);
    fill(color_value - 51, color_value - 51, color_value);
    rect(mouseX - (size_value * 15), mouseY + (size_value * 15), size_value + 35, size_value + 35);
    fill(color_value - 102, color_value - 102, color_value);
    rect(mouseX - (size_value * 10), mouseY + (size_value * 20), size_value + 25, size_value + 25);
    fill(color_value - 153, color_value - 153, color_value);
    rect(mouseX - (size_value * 5), mouseY + (size_value * 25), size_value + 10, size_value + 10);
    fill(0, 0, color_value);
    rect(mouseX, mouseY + (size_value * 30), size_value, size_value);
    fill(0, 0, color_value - 51);
    rect(mouseX + (size_value * 5), mouseY + (size_value * 25), size_value + 10, size_value + 10);
    fill(0, 0, color_value - 102);
    rect(mouseX + (size_value * 10), mouseY + (size_value * 20), size_value + 25, size_value + 25);
    fill(0, 0, color_value - 153);
    rect(mouseX + (size_value * 15), mouseY + (size_value * 15), size_value + 35, size_value + 35);
  }
  // Custom Shapes: yellow and pink rhombi that align to make a rhombus shape
  if (isCustomShapes) {
    fill(color_value, color_value, 0);
    drawCustomShape(0, -10, 10, 0, -40, -80);

    fill(color_value, 0, color_value);
    drawCustomShape(-30, -40, -20, 70, 30, -20);

    fill(color_value, color_value - 51, color_value);
    drawCustomShape(30, 40, 20, 70, 30, -20);

    fill(color_value, color_value, color_value - 51);
    drawCustomShape(0, -10, 10, 60, 100, 140);
  }
}

// Helper function that takes in 3 x values and 3 y values to create a rhombus
void drawCustomShape(int x1, int x2, int x3, int y1, int y2, int y3) {
  stroke(0);
  beginShape();
  vertex(mouseX + x1, mouseY + y1);
  vertex(mouseX + x2, mouseY + y2);
  vertex(mouseX + x1, mouseY + y3);
  vertex(mouseX + x3, mouseY + y2);
  vertex(mouseX + x1, mouseY + y1);
  endShape();
}

// Set shape booleans
void setShapeBools(boolean c, boolean r, boolean s) {
  isCircles = c;
  isRects = r;
  isCustomShapes = s;
}

// Change the background color from black to white or white to black
void changeBackgroundColor() {
  switch(bg) {
  case 0: 
    background(255);
    bg = 255;
    break;
  case 255:
    background(0);
    bg = 0;
    break;
  }
}

// Click to reset the background to black
void mousePressed() {
  changeBackgroundColor();
}

// Handle key events
/*
Key Events:
 1, space: change background from black to white or white to black
 2, l: change the shades of the shapes to lighter
 3, d: change the shades of the shapes to darker
 4, r: change the shapes to only rectangles
 5, c: change the shapes to only cirles
 6, b: include Both rectangles and circles
 7, s: change the shapes to Special Shape
 8, a: include all shapes
 9: change the background to red
 0: change the background to blue
 */
void keyPressed() {
  {
    switch(keyCode) {
    case UP: 
      mouseY = mouseY - 60;
      break;
    case DOWN:
      mouseY = mouseY + 60;
      break;
    case LEFT:
      mouseX = mouseX - 60;
      break;
    case RIGHT:
      mouseX = mouseX + 60;
      break;
    }

    //for ASCII characters

    switch(key) {
      //press the SPACE to clean the background
    case 32:
      changeBackgroundColor();
      break;
      //press the 1 to clean the background
    case 49:
      changeBackgroundColor();
      break;
      //press "l" to make the shades Lighter
    case 108:
      if (color_value <= 255) {
        color_value = color_value + 25;
      }
      break;
      //press 2 to make the shades Lighter
    case 50:
      if (color_value <= 255) {
        color_value = color_value + 25;
      }
      break;
      //press "d" to make the shades Darker
    case 100:
      if (color_value >= 0) {
        color_value = color_value - 25;
      }
      break;
      //press 3 to make the shades Darker
    case 51:
      if (color_value >= 0) {
        color_value = color_value - 25;
      }
      break;
      //press r for Rectangles
    case 114:
      setShapeBools(false, true, false);
      break;
      //press 4 for Rectangles
    case 52:
      setShapeBools(false, true, false);
      break;
      // press c for Circles
    case 99:
      setShapeBools(true, false, false);
      break;
      // press 5 for Circles
    case 53:
      setShapeBools(true, false, false);
      break;
      // press b for Both circles and rectangles
    case 98:
      setShapeBools(true, true, false);
      break;
      // press 6 for Both circles and rectangles
    case 54:
      setShapeBools(true, true, false);
      break;
      //press s for Special shape
    case 115:
      setShapeBools(false, false, true);
      break;
      //press 7 for Special shape
    case 55:
      setShapeBools(false, false, true);
      break;
      //press a for All shapes
    case 97:
      setShapeBools(true, true, true);
      break;
      //press 8 for All shapes
    case 56:
      setShapeBools(true, true, true);
      break;
      //press 9 to change the background to red
    case 57:
      background(255, 0, 0);
      break;
      //press 0 to change the background to blue
    case 48:
      background(0, 0, 255);
      break;
    }
  }
}
