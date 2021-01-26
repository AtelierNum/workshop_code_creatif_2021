//Classe parent des univers d'emotion
class Univers {
  // attributs communs a tous les univers 
  float fade = 0;   
  float facteurVitesse1;
  float facteurVitesse2;
  SoundFile sound;
  ArrayList particles = new ArrayList(); 
  ArrayList<Integer> colours = new ArrayList<Integer>();
  int maxDroplet = 1;
  color activeColor = #000000;
  PGraphics scene; 
  
// Définition des univers, leur source de son, leur couleur et le changement de vitesse 
  Univers(SoundFile sound, color colorOne, color colorTwo, color colorThree, color colorFour, float facteurVitesse1, float facteurVitesse2) {
    
    colours.add(colorOne);
    colours.add(colorTwo);
    colours.add(colorThree);
    colours.add(colorFour);
    this.sound = sound;
    this.facteurVitesse1 = facteurVitesse1;
    this.facteurVitesse2 = facteurVitesse2;
  }

  //Permet que le son dimunue ou augmente progressivement 
  void update(PGraphics pg) {
   if (leap.getHands().size() == 0) {    //Le son diminue progressivement avant de s'arrêter
      fade -= 0.02;
    } else {                             //Le son augmente progressivement pour démarrer
      fade += 0.02;
    }

    if (fade <= 0) {                     //Le son s'arrête quand la main n'est plus visible
      if (sound.isPlaying()) {
        sound.pause();
      }
      fade = 0;
    } else if (fade >= 1) {
      fade = 1;
    }

    for (Hand hand : leap.getHands ()) { 
      // Récupération des données capturé par le leap motion
      // les attribut non utilisé pour ce projet on été mis en commentaire
      // ==================================================

      // int     handId             = hand.getId();
      PVector handPosition       = hand.getPosition();
      // PVector handStabilized     = hand.getStabilizedPosition();
      // PVector handDirection      = hand.getDirection();
      // PVector handDynamics       = hand.getDynamics();
      // float   handRoll           = hand.getRoll();
      // float   handPitch          = hand.getPitch();
      // float   handYaw            = hand.getYaw();
      // boolean handIsLeft         = hand.isLeft();
      // boolean handIsRight        = hand.isRight();
      float   handGrab           = hand.getGrabStrength();
      // float   handPinch          = hand.getPinchStrength();
      // float   handTime           = hand.getTimeVisible();
      // PVector spherePosition     = hand.getSpherePosition();
      // float   sphereRadius       = hand.getSphereRadius();

      // --------------------------------------------------
  
      /*
      Calculer la vitesse du son en fonction de la position en X de la main
      On utilise un produite en croix pour transformer cette position en une valeur
      de vitesse de lecture entre facteurVitesse1 (très lent) et facteurVitesse2
      */
      float vitesse = map(handPosition.x, width, 0, facteurVitesse1, facteurVitesse2);
      if (!sound.isPlaying()) {
        sound.play(1, 1);
      } else {
        sound.rate(vitesse);
      }
      
      //Selon la position en X de la main, la couleur des points change
      if (handPosition.x < 0.25 * width) {
        maxDroplet = 1;
        activeColor = colours.get(0);
      } else if (handPosition.x < 0.5 * width) {
        maxDroplet = 6;
        activeColor = colours.get(1);
      } else if (handPosition.x < 0.75 * width) {
        maxDroplet = 9;
        activeColor = colours.get(2);
      } else {
        maxDroplet = 15;
        activeColor = colours.get(3);
      }
      // Ne créé des goute qu'une image sur trois
      // Attention, plus le nombre (ici 3) est faible plus le nombre de gouttes
      // est important, ce qui entraine un ralentissement de l'application
      if ((frameCount % 3) == 0) {
        for (int droplet = 0; droplet < maxDroplet; droplet++) {
          updateDroplets();  //Créer et met à jour les gouttes
        }
      }
      //Déplace le centre de rotation de l'univers
      pg.translate(pg.width/2, 0.5 * pg.height);
      pg.rotateY(radians(1+handPosition.y/3));
      pg.stroke(255);
     
      for (int i = 0; i < particles.size (); i++) {
        updateParticles(pg, handGrab, i);
      }
    }                                                                                                                                                                                                                                    
  }
  
  //Arrête la musique de cet univers
  void stopSound() {
    sound.stop();
  }
  
  //Fonction devant être remplie dans les classes enfants
  void updateDroplets() {};
  
  //Fonction devant être remplie dans les classes enfants
  void updateParticles(PGraphics pg, float handGrab, int particuleIndex) {};
}
