//Cet onglet est destine a l'utilisation du leapmotion. La detection mais aussi
//les filtres audios.

void leapmo() {

  //Recupere les infos captees par le leapmotion et permet de differencier main gauche et main droite
  for (Hand hand : leap.getHands()) { 

    Hand handIsLeft = leap.getLeftHand();
    Hand handIsRight = leap.getRightHand();

    //----------------------- LEFT HAND ----------------------------------

    if (hand.isLeft()) {

      //on recupere les information de position de l'index et de l'auriculaire
      Finger index = handIsLeft.getIndexFinger();
      PVector posl = index.getPosition();
      Finger pink = handIsLeft.getPinkyFinger();
      PVector poslp = pink.getPosition();

      //on les affiche a l'ecran sous forme de cercles
      noFill();
      stroke(240);
      ellipse(posl.x, posl.y, 80, 80);
      ellipse(poslp.x, poslp.y, 80, 80);


      //on recupere la position de l'index sous forme de vecteur
      float[] vl = posl.array();
      //on transforme la valeur du vecteur X en variable
      test1 = (vl[0]);
      
      //utilisation de la variable. On la convertie en une autre variable
      //Afin de pouvoir definir une plage de valeur sur laquelle celle-ci evolue.
      float ratel = map(test1, 0, width, 0.01, 6); 
      float ratel2 = map(test1, 0, width, 0.05, 6);


      //permet d'eviter le croisement des deux mains. Les valeurs
      //maxs sont atteintent a la moitie de l'ecran.
      if ((vl[0]) > width/2) {
        ratel = 2;
      }
      
      //securite pour le son 
      if (ratel2 < 0.01) {
        ratel2 = 0.01;
      }

      //si l'index et l'auriculaire sont assez espaces, alors on applique le filtre
      if (posl.x - poslp.x > 140) {
        moog.frequency.setLastValue( ratel2*1000 );
        moog.resonance.setLastValue( ratel*0.01  );
      }

     //si l'index et l'auriculaire sont peu espaces, alors on applique le filtre
     //(cela necessite de fermer le poing)
      if (posl.x - poslp.x < 140) {
        float cutoff = map(vl[1], 0, height, 5000, 17000);
        hpf.setFreq(cutoff);
      }
    } 

    //----------------------- RIGHT HAND ----------------------------------  


    if (hand.isRight()) {
      
      //on recupere les information de position de l'index et de l'auriculaire
      Finger index = handIsRight.getIndexFinger();
      PVector posRi = index.getPosition();
      Finger pink = handIsRight.getPinkyFinger();
      PVector posRp = pink.getPosition();

      //on les affiche a l'ecran sous forme de cercles
      stroke(240);
      noFill();
      ellipse(posRp.x, posRp.y, 40, 40);
      ellipse(posRi.x, posRi.y, 40, 40);

      //on recupere la position de l'index sous forme de vecteur
      float[] v = posRi.array();
      //on transforme la valeur du vecteur X en variable
      test = (v[0]);
      
      //si l'auriculaire est plus proche de 0 sur l'axe X, modification
      //de la vitesse selon l'axe X de l'index
      if (posRp.x - posRi.x > 40) {
        float rate = map(test, width/2, width, 0.5, 1.5); 
        rateControl.value.setLastValue(rate);
      }
      
      //si la main droite dépasse la fenetre par la droite 
      //la vitesse par defaut est retablie. securite de 75pixels.
      print (v[0]); 
      if ((v[0]) > width + 75) {
        test = 3*width/4 ;
      }

      //si l'auriculaire est moins proche de 0 sur l'axe X, modification
      //de la vitesse selon l'axe Y de l'index
      if (posRp.x - posRi.x < 40) {
        float dB = map(v[1], 0, height, 10, 0);
        gain.setValue(dB);
      }
    }
  }
}
