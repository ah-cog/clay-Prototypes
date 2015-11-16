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
boolean touched = false;   // If mouse over
boolean move = false;   // If mouse down and over

// Spring simulation constants
float M = 2.98;   // Mass
float K = 0.2;   // Spring constant
float D = 0.82;  // Damping

// Spring simulation constants
float xDestination = 150;   // Rest position (in X dimension)
float yDestination = 150;   // Rest position (in Y dimension)

// Spring simulation variables
float yPosition = yDestination;    // Position
float yVelocity = 0.0;  // Velocity
float yAcceleration = 0;    // Acceleration
float yForce = 0;     // Force
// Additional spring simulation variables
float xPosition = xDestination;    // Position
float xVelocity = 0.0;  // Velocity
float xAcceleration = 0;    // Acceleration
float xForce = 0;     // Force

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
  if(touched || move) {
    stroke(0.2);
    fill(204);
  } else { 
    stroke(0.2);
    fill(255);
  }
  
  // Draw circle
  ellipse (xPosition, yPosition, 75, 75);
  
}


void updatePosition() {
  
  // Update the spring position
  double distance = Math.sqrt (Math.pow (xDestination - xPosition, 2) + Math.pow(xDestination - xPosition, 2)); // Determine distance to the calculated resting point
  if (distance >= 0.1) { // Set move to true as long as the node is not at its specified rest position (i.e., the x,y point at which mouse was release)
    
    // Update X position
    xForce = -K * (xPosition - xDestination);    // f=-ky
    xAcceleration = xForce / M;           // Set the acceleration, f=ma == a=f/m
    xVelocity = D * (xVelocity + xAcceleration);   // Set the velocity
    xPosition = xPosition + xVelocity;         // Updated position
    
    // Update Y coordinate
    yForce = -K * (yPosition - yDestination);    // f=-ky
    yAcceleration = yForce / M;           // Set the acceleration, f=ma == a=f/m
    yVelocity = D * (yVelocity + yAcceleration);   // Set the velocity
    yPosition = yPosition + yVelocity;         // Updated position
    
  }
  if(abs(xVelocity) < 0.1) {
    xVelocity = 0.0;
  }
  if(abs(yVelocity) < 0.1) {
    yVelocity = 0.0;
  }

  // Test if mouse is over the circle
  if(mouseX > (xPosition - (75.0 / 2)) && mouseX < (xPosition + (75.0 / 2)) && mouseY > (yPosition - (75.0 / 2)) && mouseY < (yPosition + (75.0 / 2))) {
    touched = true;
  } else {
    touched = false;
  }
  
  // Update the current target resting position
  if (move) {
    xDestination = mouseX; // Update rest position (in X dimension)
    yDestination = mouseY; // Update rest position (in Y dimension)
  }
}

void mousePressed() {
  if(touched) {
    move = true;
  }
}

void mouseReleased() {
  if (move) {
    // Set the final resting position for the circle
    xDestination = mouseX; // Update rest position (in X dimension)
    yDestination = mouseY; // Update rest position (in Y dimension)
  }
  move = false;
}