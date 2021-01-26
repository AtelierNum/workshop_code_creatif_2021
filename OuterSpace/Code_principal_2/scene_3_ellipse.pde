class Ellipse {
  float x, y; // coordonnées de la balle
  float vx, vy; // déplacement sur les deux axes


  //location de l'epllipse
  Ellipse() {
    x=width/2;
    y=height/2;
    vx=random(-6, 6);
    vy=random(-1, 1);
  }

  //déplacement de l'ellipse
  void deplacer() {
    x=x+vx;
    y=y+vy;
    if ((x<0||x>width)) vx=-vx;
    if ((y<0||y>height)) vy=-vy;
  }

  //forme de l'ellipse coloré
  void dessiner() {
    noStroke();
    fill(random(100),random(100),random(255));
    ellipse(x+random(5),y+random(20),5,5);
  }

  //forme de l'ellipse blanc
  void dessiner2() {
    
    fill(255);
    ellipse(x+random(5),y+random(20),2,2);
  }
}
