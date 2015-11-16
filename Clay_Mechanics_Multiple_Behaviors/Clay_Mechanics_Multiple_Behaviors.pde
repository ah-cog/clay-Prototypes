/**
 * Clay Mechanics Simulator
 *
 * Simulator for experimenting with the graphical and interaction mechanics for Clay. 
 */
 
class Behavior {
  // Spring drawing constants for top bar
  boolean touched = false;   // If mouse over
  boolean move = false;   // If mouse down and over
  
  // Spring simulation constants
  float xDestination = 150;   // Rest position (in X dimension)
  float yDestination = 150;   // Rest position (in Y dimension)
  
  // Spring simulation variables (x dimension)
  float xPosition = xDestination;    // Position
  float xVelocity = 0.0;  // Velocity
  float xAcceleration = 0;    // Acceleration
  float xForce = 0;     // Force
  
  // Spring simulation variables (y dimension)
  float yPosition = yDestination;    // Position
  float yVelocity = 0.0;  // Velocity
  float yAcceleration = 0;    // Acceleration
  float yForce = 0;     // Force
}

Behavior behavior = new Behavior ();
 
// Spring drawing constants for top bar
//boolean touched = false;   // If mouse over
//boolean move = false;   // If mouse down and over

// Spring simulation constants
float M = 2.98;   // Mass
float K = 0.2;   // Spring constant
float D = 0.82;  // Damping

//// Spring simulation constants
//float xDestination = 150;   // Rest position (in X dimension)
//float yDestination = 150;   // Rest position (in Y dimension)

//// Spring simulation variables (x dimension)
//float xPosition = xDestination;    // Position
//float xVelocity = 0.0;  // Velocity
//float xAcceleration = 0;    // Acceleration
//float xForce = 0;     // Force

//// Spring simulation variables (y dimension)
//float yPosition = yDestination;    // Position
//float yVelocity = 0.0;  // Velocity
//float yAcceleration = 0;    // Acceleration
//float yForce = 0;     // Force

void setup() {
  //size(640, 360);
  fullScreen();
  rectMode(CORNERS);
  noStroke();
}

void draw() {
  background(255);
  updatePosition();
  drawCircle();
  behavior.xDestination = mouseX; // Update rest position (in X dimension)
  behavior.yDestination = mouseY; // Update rest position (in Y dimension)
}

void drawCircle() {
  
  // Set color and draw top bar
  if(behavior.touched || behavior.move) {
    stroke(0.2);
    fill(204);
  } else { 
    stroke(0.2);
    fill(255);
  }
  
  // Draw circle
  ellipse (behavior.xPosition, behavior.yPosition, 75, 75);
  
}

void updatePosition () {
  
  // Update the spring position
  double distance = Math.sqrt (Math.pow (behavior.xDestination - behavior.xPosition, 2) + Math.pow(behavior.xDestination - behavior.xPosition, 2)); // Determine distance to the calculated resting point
  if (distance >= 0.1) { // Set move to true as long as the node is not at its specified rest position (i.e., the x,y point at which mouse was release)
    
    // Update X position
    behavior.xForce = -K * (behavior.xPosition - behavior.xDestination);    // f=-ky
    behavior.xAcceleration = behavior.xForce / M;           // Set the acceleration, f=ma == a=f/m
    behavior.xVelocity = D * (behavior.xVelocity + behavior.xAcceleration);   // Set the velocity
    behavior.xPosition = behavior.xPosition + behavior.xVelocity;         // Updated position
    
    // Update Y coordinate
    behavior.yForce = -K * (behavior.yPosition - behavior.yDestination);    // f=-ky
    behavior.yAcceleration = behavior.yForce / M;           // Set the acceleration, f=ma == a=f/m
    behavior.yVelocity = D * (behavior.yVelocity + behavior.yAcceleration);   // Set the velocity
    behavior.yPosition = behavior.yPosition + behavior.yVelocity;         // Updated position
    
  }
  if(abs(behavior.xVelocity) < 0.1) {
    behavior.xVelocity = 0.0;
  }
  if(abs(behavior.yVelocity) < 0.1) {
    behavior.yVelocity = 0.0;
  }

  // Test if mouse is over the circle
  if(mouseX > (behavior.xPosition - (75.0 / 2)) && mouseX < (behavior.xPosition + (75.0 / 2)) && mouseY > (behavior.yPosition - (75.0 / 2)) && mouseY < (behavior.yPosition + (75.0 / 2))) {
    behavior.touched = true;
  } else {
    behavior.touched = false;
  }
  
  // Update the current target resting position
  if (behavior.move) {
    behavior.xDestination = mouseX; // Update rest position (in X dimension)
    behavior.yDestination = mouseY; // Update rest position (in Y dimension)
  }
}

void mousePressed() {
  if(behavior.touched) {
    behavior.move = true;
  }
}

void mouseReleased() {
  if (behavior.move) {
    // Set the final resting position for the circle
    behavior.xDestination = mouseX; // Update rest position (in X dimension)
    behavior.yDestination = mouseY; // Update rest position (in Y dimension)
  }
  behavior.move = false;
}