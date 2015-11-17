/**
 * Clay Mechanics Simulator
 *
 * Simulator for experimenting with the graphical and interaction mechanics for Clay. 
 */
 
import java.util.ArrayList;
 
class Behavior {
  // Spring drawing constants for top bar
  boolean touched = false;   // If mouse over
  boolean move = false;   // If mouse down and over
  
  // Spring simulation constants
  float xDestination = 0;   // Rest position (in X dimension)
  float yDestination = 0;   // Rest position (in Y dimension)
  
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
  
  Behavior () {
    this.xPosition = random (0, width);
    this.yPosition = random (0, height);
    this.xDestination = random (0, width);
    this.yDestination = random (0, height);
  }
  
  void updatePosition (float touchX, float touchY) {
    
    for (Behavior behavior : behaviors) {
      // Update the spring position
      double distance = Math.sqrt (Math.pow (this.xDestination - this.xPosition, 2) + Math.pow(this.xDestination - this.xPosition, 2)); // Determine distance to the calculated resting point
      if (distance >= 0.1) { // Set move to true as long as the node is not at its specified rest position (i.e., the x,y point at which mouse was release)
        
        // Update X position
        this.xForce = -K * (this.xPosition - this.xDestination);    // f=-ky
        this.xAcceleration = this.xForce / M;           // Set the acceleration, f=ma == a=f/m
        this.xVelocity = D * (this.xVelocity + this.xAcceleration);   // Set the velocity
        this.xPosition = this.xPosition + this.xVelocity;         // Updated position
        
        // Update Y coordinate
        this.yForce = -K * (this.yPosition - this.yDestination);    // f=-ky
        this.yAcceleration = this.yForce / M;           // Set the acceleration, f=ma == a=f/m
        this.yVelocity = D * (this.yVelocity + this.yAcceleration);   // Set the velocity
        this.yPosition = this.yPosition + this.yVelocity;         // Updated position
        
      }
      if(abs(this.xVelocity) < 0.1) {
        this.xVelocity = 0.0;
      }
      if(abs(this.yVelocity) < 0.1) {
        this.yVelocity = 0.0;
      }
      
      
    
      // Test if mouse is over the circle
      if(touchX > (this.xPosition - (75.0 / 2)) && touchX < (this.xPosition + (75.0 / 2)) && touchY > (this.yPosition - (75.0 / 2)) && touchY < (this.yPosition + (75.0 / 2))) {
        this.touched = true;
      } else {
        this.touched = false;
      }
      
      // Update the current target resting position
      if (this.move) {
        this.xDestination = touchX; // Update rest position (in X dimension)
        this.yDestination = touchY; // Update rest position (in Y dimension)
      }
    }
  }
}

ArrayList<Behavior> behaviors = new ArrayList<Behavior> ();

// Substrate's spring simulation constants
float M = 2.98;   // Mass
float K = 0.2;   // Spring constant
float D = 0.82;  // Damping

void setup() {
  //size(640, 360);
  fullScreen();
  rectMode(CORNERS);
  noStroke();
  
  for (int i = 0; i < 5; i++) {
    Behavior behavior = new Behavior ();
    behaviors.add(behavior);
  }
}

void draw() {
  background(255);
  
  for (Behavior behavior : behaviors) {
    behavior.updatePosition (mouseX, mouseY);
    //behavior.xDestination = mouseX; // Update rest position (in X dimension)
    //behavior.yDestination = mouseY; // Update rest position (in Y dimension)
  }
  
  drawBehaviors();
}

void drawBehaviors() {
  
  for (Behavior behavior : behaviors) {
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
  
}

//void updatePosition () {
  
//  for (Behavior behavior : behaviors) {
//    // Update the spring position
//    double distance = Math.sqrt (Math.pow (behavior.xDestination - behavior.xPosition, 2) + Math.pow(behavior.xDestination - behavior.xPosition, 2)); // Determine distance to the calculated resting point
//    if (distance >= 0.1) { // Set move to true as long as the node is not at its specified rest position (i.e., the x,y point at which mouse was release)
      
//      // Update X position
//      behavior.xForce = -K * (behavior.xPosition - behavior.xDestination);    // f=-ky
//      behavior.xAcceleration = behavior.xForce / M;           // Set the acceleration, f=ma == a=f/m
//      behavior.xVelocity = D * (behavior.xVelocity + behavior.xAcceleration);   // Set the velocity
//      behavior.xPosition = behavior.xPosition + behavior.xVelocity;         // Updated position
      
//      // Update Y coordinate
//      behavior.yForce = -K * (behavior.yPosition - behavior.yDestination);    // f=-ky
//      behavior.yAcceleration = behavior.yForce / M;           // Set the acceleration, f=ma == a=f/m
//      behavior.yVelocity = D * (behavior.yVelocity + behavior.yAcceleration);   // Set the velocity
//      behavior.yPosition = behavior.yPosition + behavior.yVelocity;         // Updated position
      
//    }
//    if(abs(behavior.xVelocity) < 0.1) {
//      behavior.xVelocity = 0.0;
//    }
//    if(abs(behavior.yVelocity) < 0.1) {
//      behavior.yVelocity = 0.0;
//    }
    
    
  
//    // Test if mouse is over the circle
//    if(mouseX > (behavior.xPosition - (75.0 / 2)) && mouseX < (behavior.xPosition + (75.0 / 2)) && mouseY > (behavior.yPosition - (75.0 / 2)) && mouseY < (behavior.yPosition + (75.0 / 2))) {
//      behavior.touched = true;
//    } else {
//      behavior.touched = false;
//    }
    
//    // Update the current target resting position
//    if (behavior.move) {
//      behavior.xDestination = mouseX; // Update rest position (in X dimension)
//      behavior.yDestination = mouseY; // Update rest position (in Y dimension)
//    }
//  }
//}

void mousePressed() {
  for (Behavior behavior : behaviors) {
    if(behavior.touched) {
      behavior.move = true;
    }
  }
}

void mouseReleased() {
  for (Behavior behavior : behaviors) {
    if (behavior.move) {
      // Set the final resting position for the circle
      behavior.xDestination = mouseX; // Update rest position (in X dimension)
      behavior.yDestination = mouseY; // Update rest position (in Y dimension)
    }
    behavior.move = false;
  }
}