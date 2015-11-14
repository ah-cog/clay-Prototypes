/**
 * Clay Mechanics Simulator
 *
 * Simulator for experimenting with the graphical and interaction mechanics for Clay. 
 */
 
// Spring drawing constants for top bar
//int springHeight = 10;  // Height
//int left;               // Left position
//int right;              // Right position
//int max = 200;          // Maximum Y value
//int min = 100;          // Minimum Y value
boolean over = false;   // If mouse over
boolean move = false;   // If mouse down and over

// Spring simulation constants
float M = 2.98;   // Mass
float K = 0.2;   // Spring constant
float D = 0.82;  // Damping
// Spring simulation constants
float RX = 150;   // Rest position (in X dimension)
float RY = 150;   // Rest position (in Y dimension)

// Spring simulation variables
float ps = RY;    // Position
float vs = 0.0;  // Velocity
float as = 0;    // Acceleration
float f = 0;     // Force
// Additional spring simulation variables
float psX = RX;    // Position
float vsX = 0.0;  // Velocity
float asX = 0;    // Acceleration
float fX = 0;     // Force

void setup() {
  //size(640, 360);
  fullScreen();
  rectMode(CORNERS);
  noStroke();
  //left = width/2 - 100;
  //right = width/2 + 100;
}

void draw() {
  background(255);
  updatePosition();
  //drawSpring();
  drawCircle();
  //RX = mouseX; // Update rest position (in X dimension)
  //RY = mouseY; // Update rest position (in Y dimension)
}

//void drawSpring() {
  
//  // Draw base
//  fill(0.2);
//  float baseWidth = 0.5 * ps + -8;
//  rect (width/2 - baseWidth, ps + springHeight, width/2 + baseWidth, height);

//  // Set color and draw top bar
//  if(over || move) { 
//    fill(155);
//  } else { 
//    fill(204);
//  }
//  rect(left, ps, right, ps + springHeight);
//}

void drawCircle() {
  
  // Set color and draw top bar
  if(over || move) {
    stroke(0.2);
    fill(204);
  } else { 
    stroke(0.2);
    fill(255);
  }
  
  // Draw circle
  ellipse (psX, ps, 75, 75);
  
}


void updatePosition() {
  
  // Update the spring position
  double distance = Math.sqrt (Math.pow (RX - psX, 2) + Math.pow(RX - psX, 2)); // Determine distance to the calculated resting point
  if (distance >= 0.1) { // Set move to true as long as the node is not at its specified rest position (i.e., the x,y point at which mouse was release)
    
    // Update X position
    fX = -K * (psX - RX);    // f=-ky
    asX = fX / M;           // Set the acceleration, f=ma == a=f/m
    vsX = D * (vsX + asX);   // Set the velocity
    psX = psX + vsX;         // Updated position
    
    // Update Y coordinate
    f = -K * (ps - RY);    // f=-ky
    as = f / M;           // Set the acceleration, f=ma == a=f/m
    vs = D * (vs + as);   // Set the velocity
    ps = ps + vs;         // Updated position
    
  }
  if(abs(vsX) < 0.1) {
    vsX = 0.0;
  }
  if(abs(vs) < 0.1) {
    vs = 0.0;
  }

  // Test if mouse is over the circle
  if(mouseX > (psX - (75.0 / 2)) && mouseX < (psX + (75.0 / 2)) && mouseY > (ps - (75.0 / 2)) && mouseY < (ps + (75.0 / 2))) {
    over = true;
  } else {
    over = false;
  }
  
  // Update the current target resting position
  if (move) {
    RX = mouseX; // Update rest position (in X dimension)
    RY = mouseY; // Update rest position (in Y dimension)
  }
}

void mousePressed() {
  if(over) {
    move = true;
  }
}

void mouseReleased() {
  if (move) {
    // Set the final resting position for the circle
    RX = mouseX; // Update rest position (in X dimension)
    RY = mouseY; // Update rest position (in Y dimension)
  }
  move = false;
}