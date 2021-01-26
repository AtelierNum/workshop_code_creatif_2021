Star[] stars;
void setup_etoiles() {
  fond3=loadImage("fond3.jpg");

  //nombre de l'étoile
  stars = new Star[800];
  for (int i = 0; i < stars.length; i++) {
    stars[i] = new Star();
  }
  setup_galaxie();
  if (!DEV) effet_3=new SoundFile(this, "radio.mp3");
  //keyPressed();
}


class Star {
  float x;
  float z;
  float y;
  float pz;

  Star() {
    x = random(-width/2, width/2);
    y = random(-height/2, height/2);
    z = random(width/2);
    pz = z;
  }


  void update() {
    z = z - speed;
    if (z < 1) {
      z = width/2;
      x = random(-width/2, width/2);
      y = random(-height/2, height/2);
      pz = z;
    }
  }

  //déplacement de l'ellipse
  void show() {
    fill(#8BFFF0);
    noStroke();
    float sx = map(x / z, 0, 1, 0, width/2);
    float sy = map(y / z, 0, 1, 0, height/2);
    float r = map(z, 0, width/2, 16, 0);
    ellipse(sx, sy, r, r);
    float px = map(x / pz, 0, 1, 0, width/2);
    float py = map(y / pz, 0, 1, 0, height/2);
    pz = z;
    line(px, py, sx, sy);
  }
}

void draw_etoiles() {
  //speed = map(mouseX, 0, width, 0, 50);
  speed=6;
  background(0);
  image(fond3, 0, 0);
  pushMatrix();
  translate(width/2, height/2);
  //println(stars.length);
  for (int i = 0; i < stars.length; i++) {
    stars[i].update();
    stars[i].show();
  }
  popMatrix();

  if (show_galaxie) {
    println("galaxie");
    draw_galaxie();
  }
  silhouette_3 = loadImage( "ombre3.png");
  image(silhouette_3,400,260);
}

//activer l'animation
void mousePressed_etoiles() {
  show_galaxie = true;
}

//activer le sons
void keyPressed_etoiles() {
  if (key==' ') {
    if (!DEV) effet_3.loop();
  }
}
