
class UniversColere extends Univers {
  
  UniversColere(SoundFile sound, color colorOne, color colorTwo, color colorThree, color colorFour, float facteurVitesse1, float facteurVitesse2) {
    super(sound,colorOne, colorTwo,colorThree,colorFour, facteurVitesse1, facteurVitesse2);
  }

  //Création d'une sphère avec ses coordonnées
  void updateDroplets() {
      float angle1 = random(TWO_PI);
      float angle2 = random( -PI/2, 0);
      float rad = random(box);
      float x = rad * sin(angle1) * cos(angle2);
      float y = rad * sin(angle1) * sin(angle2);
      float z = rad*cos(angle1);
      PVector acc = new PVector(random(-1, 1), random(-1, 1), random(-1, 1));
      for (int i = 0; i < 50; i++) {
        particles.add(
          new ParticleSphere(
            new PVector(x+random(1, 2), y+random(5, 15), z+random(1, 2)), 
            acc, 
            activeColor)
        );
      }
  }
  
  //Permet de mettre toutes les particules dans la sphère
  void updateParticles(PGraphics pg, float handGrab, int particuleIndex) {
      ParticleSphere p = (ParticleSphere) particles.get(particuleIndex);
      p.move(pg);
      p.applyForce(new PVector(0, 0.5, 0));// vecteur de chute des particules

      float b = abs(cos(radians(-p.loc.x+frameCount)))*tan(radians(p.loc.z+frameCount))*(radians(-p.loc.y))*80*handGrab;

      p.changeVel(b);
      p.boundary(b);
      if (p.life < 0) {
        particles.remove(p);
     }
  }
  
}
class ParticleSphere {
  PVector loc, vel, acc;
  float bounce = -.7;            //Valeur du rebond : négatif pour que les particules remontent

  int hits = 0;                  //Permet de créer un effet d'explosion
  float life = random(100, 250);
  float maxLife = life;
  color activeColor = #5620AF;
  PGraphics scene;

  ParticleSphere(PVector loc, PVector acc, color activeColor) {
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
     Créé un effet d'explosion une seule fois et quand les gouttes touchent le sol
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

    if (dist(loc.x, loc.y, loc.z, 0, 0, 0)> box) {
      vel.x *= bounce;
      vel.y *= bounce; 
      vel.z *= bounce; 
    }
  }
}
