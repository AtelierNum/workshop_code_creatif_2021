class UniversSerein extends Univers {

  UniversSerein(SoundFile sound, color colorOne, color colorTwo, color colorThree, color colorFour, float facteurVitesse1, float facteurVitesse2) {
    super(sound,colorOne, colorTwo,colorThree,colorFour, facteurVitesse1, facteurVitesse2);
  }
  
  void updateDroplets() {
    float x = random(-box, box);
    float z = random(-box, box);
    PVector acc = new PVector(random(-1, 1), random(-1, 1), random(-1, 1));
    for (int i = 0; i < 50; i++) {
      particles.add(
        new Particle(
          new PVector(x+random(1, 2), -box+random(5, 15), z+random(1, 2)),
          acc,
          activeColor)
      );
    }
  }
  
  void updateParticles(PGraphics pg, float handGrab, int particuleIndex) {
    Particle p = (Particle) particles.get(particuleIndex);
    p.move(pg);
    p.applyForce(new PVector(0, 0.1, 0));
     /*
     Rebondissement qui est créé par la tombée de la pluie touchant le sol
     Se modifie grâce à la contraction de la main
     */
    float b = abs(cos(radians(-p.loc.x+frameCount)))*sin(radians(p.loc.z+frameCount))*(radians(-p.loc.y))*20*handGrab;
    
    p.changeVel(b);
    p.boundary(b);
    if (p.life < 0){
      particles.remove(p); 
    }
  }
}

class Particle {
  PVector loc, vel, acc;
  float bounce = -0.3;                 //Valeur du rebond : négatif pour que les particules remontent

  int hits = 0;                        //Permet de créer un effet d'explosion
  float life = random(200, 500);
  float maxLife = life;
  color activeColor = #5620AF;
  PGraphics scene;

  Particle(PVector loc, PVector acc, color activeColor) {
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

  void applyForce(PVector force) {
    acc.add(PVector.div(force, 1));
  }

  void boundary(float b) {
      /* 
     On vérifie les limites X, Y et Z et on inverse la vélocité en disant que l'emplacement est égal aux frontières de la boîte
     On fait cela pour que les particules ne puissent pas s'échapper de la zone quoi qu'il arrive
     */
    if (loc.x < -box) { 
      vel.x *= bounce;
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
