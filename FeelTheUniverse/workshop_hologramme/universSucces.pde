class UniversSucces extends Univers {

  UniversSucces(SoundFile sound, color colorOne, color colorTwo, color colorThree, color colorFour, float facteurVitesse1, float facteurVitesse2) {
    super(sound,colorOne, colorTwo,colorThree,colorFour, facteurVitesse1, facteurVitesse2);
  }
  
  void updateDroplets() {
    float x = random(-box, box);
    float z = random(-box, box);
    PVector acc = new PVector(random(-1, 1), random(-1, 1), random(-1, 1));
    for (int i = 0; i < 50; i++) {
      particles.add(
        new ParticuleSucces(
          new PVector(x+random(1, 2), -box+random(5, 15), z+random(1, 2)), //vecteur localisation 
          acc, //vecteur accélération
          activeColor
        )
      );
    }
  }
  
 void updateParticles(PGraphics pg, float handGrab, int particuleIndex) {
    ParticuleSucces p = (ParticuleSucces) particles.get(particuleIndex);
    p.move(pg);
    p.applyForce(new PVector(0, 1, 0));

    float b = abs(cos(radians(-p.loc.x+frameCount)))*sin(radians(p.loc.z+frameCount))*cos(radians(-p.loc.y))*80*handGrab; //fonction valeur absolue 

    p.changeVel(b);                     //Change la vélocité
    p.boundary(b);                      //Les limites de la boîte dans laquelle il rebondit
    if (p.life < 0) {
      particles.remove(p);
    }
  }
}

class ParticuleSucces {
  PVector loc, vel, acc;
  float bounce = -0.7;                  //Valeur du rebond négative pour que les particules remontent 

  int hits = 0;                         //Permet de faire un effet d'explosion 
  float life = random(200, 300);
  float maxLife = life;
  color activeColor = #5620AF;
  PGraphics scene;

  ParticuleSucces(PVector loc, PVector acc, color activeColor) {
    this.activeColor = activeColor;
    this.loc = loc;
    vel = new PVector();
    this.acc = acc;
  }

  void move(PGraphics pg) {
    life--;
    
    pg.stroke(this.activeColor);
    pg.point(loc.x, loc.y, loc.z);

    vel.add(acc);
    loc.add(vel);
    acc.mult(0);
  }

  void changeVel(float b) {
    /*     
     Crée un effet d'explosion une seule fois et quand les gouttes touchent le sol
     On utilise "hits" pour que l'accélération soit à la première frappe sur le sol 
     */
    if (loc.y > box-b) hits++;
    if (loc.y > box-b && hits == 1) acc = new PVector(random(-1, 1), random(-1, 1), random(-1, 1));
  }

  void applyForce(PVector force) { //modifie l'accélération du déplacement
    acc.add(PVector.div(force, 1));
  }

  void boundary(float b) {
      /* 
     On vérifie les limites X, Y et Z et on inverse la vélocité en disant que l'emplacement est égal aux frontières de la boîte
     On fait cela pour que les particules ne puissent pas s'échapper de la zone quoi qu'il arrive
     */
    if (loc.x < -box) { 
      vel.x *= bounce; // equivalent à vel.x = vel.x * bounce
      loc.x = -box;
    }
    if (loc.x > box) { 
      vel.x *= bounce; 
      loc.x = box;
    }

    if (loc.y < -box) { 
      vel.y *= bounce; 
      loc.y = -box;
    }
    if (loc.y > box-b) { 
      vel.y *= bounce; 
      loc.y = box-b;
    }

    if (loc.z < -box) { 
      vel.z *= bounce; 
      loc.z = -box;
    }
    if (loc.z > box) { 
      vel.z *= bounce; 
      loc.z = box;
    }
  }
}
