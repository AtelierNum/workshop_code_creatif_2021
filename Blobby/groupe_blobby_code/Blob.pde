class Blob {
  Eye e1, e2; 
  float noise_amp = s; //variation dans le contour des blobs
  float pos_x;
  float pos_y;
  float rad;
  float seed; //bruit
  int n = int(random(3, 15)); //nombre de points
  //Collision
  int id;                   // identifiant unique de la forme
  PVector position;         // position x,y de l'objet
  PVector velocite;         // vecteur de déplacement
  float diametre;
  float t2 = 0;
  float d;                  //variable coordonnée Bezier
  int c;                    //color
  int b;                    //bouche
  boolean picked = false;
  boolean picked2 = false;
  int cri_time;

  SoundFile tombe;

  Blob(float pos_x_in, float pos_y_in, float rad_in, float seed_in, int _id, PApplet p) {
    pos_x = pos_x_in;
    pos_y = pos_y_in;
    rad = rad_in;
    seed = seed_in;
    noise_amp = rad;

    //Collision
    id = _id;
    position = new PVector(random(width), random(height));
    velocite = new PVector(random(-3, 3), random(-3, 3));
    diametre = rad;

//Faire apparaitre 2 yeux pas blob
    e1= new Eye (rad/6, -(rad/8), rad/2);
    e2= new Eye (-(rad/6), -(rad/8), rad/2);
    
    c= int(random(6));
    b=2;
    d=rad/8;

    tombe= new SoundFile(p, "Tombe.wav");
    cri_time = int(random(12, 50));
  }

//Initialise les cris du début
  void cri() {
    float cri_vitesse = map(diametre, 400, 500, 0.8, 2);
    float cri_amp = map(diametre, 50, 200, 0.3, 0.7);
    tombe.play(cri_vitesse, cri_amp);
    if (DEBUG) print("o ");
  }



  void draw() {

    // Déclencher le cri
    if (frameCount == cri_time) cri();
    if (frameCount > 100&&frameCount<400) { //timer permettant de les rendre pas contents
      if (random(100)<2) {
        b=3;
      };
    };

    pushMatrix();
    translate(position.x, position.y);

    // Couleurs des blobs
    if (c == 0) {
      fill(#0369FC);
    } else if (c == 1) {
      fill(#70E000);
    } else if (c==2) {
      fill(#FF6D00);
    } else if (c==3) {
      fill(#8338EC);
    } else if (c==4) {
      fill(#FF006E);
    } else if (c==5) {
      fill(#FFF312);
    }
    
    noStroke();
    beginShape();
    for (int i = 0; i < n+3; i ++) {
      int i_end = i % n;
      float t_x = cos(TWO_PI*i_end/n);
      float t_y = sin(TWO_PI*i_end/n);
      float noise_rad = rad + noise_amp * (noise(t_x+ 2 + seed, t_y + 2, millis()/3000.0)-1.);
      float x =   noise_rad * t_x;
      float y =   noise_rad * t_y;
      curveVertex(x, y);
    }
    endShape(CLOSE);
    
//Afficher les yeux
    e1.display();
    e2.display();

    //Bouche
    if (picked) {
      b=2;
    }
    if (b == 1) {
      strokeWeight(rad/30);
      d=rad/8;      //content
    }
    if (b == 2) {
      strokeWeight(rad/8);
      d=rad/12;     //semi content
    }
    if (b == 3) {
      strokeWeight(rad/30);
      d=0;          //pas content
    }

    noFill();
    stroke(0);
    beginShape();
    vertex(-rad/12, rad/12);
    bezierVertex(-rad/30, d, rad/30, d, rad/12, rad/12);
    endShape();
    t2 += 1;
 
    if (t2 > 150 + randBlink) {   // augmenter 150 si on veut espacer le temps entre chaque clignement

//Couleur des pupilles
      noStroke();
      if (c == 0) {
        fill(#0369FC);
      } else if (c == 1) {
        fill(#70E000);
      } else if (c==2) {
        fill(#FF6D00);
      } else if (c==3) {
        fill(#8338EC);
      } else if (c==4) {
        fill(#FF006E);
      } else if (c==5) {
        fill(#FFF312);
      }
      ellipse(rad/6, -(rad/8), rad/4, rad/4);
      ellipse(-rad/6, -(rad/8), rad/4, rad/4);

      if (t2 > 150 + randBlink + 15) {     //15= temps clignement   // augmenter 150 si on veut espacer le temps entre chaque clignement
        t2 = 0;
        randBlink = random(0, 150);
      }
    }

    popMatrix();
  }
  void deplacer() {
    velocite.add(gravite);
    position.add(velocite);              // appliquer le déplacement à l'objet 


    // position.add(gravite);
    velocite.limit(50);

    // Faire rebondir l'objet sur les bords de l'écran
    if (position.x < diametre / 2 || position.x > width - diametre / 2) velocite.x = - velocite.x;
    if (position.y < diametre / 2 || position.y > height - diametre / 2) velocite.y = - velocite.y;
    // Empecher l'objet de sortir de l'écran
    if (position.y < diametre / 2) { 
      b=1;
      position.y = diametre / 2;
    }
    if (position.y > height - diametre / 2) position.y = height - diametre / 2;
    if (position.x < diametre / 2) position.x = diametre / 2;
    if (position.x > width - diametre / 2) position.x = width - diametre / 2;
  }
}
