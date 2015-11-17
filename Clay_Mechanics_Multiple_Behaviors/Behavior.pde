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