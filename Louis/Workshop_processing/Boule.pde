

class Boule {
  float x, y; // coordonnées dans l'espace virtuel
  float d; // diametre de l'objet
  float opacite; // opacité
  float vx, vy; // déplacement sur les deux axes
  color c; // couleur


  Boule(int _largeur, int _hauteur) { 
    x = random(_largeur); // position aléatoire
    y = random(_hauteur);
    d = random(5, 25); // diamètre aléatoir entre5 et 24
    vx = random (-0.5, 0.5); //déplacement au hasard influe sur la vitesse
    vy = random (-0.5, 0.5);
    opacite = d*10; // opacité liée au diamètre
    c = color(random (255), random (255), random (255), opacite);
  }
  void deplacer() { // paramètres de déplacements
    x= x+ vx; 
    y= y+ vy;

    if (x < 0) vx = -vx;// inversion de la valeur de déplacement sur x
    if (x > espace_largeur) vx = -vx; // "rebondit" sur l'espace virtuel
    if (y < 0)vy =-vy;  //  inversion de la valeur de déplacement sur y
    if (y > espace_hauteur) vy = -vy;
  }


  // Cet élément apparaît il dans la fenêtre ?
  // _x, _y : origine de la fenêtre d'affichage dans l'espace virtuel
  // _l, _h : largeur et hauteur de la fenêtre d'affichage
  boolean visible(int _x, int _y, int _l, int _h) {
    if ( (x >= _x) && (x < (_x + _l)) && (y >= _y) && (y < (_y + _h)) ) {
      return true;
    } else return false;
  }


  // Afficher l'objet en fonction de la position de l'origine de la fenêtre d'affichage
  void dessiner(int _x, int _y) {

    // dégradé de couleur des boules par intervalles sur y
    if ((8700<y) && (y<9000)) {
      c= color (#3FA4BC);
    }
    if ((8500<y) && (y<8700)) {
      c= color (#71BCBA);
    }
    if ((8400<y) && (y<8500)) {
      c= color (#AFDBDA);
    }
    if ((8100<y) && (y<8400)) {
      c= color (#FFFAE3);
    }
    if ((7800<y) && (y<8100)) {
      c= color (#FFFAE3);
    }
    if ((7500<y) && (y<7800)) {
      c= color (#EFCCA4);
    }
    if ((7000<y) && (y<7500)) {
      c= color (#F2BA8E);
    }
    if ((6700<y) && (y<7000)) {
      c= color (#F0986D);
    }
    if ((6300<y) && (y<6700)) {
      c= color (#E47A5E);
    }
    if ((6000<y) && (y<6300)) { // 
      c= color (#DE6B57);
    }
    if ((5700<y) && (y<6000)) {
      c= color (#D65F53);
    }
    if ((5400<y) && (y<5700)) {
      c= color (#BE5A59);
    }
    if ((5000<y) && (y<5400)) {
      c= color (#B85959);
    }
    if ((4700<y) && (y<5000)) {
      c= color (#A9565C);
    }
    if ((4400<y) && (y<4700)) {
      c= color (#A06A7B);
    }
    if ((4000<y) && (y<4400)) {
      c= color (#846979);
    }
    if ((3700<y) && (y<4000)) {
      c= color (#75758E);
    }  
    if ((3400<y) && (y<3700)) {
      c= color (#8F8FAA);
    }
    if ((3000<y) && (y<3400)) {
      c= color (#A7A7D1);
    }
    if ((2700<y) && (y<3000)) {
      c= color (#AAAAF2);
    }
    if ((2400<y) && (y<2700)) {
      c= color (#C0C0FF);
    }
    if ((2000<y) && (y<2400)) {
      c= color (#D7D7FF);
    }
    if ((1000<y) && (y<2000)) {
      c= color (#FFFFFF);
    }


    noStroke();
    fill (c, 80); // couleur et valeur d'opacité
    // effet de flou par superpostion d'ellipse, d'opacité et de dimaètre différent
    for (int i=0; i<6; i= i+1) { 
      ellipse(x - _x, y - _y, d- i*5, d - i*5);
    }
  }
}
