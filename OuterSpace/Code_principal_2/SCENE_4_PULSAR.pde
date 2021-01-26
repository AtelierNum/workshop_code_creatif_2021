void setup_PULSAR4() {
  //GÉNÉRAL SCÈNE 4
  fond4=loadImage("fond4.jpg");
  background(0);


  // PULSAR ÉTOILE   
  dim = height/3;
  ;  
  noStroke();

  // ANIMATION PULSAR 
  maxRadius = sqrt(sq(width/2)+sq(height/2)); 
  if (!DEV) effet_4=new SoundFile(this, "robot.mp3");
  if (!DEV) effet_4.amp(.25);
}

void draw_PULSAR4() {  
  //PULSAR ÉTOILE
  background(0);
  image(fond4, 0, 0);
  //ellipse/etoile
  drawGradient(width/2, height/2);

  //rayons 
  fill (219, 250, 249, 300);
  triangle(width/2, height/2, width*995/1000, 0, width, 0);
  triangle(width/2, height/2, width*5/1000, height, 0, height);
  silhouette_4 = loadImage( "ombre4.png");
  image(silhouette_4,550,300);
  
}



// PULSAR ÉTOILE
// elipse/etoile inspiration code : https://processing.org/examples/radialgradient.html
void drawGradient(float xPEE, float yPEE) {
  colorMode(HSB, 360, 100, 100);
  ellipseMode(RADIUS);
  noStroke();
  int radius = dim/2;
  float h = 300;
  float g = 35;
  float b = 70;
  for (int r = radius; r > 0; --r) {
    fill(h, g, b, 9);
    ellipse(xPEE, yPEE, r, r);
    h = (h - 0.5) % 360;
    g = (g + 0.2) % 100;
    b = (b + 0.9) % 100;
  }
}

void draw_ANIMPULSAR4() {
  //spirale inpiration code : https://forum.processing.org/two/discussion/13125/for-loop-to-make-a-spiral 
  stroke(#DEF5FF);
  noFill();
  strokeWeight(1);

  for (int i = 0; i<NUM_LINES; i++) {    
    xPE = width/2+i*cos((i+startAngle)*NUM_TURNS*TWO_PI/maxRadius);
    yPE = height/2+i*sin((i+startAngle)*NUM_TURNS*TWO_PI/maxRadius);
    point(xPE, yPE);
  }
  startAngle+=START_ANGLE_CHANGE;
}

void keyPressed_pulsar() {
  if (key==' ') {
    if (!DEV) effet_4.loop();
  }
}
