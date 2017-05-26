int cubeSize = 40;
float halfCubeSize = cubeSize / 2;

// void setup() {
//   size(500, 500, P3D);
//   frameRate(40);
//   ortho();
//   smooth(8);
//   strokeWeight(1);
// }

// void draw() {
//   background(255);
//   translate(width/2, height/2, 0);
  
//   pushMatrix();
//   translate(0, 0, 100);
//   stroke(255, 0, 0);
//   line(0, 0, -width, 0);
//   line(0, 0, 0, -height);
//   popMatrix();

//   pushMatrix();
//   stroke(0);
//   // rotateX(radians(0));
//   rotateX(radians(-210));
//   rotateY(radians(45));
//   rotateZ(radians(-constrain(frameCount, 0, 90)));
//   // rotateZ(radians(-frameCount));
//   translate(-halfCubeSize, halfCubeSize, -halfCubeSize);
//   box(cubeSize);
//   popMatrix();

//   if (frameCount >= 90) {  
//     pushMatrix();
//     translate(halfCubeSize, halfCubeSize, 100);
//     stroke(255, 0, 0);
//     line(0, 0, -width, 0);
//     line(0, 0, 0, -height);
//     popMatrix(); 
//   }
// }

void setup() {
  size(500, 500, P2D);
  smooth(8);
  strokeWeight(1);
}

void draw() {
  background(255);
  translate(0, height/2);
  stroke(255, 0, 0);
  line(0, 2, width, 2);

  int offset = floor(frameCount / 90);

  stroke(0);
  translate(offset * cubeSize, 0);
  rotate(radians(frameCount % 90));
  rect(-cubeSize, -cubeSize, cubeSize, cubeSize);
}
