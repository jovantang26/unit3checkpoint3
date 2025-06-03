//Jovan Tang
//May 29 2025

//Unit 3 Checkpoint #3
//3D Enviornmental Sketch

import java.awt.Robot;

Robot rbt;

//color pallette
color black = #000000;
color white = #ffffff;

//map variable
int gridSize;
PImage map;

boolean wKey, aKey, sKey, dKey, spaceKey, shiftKey;
float eyeX, eyeY, eyeZ, focusX, focusY, focusZ, tiltX, tiltY, tiltZ; //eye = keyboard, focus = mouse, tilt = irrelevant
float leftRightHeadAngle, upDownHeadAngle;

void setup() {
  fullScreen(P3D);
  textureMode(NORMAL);
  wKey = aKey = sKey = dKey = false;
  eyeX = width/2;
  eyeY = height/2;
  eyeZ = 0;
  focusX = width/2;
  focusY = height/2;
  focusZ = 10;
  tiltX = 0;
  tiltY = 1;
  tiltZ = 0;
  leftRightHeadAngle = radians(90);
  noCursor();

  try {
    rbt = new Robot();
  }
  catch(Exception e) {
    e.printStackTrace();
  }

  map= loadImage("map.png");
  gridSize = 100;
}

void draw() {
  background(0);
  camera(eyeX, eyeY, eyeZ, focusX, focusY, focusZ, tiltX, tiltY, tiltZ);
  drawFloor();
  drawFocalPoint();
  controlCamera();
  drawMap();
}

void drawMap() {
  for (int x = 0; x < map.width; x++) {
    for (int y = 0; y < map.height; y++) {
      color c = map.get(x, y); 
      if (c != white) {
        pushMatrix(); 
        fill(c); 
        stroke(100); 
        translate(x*gridSize-5000, height, y*gridSize-5000); 
        box(gridSize, 50, gridSize); 
        popMatrix(); 
      }
    }
  }
}

void drawFocalPoint() {
  pushMatrix();
  translate(focusX, focusY, focusZ);
  sphere(5); //lwk ts a crosshair gng
  popMatrix();
}

void drawFloor() {
  stroke(255);
  for (int x = -5000; x <= 5000; x = x + 100) {
    line(x, height, -5000, x, height, 5000);
    line(-5000, height, x, 5000, height, x);
  }
}

void controlCamera() {
  if (wKey) {
    eyeZ = eyeZ + sin(leftRightHeadAngle)*10;
    eyeX = eyeX + cos(leftRightHeadAngle)*10;
  }
  if (sKey) {
    eyeZ = eyeZ - sin(leftRightHeadAngle)*10;
    eyeX = eyeX - cos(leftRightHeadAngle)*10;
  }
  if (aKey) {
    eyeZ = eyeZ - sin(leftRightHeadAngle+radians(90))*10;
    eyeX = eyeX - cos(leftRightHeadAngle+radians(90))*10;
  }
  if (dKey) {
    eyeZ = eyeZ + sin(leftRightHeadAngle+radians(90))*10;
    eyeX = eyeX + cos(leftRightHeadAngle+radians(90))*10;
  }
  if (spaceKey) eyeY = eyeY -10;
  if (shiftKey) eyeY = eyeY + 10;

  leftRightHeadAngle = leftRightHeadAngle + (mouseX - pmouseX)*0.01;
  upDownHeadAngle = upDownHeadAngle + (mouseY - pmouseY)*0.01;
  if (upDownHeadAngle > PI/2.5) upDownHeadAngle = PI/2.5;
  if (upDownHeadAngle < -PI/2.5) upDownHeadAngle = -PI/2.5;

  focusX = eyeX+cos(leftRightHeadAngle)*500;
  focusZ = eyeZ+sin(leftRightHeadAngle)*500;
  focusY = eyeY + tan(upDownHeadAngle)*500;

  if (mouseX > width-2) rbt.mouseMove(3, mouseY);
  else if (mouseX < 2) rbt.mouseMove(width-3, mouseY);
}

void keyPressed() {
  if (key == 'W' | key == 'w') wKey = true;
  if (key == 'A' | key == 'a') aKey = true;
  if (key == 'S' | key == 's') sKey = true;
  if (key == 'D' | key == 'd') dKey = true;
  if (key == ' ') spaceKey = true;
  if (keyCode == SHIFT) shiftKey = true;
}

void keyReleased() {
  if (key == 'W' | key == 'w') wKey = false;
  if (key == 'A' | key == 'a') aKey = false;
  if (key == 'S' | key == 's') sKey = false;
  if (key == 'D' | key == 'd') dKey = false;
  if (key == ' ') spaceKey = false;
  if (keyCode == SHIFT) shiftKey = false;
}
