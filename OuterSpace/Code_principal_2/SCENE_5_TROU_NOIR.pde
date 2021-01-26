void setup_TROUNOIR5(){
  noFill();
  kMax = 0.7;
  step = 0.01;
  if (!DEV) effet_5=new SoundFile(this,"bruit.mp3");
  if (!DEV) effet_5.amp(.5); 
}

void draw_TROUNOIR5() {
    colorMode(RGB, 254, 254, 254);
//Trou noir inspiration : https://www.openprocessing.org/sketch/792407/ 
  background(0.1);
  noFill();
  stroke(255);
  for (int i = 0; i < n; i++) 
  {
    float ii = float(i)/float(n);
    float alpha = 1 - noiseProg(ii);
    stroke(245, alpha*100); 
    float taille = radius + i * inter;
    float k = kMax * sqrt(ii);
    float noisiness = maxNoise* noiseProg(ii);
    blob(taille, width/2, height/2, k, i * step, noisiness);
  }
  silhouette_5 = loadImage( "ombre5.png");
  image(silhouette_5,330,300);
}

void blob(float taille, float xCenter, float yCenter, float k, float t, float noisiness) {
  //ellipse(xCenter, yCenter, taille, taille);

  beginShape();
  float angleStep = 360.0 / 250.0;
  for (float theta = 0; theta < 360; theta += angleStep) {
    float r1, r2;

    r1 = cos(radians(theta))+1;
    r2 = sin(radians(theta))+1;
    float r = taille + noise(k * r1, k * r2, t + millis()/1000.0) * noisiness;
    float x = xCenter + r * cos(radians(theta));
    float y = yCenter + r * sin(radians(theta));
    curveVertex(x, y);
  }
  endShape(CLOSE);
}

void keyPressed_trou_noir(){
  if(key==' '){
    if (!DEV) effet_5.loop();
  }
}
