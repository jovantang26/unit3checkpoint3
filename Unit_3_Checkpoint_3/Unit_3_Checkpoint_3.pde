//Jovan Tang
//May 29 2025

//Unit 3 Checkpoint #3
//3D Enviornmental Sketch

import java.awt.Robot;

Robot rbt;

//texture
PImage stoneBrick;
PImage oakTop;
PImage oakSide;
PImage dirtBlock;


//color pallette
color black = #000000;
color white = #ffffff;
color red = #ff0000;

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
  eyeY = -300;
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
  stoneBrick = loadImage("Stone_Bricks.png");
  oakTop = loadImage("Oak_Log_Top.png");
  oakSide = loadImage("Oak_Log_Side.png");
  dirtBlock = loadImage("Dirt_(texture)_JE2_BE2.png");

  gridSize = 100;
}

void draw() {
  background(0);
  pointLight(255, 255, 255, eyeX, eyeY, eyeZ);
  camera(eyeX, eyeY, eyeZ, focusX, focusY, focusZ, tiltX, tiltY, tiltZ);
  drawFocalPoint();
  controlCamera();
  drawMap();
}

void drawMap() {
  for (int x = 0; x < map.width; x++) {
    for (int y = 0; y < map.height; y++) {
      color c = map.get(x, y);

      if (c != white && c != black) {
        for (int i = 1; i < 3; i++) {
          texturedCube(x*gridSize-5000, -gridSize*i, y*gridSize-5000, stoneBrick, gridSize);
        }
      }
      if (c == black) {
        for (int i = 1; i < 6; i++) {
          texturedCube(x*gridSize-5000, -gridSize*i, y*gridSize-5000, oakTop, oakTop, oakSide, gridSize);
        }
      }
      if (c == white) {
        texturedCube(x*gridSize-5000, 0, y*gridSize-5000, dirtBlock, gridSize);
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

void controlCamera() {
  if (wKey && canMoveForward() ) {
    eyeZ = eyeZ + sin(leftRightHeadAngle)*20;
    eyeX = eyeX + cos(leftRightHeadAngle)*20;
  }
  if (sKey && canMoveBack()) {
    eyeZ = eyeZ - sin(leftRightHeadAngle)*20;
    eyeX = eyeX - cos(leftRightHeadAngle)*20;
  }
  if (aKey && canMoveLeft()) {
    eyeZ = eyeZ - sin(leftRightHeadAngle+radians(90))*20;
    eyeX = eyeX - cos(leftRightHeadAngle+radians(90))*20;
  }
  if (dKey && canMoveRight()) {
    eyeZ = eyeZ + sin(leftRightHeadAngle+radians(90))*20;
    eyeX = eyeX + cos(leftRightHeadAngle+radians(90))*20;
  }
  if (spaceKey) eyeY = eyeY -20;
  if (shiftKey) eyeY = eyeY + 20;

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

boolean canMoveForward() {
  float fwdx, fwdy, fwdz;
  int mapx, mapy;

  fwdx = eyeX+cos(leftRightHeadAngle)*200;
  fwdz = eyeZ+sin(leftRightHeadAngle)*200;
  fwdy = eyeY;

  mapx = int(fwdx+5000)/gridSize;
  mapy = int(fwdz+5000)/gridSize;

  if (map.get(mapx, mapy) == black) {
    return false;
  } else {
    return true;
  }
}

boolean canMoveBack() {
  float Backx, Backy, Backz;
  int mapx, mapy;

  Backx = eyeX-cos(leftRightHeadAngle)*200;
  Backz = eyeZ-sin(leftRightHeadAngle)*200;
  Backy = eyeY;

  mapx = int(Backx+5000)/gridSize;
  mapy = int(Backz+5000)/gridSize;

  if (map.get(mapx, mapy) == black) {
    return false;
  } else {
    return true;
  }
}

boolean canMoveLeft() {
  float leftx, lefty, leftz;
  int mapx, mapy;

  leftx = eyeX+cos(leftRightHeadAngle-90)*200;
  leftz = eyeZ+sin(leftRightHeadAngle-90)*200;
  lefty = eyeY;

  mapx = int(leftx+5000)/gridSize;
  mapy = int(leftz+5000)/gridSize;

  if (map.get(mapx, mapy) == black) {
    return false;
  } else {
    return true;
  }
}

boolean canMoveRight() {
  float rightx, righty, rightz;
  int mapx, mapy;

  rightx = eyeX+cos(leftRightHeadAngle+90)*200;
  rightz = eyeZ+sin(leftRightHeadAngle+90)*200;
  righty = eyeY;

  mapx = int(rightx+5000)/gridSize;
  mapy = int(rightz+5000)/gridSize;

  if (map.get(mapx, mapy) == black) {
    return false;
  } else {
    return true;
  }
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
