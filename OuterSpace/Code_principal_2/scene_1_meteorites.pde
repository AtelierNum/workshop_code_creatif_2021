


//code pour les météorites
//code trouvé sur processing

void setup_meteorites() {
  int numSpots = 350;
  int dia = width/numSpots; 
  spots = new Spot[numSpots]; 
  for (int i = 0; i < spots.length; i++) {
    float x = dia/2 + i*dia;
    float rate = random(0.1, 2.0);

    spots[i] = new Spot(x, 20, dia, rate);
  }
  noStroke();
}
void draw_meteorites() {
  noStroke();
  fill(random(235), random (90), random (255));
  for (int i=0; i < spots.length; i++) {
    spots[i].move();
    spots[i].display(); 
  }
}
