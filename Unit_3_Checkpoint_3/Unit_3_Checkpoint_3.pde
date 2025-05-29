//Jovan Tang
//May 29 2025

//Unit 3 Checkpoint #3
//3D Enviornmental Sketch

boolean wKey, aKey, sKey, dKey, spaceKey, shiftKey;
float eyeX, eyeY, eyeZ, focusX, focusY, focusZ, tiltX, tiltY, tiltZ; //eye = keyboard, focus = mouse, tilt = irrelevant

void setup() {
  size(800, 800, P3D);
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
}

void draw() {
  background(0);
  drawFloor();
  controlCamera();
}

void drawFloor() {
  stroke(255); 
  for (int x = -2000; x <= 2000; x = x + 100) {
    line(x, height, -2000, x, height, 2000);
    line(-2000, height, x, 2000, height, x);
  }
}

void controlCamera() {
  camera(eyeX, eyeY, eyeZ, focusX, focusY, focusZ, tiltX, tiltY, tiltZ);
  if (wKey) eyeZ = eyeZ + 10; 
  if (sKey) eyeZ = eyeZ - 10; 
  if (aKey) eyeX = eyeX  + 10; 
  if (dKey) eyeX = eyeX - 10; 
  if (spaceKey) eyeY = eyeY -10; 
  if (shiftKey) eyeY = eyeY + 10; 
  
  focusX = eyeX; 
  focusY = eyeY; 
  focusZ = eyeZ+10; 
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
  if (keyCodes == SHIFT) shiftKey = false; 
}
