//inpiration:@author aa_debdeb
 //* @date 2016/10/10
 //*/
void setup_flammes() {
  fond2=loadImage("fond2.jpg");
  noStroke();
  offset1 = new PVector(random(10000), random(10000));
  offset2 = new PVector(random(10000), random(10000));
  if (!DEV) effet_2=new SoundFile (this, "alien.mp3");
  //keyPressed();
  //mousePressed();
}
//ANIMATION FLAMMES
void mousePressed_flammes() {
  //prévenir le souris est détecté 2 fois quand on clique
  if (frameCount - lapse > 10) {  
    c1 = color(random(255), random(70), random(155), 255);
    c2 = color(random(155), random(70), random(255), 255);
    lapse = frameCount;
  }
}

//activer le son
void keyPressed_flammes() {
  if ( key==' ' ) {
    if (!DEV) effet_2.loop();
  }
}

void draw_flammes() {
  //background(10);
  noStroke();
  image(fond2, 0, 0);
  translate(width/2, height/2 );
  for (float radious = 350; radious > 0; radious -= 10) {

    // Definir la couleur de remplissage
    fill(map(radious, 0, 250, red(c1), red(c2)), 
      map(radious, 0, 250, green(c1), green(c2)), 
      map(radious, 0, 250, blue(c1), blue(c2)), 
      map(radious, 0, 250, green(c1), green(c2))
      );

    // Dessiner la forme     
    beginShape();
    for (float angle = 0; angle < 360; angle += random(1)) {
      float radian = radians(angle);  
      float x = radious * cos(radian);
      float y = radious * sin(radian);

      // Trouver les coordonnées des points
      float nx = x + map(noise(x * scale + offset1.x, y * scale + offset1.y, frameCount * 0.0035), 0, 1, -300, 300);
      float ny = y + map(noise(x * scale + offset2.x, y * scale + offset2.y, frameCount * 0.0035), 0, 1, -300, 300);
      vertex(nx, ny);
    }
    endShape(CLOSE);
    }
    silhouette_2 = loadImage( "ombre2.png");
  image(silhouette_2,-250,-400);
  
}
