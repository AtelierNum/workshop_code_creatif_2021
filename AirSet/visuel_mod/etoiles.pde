//Parametre de la classe etoile 
class Star {
  float x;
  float y;
  float z;
  
  //Mouvement aleatoire des etoiles sur l'axe x et y 
  Star() {
    x= random(-width*4, width*4);
    y= random(-height*4, height*4);
    z= random(0, width*10);
  }
  
  //Rotation aleatoire des etoiles sur l'axe x et y 
  void update () {
    x = x + (cos(radians(frameCount)) * 10 * noise((float)frameCount*0.01 ));
    y = y + (sin(radians(frameCount)) * 10 * noise((float)frameCount*0.02 ));
  }

  //Graphisme des etoiles 
  void show () {
    fill (255);
    noStroke();
    ellipse(x, y, 3, 3);
  }
}
