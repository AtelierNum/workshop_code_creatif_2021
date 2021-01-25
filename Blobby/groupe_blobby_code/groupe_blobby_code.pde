import de.voidplus.leapmotion.*;
import processing.sound.*;

boolean DEBUG = false;
boolean DEV = false;


boolean pick_with_mouse = false;

//Leap Motion

LeapMotion leap;

//Yeux
int t = millis();
int t2 = millis();
float easing= 0.075;
float randBlink = 10; //clignement

//s pour size qui définit la taille des blobs
int s = int(random(500)); 

//Blob
Blob blob;
Blob blob2;

ArrayList<Blob> blobs = new ArrayList<Blob>();


//Collision
float absorption = 0.5; // plus ou moins la capacité d'absorption des chocs lorsqu'il y a collision

PVector gravite = new PVector(0, 0.15);

//Fond
PImage photo;

//overlay
PFont title;
PFont undertitle;
Veille v;
int mouse_timer; // créer comme un timer

//Son

// Créer un objet de la classe Soundfile nommé son1;
SoundFile sonfond;
SoundFile attrape;
SoundFile lache;
SoundFile lance;
SoundFile tombe;
SoundFile disparait;

PVector pos_index = new PVector(0, 0);
PVector p_pos_index = new PVector(0, 0);

PVector pos_pinky = new PVector(0, 0);
PVector p_pos_pinky= new PVector(0, 0);


boolean is_pinched;


PVector pos_index2= new PVector(0, 0);
PVector p_pos_index2= new PVector(0, 0);

PVector pos_pinky2= new PVector(0, 0);
PVector p_pos_pinky2= new PVector(0, 0);

boolean is_pinched2;

void setup() {
  leap = new LeapMotion(this);


  fullScreen();
  //size(1000, 1000);
  photo = loadImage ("Fondtele.png");  // ordi= Fondordi.png    télé= Fondtele.png   existe pas-->Grande télé = FondGtele.png

  mouse_timer = - 30000; // initialiser le timer

  //Constructeur des blobs
  for (int i = 0; i < 20; i++) {
    float diametre = random(400, 500);
    blobs.add(new Blob(random(width), random(height), diametre, random(9999), i, this));
  }
  if (!DEV) {
    //jouer la musique de fond
    sonfond = new SoundFile(this, "erik-satie.wav");
    sonfond.play(1, 0.5);
  }

  //Initialisation du texte
  title = loadFont("MontserratAlternates-Bold-200.vlw");
  undertitle = loadFont("MontserratAlternates-Medium-100.vlw");

  //Ecran de veille
  v= new Veille();

  //bruitages
  attrape = new SoundFile(this, "Attraper.wav");
  lache = new SoundFile(this, "Lache.wav");
  lance = new SoundFile(this, "Lance.wav");
  disparait = new SoundFile(this, "Disparission.wav");
}

