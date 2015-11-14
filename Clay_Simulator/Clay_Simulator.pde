void setup() {
  size(1024, 768);
} 

void draw() {
  background(255,255,255);
  translate(width/2, height/2);
  //float zoom = map(mouseX, 0, width, 0.1, 4.5);
  //scale(zoom);
  rect(0, 0, 100, 100);
}