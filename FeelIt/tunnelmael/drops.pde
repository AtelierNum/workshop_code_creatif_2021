class Drop {
  //Variables dont les valeurs sont liées au hasard
  float x = random(width);
  float y = random(-500, -50);
  float z = random(0,20);
  //float zz = random(z_min, z_max);
  float len = map(z, 200, 20, 10, 20);
  float yspeed = map(z, 0, 20, 1, 20);
  
  //Définir la chute des gouttes
  void fall() {
    y = y + yspeed;
    float grav = map(z, 0, 20, 0, 0.2);
    yspeed = yspeed + grav;
    
    if (y > height) {
      y = random(-200,-100);
      yspeed = map(z, 0, 20, 4, 10);
    }
  }
  //Définir la taille et la largeur des gouttes
  void show() {
    float thick = map(z, 0, 80, 1, 3);
    strokeWeight(thick);
    stroke(0);
    line(x,y, x,y+len);
  } 
  
}