void draw() {

  //On définit les position des index et des auriculaires
  p_pos_index = pos_index;
  p_pos_pinky = pos_pinky;
  p_pos_pinky2 = pos_pinky2;
  p_pos_index2 = pos_index2;

  println(pos_index);

  //Affichage du fond
  image(photo, 0, 0);


  //boubles qui permettent d'attraper les blobs
  for (int i = 0; i < blobs.size(); i++) {
    Blob b = (Blob)blobs.get(i);
    if (b.picked) {
      if (pick_with_mouse) {
        b.position.x = mouseX;
        b.position.y = mouseY;
      } else {
        b.position.x = pos_index.x;
        b.position.y = pos_index.y;
      }
    }

    if (b.picked2) {
      if (pick_with_mouse) {
        b.position.x = mouseX;
        b.position.y = mouseY;
      } else {
        b.position.x = pos_index2.x;
        b.position.y = pos_index2.y;
      }
    }
  }


  //Collision
  //D'après le code de Pierre Commenge

  for (Blob blob : blobs) {

    // rechercher les collisions avec les autres blobs
    // deux blobs sont en collision quand la distance qui les sépare est inférieure à la somme de leurs rayons

    for (Blob blob2 : blobs) {
      if (blob2.id != blob.id) { // le blobs ne peut pas entrer en collision avec lui-même!

        // Calculer la distance entre les centres des deux blobs
        float distance = dist(blob.position.x, blob.position.y, blob2.position.x, blob2.position.y);

        // calculer la somme des rayons
        float distance_entre_centres = blob.diametre/2  + blob2.diametre/2  ;

        if (distance < distance_entre_centres) { // Une collision a lieu!
          float angle = atan2(blob2.position.y - blob.position.y, blob2.position.x - blob.position.x);

          float ax = (blob.position.x + cos(angle) * distance_entre_centres) - blob2.position.x;
          float ay = (blob.position.y + sin(angle) * distance_entre_centres) - blob2.position.y;

          blob.velocite.x  -= ax * absorption;
          blob.velocite.y  -= ay * absorption;
          blob2.velocite.x += ax * absorption;
          blob2.velocite.y += ay * absorption;
          blob.velocite.limit(5); // Limiter la vélocité maximum
          blob2.velocite.limit(5);
        }
      }
    }

    blob.deplacer();
    blob.draw();

    float picking = dist(mouseX, mouseY, blob.position.x, blob.position.y);
    if (picking < blob.diametre/2 && mousePressed) {
      blob.position.x=mouseX;
      blob.position.y=mouseY;
    }
  }


  //Afficher valeurs de debug
  if (DEBUG) {
    fill(255);
    textFont(undertitle, 10);
    text(frameRate, 100, 100);
    textSize(30);
  }
  if (!DEBUG) {
    noCursor();
  };


  //Timer permettant de gerer l'ecran de veille
  if (millis() - mouse_timer > 10000) { 
    // si la souris ne bouge pas pendant 20 secondes alors on affiche l'écran de Veille 
    v.afficher();
  }


  float   handPinch = 0;
  float   handPinch2 = 0;


  //LeapMotion
  for (Hand hand : leap.getHands ()) {
    mouse_timer = millis();

    if (hand.isLeft()) {
      handPinch2 = hand.getPinchStrength();
    }
    if (hand.isRight()) {
      handPinch  = hand.getPinchStrength();
    }

    for (Finger finger : hand.getFingers()) {
      if (hand.isRight()) {
        if (finger.getType() == 4) {
          pos_pinky =  finger.getPosition();
        }

        if (finger.getType() == 1) {
          pos_index =  finger.getPosition();
          PVector pos = finger.getPosition();
          stroke(255, 0, 0);
          strokeWeight(4);
          noFill();
          ellipse(pos.x, pos.y, 20, 20);//Afficher un cercle sur la main
        }
        if (DEBUG) {
          text(handPinch, 100, 200);
        }
      }

      if (hand.isLeft()) {
        if (finger.getType() == 4) {
          pos_pinky2 =  finger.getPosition();
        }


        if (finger.getType() == 1) {
          pos_index2 =  finger.getPosition();
          PVector pos = finger.getPosition();
          stroke(255, 255, 0);
          strokeWeight(4);
          noFill();
          ellipse(pos.x, pos.y, 20, 20);//Afficher un cercle sur la main
        }
        if (DEBUG) {
          text(handPinch2, 100, 300);
        }
      }
    }
  }

  //Détection lorsque l'on attrape un blob avec la main
  if (handPinch2 > 0.9 && handPinch > .9) {
    pickdouble(pos_index2.x, pos_index2.y, pos_index.x, pos_index.y);
  } else {
    if (handPinch > 0.95) {
      if (!is_pinched) {
        is_pinched = true; 
        pick(pos_index.x, pos_index.y, 0);
        pick_with_mouse = false;
      }
    } else {
      if (is_pinched) {
        is_pinched = false;
        unpick(pos_pinky.x, pos_pinky.y, p_pos_pinky.x, p_pos_pinky.y);
        //release
      }
    }

    if (handPinch2 > 0.95) {
      if (!is_pinched2) {
        is_pinched2 = true; 
        pick(pos_index2.x, pos_index2.y, 1);
        pick_with_mouse = false;
      }
    } else {
      if (is_pinched2) {
        is_pinched2 = false;
        unpick(pos_pinky2.x, pos_pinky2.y, p_pos_pinky2.x, p_pos_pinky2.y);
        //release
      }
    }
  }
}

//Faire disparaitre un blob quand le prend avec les 2 mains
void pickdouble(float mx, float my, float mx2, float my2) { 
  for (int i = 0; i < blobs.size(); i++) {
    Blob b = (Blob)blobs.get(i);
    float picking1 = dist(mx, my, b.position.x, b.position.y);
    float picking2 = dist(mx2, my2, b.position.x, b.position.y);
    if (picking1 < b.diametre/2 && picking2 < b.diametre/2) {
      blobs.remove(i);
      disparait = new SoundFile(this, "Disparition.wav");
      disparait.play(1, 0.7);
    }
  }
}


//Fonction permettant de détecter lorsque l'on attrape les blobs et de jouer le son "attrape"
void pick(float mx, float my, float handID) {
  for (int i = 0; i < blobs.size(); i++) {
    Blob b = (Blob)blobs.get(i);
    float picking = dist(mx, my, b.position.x, b.position.y);
    if (picking < b.diametre/2) {

      if (handID == 0) b.picked = true;
      if (handID == 1) b.picked2 = true;
      attrape.play(1, 0.5);
    }
  }
}

//Fonction permettant de détecter lorsque l'on lache les blobs et de jouer le son "attrape"
void unpick(float px, float py, float ppx, float ppy) {
  for (int i = 0; i < blobs.size(); i++) {
    Blob b = (Blob)blobs.get(i);
    // On lache le blob
    if (b.picked) {
      b.velocite.x = (px - ppx) * 1;
      b.velocite.y = (py - ppy) * 1;

      if (b.velocite.y <0) { 
        lance.play(1, 0.5);
      } else {
        lache.play(1, 0.5);
      }
    }
    b.picked = false;

    if (b.picked2) {
      b.velocite.x = (px - ppx) * 1;
      b.velocite.y = (py - ppy) * 1;

      if (b.velocite.y <0) { 
        lance.play(1, 0.5);
      } else {
        lache.play(1, 0.5);
      }
    }
    b.picked2 = false;
  }
}

void mouseMoved() {
  mouse_timer = millis(); // on réinitialise le timer : on dit que la dernière fois que la souris à bougé c'est maintenant
}



void leapOnInit() {
  println("Leap Motion Init");
}
void leapOnConnect() {
  println("Leap Motion Connect");
}
void leapOnFrame() {
  //println("Leap Motion Frame");
}
void leapOnDisconnect() {
  // println("Leap Motion Disconnect");
}
void leapOnExit() {
  // println("Leap Motion Exit");
}
