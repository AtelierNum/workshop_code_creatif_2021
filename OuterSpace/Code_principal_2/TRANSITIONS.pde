//void jouer_transition() {
//background(255);
//}

class Starlight {
  float x;
  float z;
  float y;
  float pz;

  Starlight() {
    x = random(-width/2, width/2);
    y = random(-height/2, height/2);
    z = random(width/2);
    pz = z;
  }


  void update() {
    z = z - speedy;
    if (z < 1) {
      z = width/2;
      x = random(-width/2, width/2);
      y = random(-height/3, height/3);
      pz = z;
    }
  }

  void show() {
    fill(255);
    noStroke();

    float sx = map(x / z, 0, 3, 0, width/4);
    float sy = map(y / z, 0, 3, 0, height/4);
    float r = map(z, 0, width/4, 20, 0);
    ellipse(sx, sy, r, r);

    float px = map(x / pz, 0, 2, 0, width/4);
    float py = map(y / pz, 0, 2, 0, height/4);
    pz = z;
    stroke(255);
    line(px, py, sx, sy);
  }
}

void setup_TRANSITION () {
  //fullScreen();
  starwarsfond = loadImage("gal.jpg");
  starlights = new Starlight[500];
  for (int i = 0; i < starlights.length; i++) {
    starlights[i] = new Starlight();
  }
}

 void jouer_transition() {
 
  speedy = 9;
  println("vitesse " + speedy);

  background(0);

  image(starwarsfond,0, 0);
  translate(width/2, height/2);
  for (int i = 0; i < starlights.length; i++) {
    starlights[i].update();
    starlights[i].show();
  }
}
