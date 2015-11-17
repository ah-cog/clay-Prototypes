/**
 * Clay Mechanics Simulator
 *
 * Simulator for experimenting with the graphical and interaction mechanics for Clay. 
 */
 
import java.util.ArrayList;

ArrayList<Behavior> behaviors = new ArrayList<Behavior> ();

// Substrate's spring simulation constants
float M = 2.98;   // Mass
float K = 0.2;   // Spring constant
float D = 0.82;  // Damping

void setup() {
  //size(640, 360);
  frameRate(30);
  fullScreen();
  rectMode(CORNERS);
  noStroke();
  
  for (int i = 0; i < 5; i++) {
    Behavior behavior = new Behavior ();
    behaviors.add(behavior);
  }
}

void draw() {
  background (255);
  
  updateBehaviorPositions ();
  drawBehaviors ();
}

void updateBehaviorPositions () {
  for (Behavior behavior : behaviors) {
    behavior.updatePosition (mouseX, mouseY);
  }
}

void drawBehaviors () {
  
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