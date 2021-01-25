class Particle {
  float xPos, yPos, direction, speed, size;
  Firework creator;
//Définir la création du feu d'artifice : position, vitesse, taille
  Particle(Firework c) {
    creator = c;
    xPos = creator.xPos;
    yPos = creator.yPos;
    direction = random(2*PI);
    speed = random(1, 7);
    size = random(3, 10);
  }

  void render() {
    if (size < 0)
      return;
    xPos += sin(direction) * speed;
    yPos += cos(direction) * speed;
    // direction += 0.01;
    size -= 0.1;

    // fill(255,0,0);
    noStroke();
    ellipse(xPos, yPos, size, size);
  }
}
//Créer le feu d'artifice
class Firework {
  float xPos, yPos; 
  color colour;
  ArrayList<Particle> lights = new ArrayList();

//Relier aux variables de la classe particule
  Firework (float x, float y) {
    xPos = x;
    yPos = y;
    colour = color(random(255), random(255), random(255));
    for (int iter = 0; iter < 50; iter++)
      lights.add(new Particle(this));
  }

  void render() {
    fill(colour);
    for (Particle thisParticle : lights)
      thisParticle.render();
  }
}
