/**
 / Sarah Chou
 / Creative Coding 
 / Art in Austria
 / Data Input Assignment 4
*/

import processing.video.*;
import java.util.*;

//initialize global variables
Capture video;
boolean pause, startParty, showSongs, friendMode;
int[] data;
int counter = 0;

void setup() {
  fullScreen();
  //read the list of color hues from the data file 
  String[] lines = loadStrings("colors.txt");
  data = int(split(lines[0], ','));
  setupAudio();

  //allow for live video, set the size of the screen
  video = new Capture(this, width, height);
  video.start();
  frameRate(7);

  //set variables
  pause = false;
  startParty = false;
  showSongs = false;
  friendMode = false;
  colorMode(HSB, 360, 100, 100);
}

void removeStartMessage() {
  startParty = true;
}

void showSongTitles() {

  String song1 = "Press 1 for: Feel Good | Illenium";
  String song2 = "Press 2 for: Takeaway | Illenium";
  String song3 = "Press 3 for: Good Things Fall Apart| Illenium";
  String song4 = "Press 4 for: Old Town Road | Lil Nas X ft Billy Ray Cyrus";
  String song5 = "Press 5 for: Mii Song | Wii";
  String song6 = "Press 6 for: Friday Night | Tim Robinson and Greg Chun ";
  String song7 = "Press 7 for: Despacito | Luis Fonsi & Daddy Yankee";
  String song8 = "Press 8 for: Bet On It | HSM";
  String song9 = "Press 9 for: I Want It That Way | Backstreet Boys";

  String[] songTitles = new String[] { song1, song2, song3, song4, song5, song6, song7, song8, song9};
  int xPos = width / 2;
  int yPos = 280;

  if (showSongs) {
    for (String song : songTitles) {
      textAlign(CENTER);
      fill(255);
      textSize(14);
      text(song, xPos, yPos);
      yPos += 20;
    }
  }
}

void drawVideos(int hue, int sat, int bright) {
  tint(hue, sat, bright);
  image(video, 0, 0, width, height);
}

void drawFriends(int hue, int sat, int bright) {
  tint(hue, sat, bright);
  //changing size based on volume
  float size = song.left.get(1) * 700;
  float position = height - 70;

  //load images of friends
  PImage bsb = loadImage("images/backstreetboys.png");
  PImage illenium = loadImage("images/illenium.png");
  PImage lilnasx = loadImage("images/lilnasx.png");
  PImage tim = loadImage("images/timrobinson.png");
  PImage wii = loadImage("images/wii.png");
  PImage zac = loadImage("images/zacefron.png");

  PImage[] pics = new PImage[] { bsb, illenium, lilnasx, tim, wii, zac };
  int startPosition = width / pics.length;
  for (PImage pic : pics) {
    image(pic, startPosition, position, size, size);
    startPosition += 160;
  }
}

void drawLasers() {
  //HSB colors:
  int red = 0;
  int orange = 30;
  int yellow = 60;
  int lightGreen = 90;
  int darkGreen = 150;
  int lightBlue = 180;
  int blue = 210;
  int darkBlue = 240;
  int purple = 270;
  int pink = 300;
  int darkPink = 330;

  int[] colorArray = new int[] { red, orange, yellow, lightGreen, darkGreen, lightBlue, blue, darkBlue, purple, pink, darkPink };
  //for each color in the color array, draw a laser in that color at different spots on the ceiling
  for (int i = 0; i < colorArray.length; i ++) {

    float volume = song.left.get(i) * i;

// laser length is controlled by beat and color is controlled by volume
    //top left
    stroke(colorArray[i] * song.left.get(1) * i, 60, 100);

    line(width / 4, 0, (width / colorArray.length) * i, (height / (counter + 1)) * 5);
    //middle
    strokeWeight(9);
    stroke(colorArray[i], 100, 100, 50);

    line(width / 2, 0, (width / colorArray.length) * i, (height / (counter + 5)) * 10);
    //top right
    strokeWeight(1);
    stroke(colorArray[i] * song.left.get(1) * i, 60, 100);
    line((width / 4) * 3, 0, (width / colorArray.length) * i, (height / (counter + 1)) * 5);
    
    //left side
    stroke(colorArray[i] * song.left.get(1) * i * 10, 100, 60);
    line(0, height / 2, 3 *width / 2 * volume, (height / (counter + 1)) * 5);
    //right side
    stroke(colorArray[i] * song.left.get(1) * i, 100, 60);
    line(width, height / 2, width / 2 * volume, (height / (counter + 1)) * 5);
  }
}

void draw() {
  if (video.available()) {
    video.read();
  }

  drawVideos(data[counter], 80, 80);
  beat.detect(song.mix);
  
  if (friendMode) { drawFriends(data[counter], 80, 80); }
  drawLasers();

  //increment the color changing counter on beat:
  if (beat.isKick()) {
    counter = (counter + 1) % data.length;
  }

  if (!startParty) {
    textAlign(CENTER);
    String startMessage = "Press any number to choose a song and start the party!";
    String moreInstructions = "Press 's' for song choices";
    String friends = "Press 'f' to Activate FriendMode and 'n' for No Friends";
    textSize(20);

    fill(255);
    text(startMessage, (width / 2)-40, 20, 160, 190);
    textSize(14);
    text(moreInstructions, (width / 4) - 40, 200, 160, 190);
    text(friends, 3 * (width / 4), 200, 160, 190);
  }

  if (showSongs) {
    showSongTitles();
  }
}

void captureEvent(Capture video) {
  video.read();
}

void keyPressed() {
  //pause/play the song if space is pressed
  if (key == ' ') {    
    showSongTitles();
    pause = !pause;
    if (pause) {
      song.pause();
    } else {
      song.play();
    }
  }
  //choose the song based on the number pressed
  if (Character.isDigit(key)) { 
    chooseSong(Character.getNumericValue(key));
    showSongs = false;
    removeStartMessage();
  }
  //press s for songs
  if (key == 's') {
    showSongs = true;
    showSongTitles();
  }
  //press f for friends
  if (key == 'f') {
    friendMode = true;
  }
  //press n for no friends
  if (key == 'n') {
    friendMode = false;
  }
}
