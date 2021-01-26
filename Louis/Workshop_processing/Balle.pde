class Balle {
  float x;
  float y;
  float y_fond = 0;
  float vitesseY;
  color couleur;
  float Balle;

  Balle (float nouvX, float nouvY, color nouvCouleur) {
    x          = nouvX;
    y          = nouvY;
    couleur    = nouvCouleur;
  }


  void display() {
    for (int i = 0; i < 300; i+=9) {
      float x = cos(radians(i)) * 30 + width / 2; //Largeur de la forme
      float y_halo = sin(radians(i)) * 30 + height / 2; //Hauteur de la forme
      float w = sin(radians(frameCount+i/2)) * 50;
      w = abs(2+w); //Taille de la forme

      float col=map(i, 7, 230, 20, 255);

      noStroke();
      fill(255, 255, 240, 88); //Couleur + apparition
      ellipse(x, y + y_halo, w, w);
    }
  }

  float getYFond(){
    return y_fond;
  }
  
   void setYFond(float y_fond_in){
    y_fond = y_fond_in;
  }

  void bouge() { //Mouvement de la balle
    y_fond = y_fond + vitesseY; //Changement de taille à chaque action
    y = y + vitesseY;
    
    if (y < -100){
       y = -100; 
    }else if(y > 500){
      y = 500;
    }
  }

  void monte(float val) {
    y_fond = y_fond - val;
  }
  void changeVitesse(float vit) { //Changement de la vitesse de la balle
    vitesseY = vit;
  }
  
  }
                                    
