import processing.sound.*; //Importation de la librairie sound

AudioIn input;  //Création d'une entrée audio interne
AudioIn micro;  //Création d'une entrée audio micro
Amplitude amp;  //Création d'une valeur d'amplitude "amp"
Amplitude pdg;  //Création d'une valeur d'amplitude "pdg"
int samples = 100;  //Nombre de son récupéré et analysé


import oscP5.*;  //Importation de la librairie oscP5
import netP5.*;  //Importation de la librairie netP5

OscP5 oscP5;  //Création d'une valeur OscP5 "oscP5"

int compteur;
int time = 0;// Création d'une variable time qui prend la valeurs 0 (int = nombre entier)
PImage masque;  //Création nom pour une Image = masque1
PImage point;



float pgx;  //Création de variable ici "pgx" pour le abscisse du poignet gauche 
float pgy;  //Création de variable ici "pgy" pour l'ordonnée du poignet gauche
float pdx;  //Création de variable ici "pdx" pour l'abscisse du poignet droit
float pdy;  //Création de variable ici "pdy" pour l'ordonnée du poignet droit
float nx;  //Création de variable ici "nx" pour l'abscisse du nez
float ny;  //Création de variable ici "ny" pour l'ordonnée du nez
float klx;  //Création de variable ici "klx" pour l'abscisse du genou gauche( knee left )
float kly;  //Création de variable ici "kly" pour l'ordonnée du genou gauche( knee left )
float krx;  //Création de variable ici "krx" pour l'abscisse du genou droit( knee right )
float kry;  //Création de variable ici "kry" pour l'ordonnée du genou droit( knee right )
float slx;  //Création de variable ici "slx" pour l'abscisse de l'épaule gauche (shoulder left)
float sly;  //Création de variable ici "sly" pour l'ordonnée de l'épaule gauche (shoulder left)
float srx;  //Création de variable ici "srx" pour l'abscisse de l'épaule droite (shoulder right)
float sry;  //Création de variable ici "sry" pour l'ordonnée de l'épaule droite (shoulder right)
float hlx;  //Création de variable ici "hlx" pour l'abscisse de la hanche gauche (hips left)
float hly;  //Création de variable ici "hlx" pour l'ordonnée de la hanche gauche (hips left)  
float hrx;  //Création de variable ici "hrx" pour l'abscisse de la hanche droite (hips right)
float hry;  //Création de variable ici "hry" pour l'ordonnée de la hanche droite (hips right)
float elx;  //Création de variable ici "elx" pour l'abscisse du coude gauche (elbow left)
float ely;  //Création de variable ici "ely" pour l'ordonnée du coude gauche (elbow left)
float erx;  //Création de variable ici "erx" pour l'abscisse du coude droit (elbow right)
float ery;  //Création de variable ici "ery" pour l'ordonnée du coude droit (elbow right)





Blob blob1;  //Nous avons crée une classe Blob et nous nommons les différents blobs présent 
Blob blob2;  //En tout il y aura 12 blob présentent sur notre visuel
Blob blob3; 
Blob blob4;  
Blob blob5;
Blob blob6;
Blob blob7;
Blob blob8;
Blob blob9;
Blob blob10;
Blob blob11;
Blob blob12;


boolean mode_menu = false;   //Nous avons crée un vrai/faux pour afficher un menu
PImage[] avatar = new PImage[12];  //Nous avons aussi crée une liste d'avatar
int nb_avatar = 0;  // et une variable qui par défault vaut 0


void setup() {                                   //Notre void setup
  fullScreen();                                  //On a mis notre projet en full écran comme ça il pourra s'adapter à tous les écrans
  frameRate(60);                                 //On a mis 60 images par seconde
  point = loadImage("point2.png");
  oscP5 = new OscP5(this, 12000);                //On a identifié le port qui recevra les informations du téléphone

  input = new AudioIn(this, 0);                  //On a identifié l'entrée audio ici le son
  input.start();                                 //Input démarre dès le lancement


  micro = new AudioIn(this, 0);                  //Entrée micro
  micro.start();                                 //Le micro démarre dès le lancement
  pdg = new Amplitude(this);                     //pdg reçoit une amplitude
  pdg.input(micro);                              //pdg reçoit les infos du micro

      
  imageMode(CENTER);                             //On change le repère de l'image pour qu'elle soit centré sur un point

  blob1 = new Blob(this, "beat1.wav", width*0.15, height*0.25, 25, 50, 2);    //ici sont identifiées les variables de chaque blob
  blob2 = new Blob(this, "loop2.wav", width*0.15, height*0.75, 25, 50, 1);     //On retrouve le son qui leur est attribué, leurs positions (reponsives) et leurs tailles
  blob3 = new Blob(this, "bruit.wav", width*0.5, height*0.12, 25, 50, 2);
  blob4 = new Blob(this, "beat2.wav", width*0.30, height*0.15, 25, 50, 2);
  blob5 = new Blob(this, "loop3.wav", width*0.85, height*0.75, 25, 50, 1);
  blob6 = new Blob(this, "loop4.wav", width*0.70, height*0.85, 25, 50, 1);
  blob7 = new Blob(this, "beat3.wav", width*0.85, height*0.25, 25, 50, 2);
  blob8 = new Blob(this, "beat4.wav", width*0.70, height*0.15, 25, 50, 2);
  blob9 = new Blob(this, "beat5.wav", width*0.9, height*0.5, 25, 50, 2);
  blob10 = new Blob(this, "loop1.wav", width*0.30, height*0.85, 25, 50, 1);
  blob11 = new Blob(this, "loop5.wav", width*0.5, height*0.88, 25, 50, 1);
  blob12 = new Blob(this, "beat6.wav", width*0.10, height*0.5, 25, 50, 2);
  
  avatar[0] = loadImage("Masque1.png");  //On a ici, nommé chaque avatar et le masque qui lui correspond
  avatar[1] = loadImage("Masque2.png");
  avatar[2] = loadImage("Masque3.png");
  avatar[3] = loadImage("Masque4.png");
  avatar[4] = loadImage("Masque5.png");
  avatar[5] = loadImage("Masque18.png");
  avatar[6] = loadImage("Masque7.png");
  avatar[7] = loadImage("Masque13.png");
  avatar[8] = loadImage("Masque14.png");
  avatar[9] = loadImage("Masque15.png");
  avatar[10] = loadImage("Masque16.png");
  avatar[11] = loadImage("Masque17.png");
  
  masque = avatar[nb_avatar];             //la variable masque télécharge l'image "MasqueX.png" ( on propose 5 masques différents )   
}

void draw() {     //notre void draw
  if (mode_menu) { //Ici notre affichage du menu
    
    background(0); //background noir
    
    image(avatar[0],  width*0.15, height*0.25, 180, 180);   //Les différents avatars et leurs positions ( qui sont toujours responsives)
    image(avatar[1], width*0.5, height*0.12, 180, 180);
    image(avatar[2], width*0.30, height*0.15, 180, 180);
    image(avatar[3],width*0.70, height*0.15, 180, 180);
    image(avatar[4], width*0.85, height*0.25, 250, 250);
    image(avatar[5],  width*0.15, height*0.75, 250, 250);
    image(avatar[6],  width*0.85, height*0.75, 250, 250);
    image(avatar[7],  width*0.70, height*0.85, 250, 250);
    image(avatar[8],  width*0.9, height*0.5, 250, 250);
     image(avatar[9],  width*0.30, height*0.85, 350, 350);
      image(avatar[10],  width*0.5, height*0.88, 350, 350);
       image(avatar[11],  width*0.10, height*0.5, 350, 350);
        
    
    
    //On a reformé le squellette
    stroke(255);
    strokeWeight(30);   //ici on retrouve les lignes qui relient les points du squellette   
    strokeCap(ROUND);   //Les extrémités sont rondes
    line(pgx, pgy, elx, ely);  //Le poignet gauche au poignet gauche

    line(elx, ely, slx, sly);

    line(slx, sly, srx, sry);

    line(srx, sry, erx, ery);

    line(erx, ery, pdx, pdy);

    line(slx, sly, hlx, hly);

    line(srx, sry, hrx, hry);

    line(hlx, hly, hrx, hry);
    
    image(point, nx, ny, 180, 250); //L'image de la tête dans le menu est le point
    
    
    
   
    //Ici on retrouve notre if pour la selection des avatars
    if( dist( width*0.5, height*0.12,pgx,pgy)<150){ //La distance entre la position de l'image et notre poignet gauche
      masque = avatar[1];  //On prend l'avatar 1
      mode_menu = false;    //et on retourne à l'affichage avec les musiques
    }
    if( dist( width*0.15, height*0.25,pgx,pgy)<150){
      masque = avatar[0];
      mode_menu = false;    
    }
    if( dist( width*0.30, height*0.15,pgx,pgy)<150){
      masque = avatar[2];
      mode_menu = false;    
    }
    if( dist( width*0.70, height*0.15,pgx,pgy)<150){
      masque = avatar[3];
      mode_menu = false;    
    }
     
     if( dist( width*0.85, height*0.25,pgx,pgy)<150){
      masque = avatar[4];
      mode_menu = false;    
    }
    
    if( dist( width*0.15, height*0.75,pgx,pgy)<150){
      masque = avatar[5];
     mode_menu = false;    
    }
    if( dist( width*0.85, height*0.75,pgx,pgy)<150){
      masque = avatar[6];
      mode_menu = false;    
    }
    if( dist( width*0.70, height*0.85,pgx,pgy)<150){
      masque = avatar[7];
      mode_menu = false;    
    }
    if( dist(  width*0.9, height*0.5,pgx,pgy)<150){
      masque = avatar[8];
      mode_menu = false;  
    }
     if( dist(  width*0.30, height*0.85,pgx,pgy)<150){
      masque = avatar[9];
      mode_menu = false;    
    }
      if( dist(  width*0.5, height*0.88,pgx,pgy)<150){
      masque = avatar[10];
      mode_menu = false;    
    }
     if( dist(   width*0.10, height*0.5,pgx,pgy)<150){
      masque = avatar[11];
      mode_menu = false;    
    }
    if( dist( width*0.5, height*0.12,pdx,pdy)<150){
      masque = avatar[1];
      mode_menu = false;    
    }
    if( dist( width*0.15, height*0.25,pdx,pdy)<150){
      masque = avatar[0];
      mode_menu = false;    
    }
    if( dist( width*0.30, height*0.15,pdx,pdy)<150){
      masque = avatar[2];
      mode_menu = false;    
    }
    if( dist( width*0.70, height*0.15,pdx,pdy)<150){
      masque = avatar[3];
      mode_menu = false;    
    }
     
     if( dist( width*0.85, height*0.25,pdx,pdy)<150){
      masque = avatar[4];
      mode_menu = false;    
    }
    
    if( dist( width*0.15, height*0.75,pdx,pdy)<150){
      masque = avatar[5];
      mode_menu = false;    
    }
    if( dist( width*0.85, height*0.75,pdx,pdy)<150){
      masque = avatar[6];
      mode_menu = false;    
    }
    if( dist( width*0.70, height*0.85,pdx,pdy)<150){
      masque = avatar[7];
      mode_menu = false;    
    }
    if( dist(  width*0.9, height*0.5,pdx,pdy)<150){
      masque = avatar[8];
      mode_menu = false;  
    }
     if( dist(  width*0.30, height*0.85,pdx,pdy)<150){
      masque = avatar[9];
      mode_menu = false;    
    }
      if( dist(  width*0.5, height*0.88,pdx,pdy)<150){
      masque = avatar[10];
      mode_menu = false;    
    }
     if( dist(   width*0.10, height*0.5,pdx,pdy)<150){
      masque = avatar[11];
      mode_menu = false;    
    }
     if( dist(  width*0.9, height*0.5,pgx,pgy)<150){
      masque = avatar[12];
      mode_menu = false;    
    }
     if( dist( width*0.85, height*0.25,pgx,pgy)<150){
      masque = avatar[4];
      mode_menu = false;    
    }
  

    
  } else {
    smooth();       // Pour que les transitions soient smooth
    background(1+pdg.analyze()*50, 1+pdg.analyze()*20, 1+pdg.analyze()*200);   //La couleur du background change en fonction du son récupéré par la micro

    beginShape();   //On démarre une forme
    stroke(255);    //les contours en noir
    strokeWeight(3);  //largeurs des contours (3px)
    noFill();   //Pas de remplissage



    curveVertex(0, height/2);            //Tous nos points varient en fonction du son récupéré par le micro, j'ai mis des positions responsives
    curveVertex(0, height/2);           //Les différents points de la courbes évoluent indépendaments avec le "*X"

    curveVertex(width*0.05, height/2 + pdg.analyze()*10);
    curveVertex(width*0.10, height/2 - pdg.analyze()*20);
    curveVertex(width*0.15, height/2 + pdg.analyze()*50);
    curveVertex(width*0.20, height/2- pdg.analyze()*100);
    curveVertex(width*0.25, height/2 + pdg.analyze()*200);
    curveVertex(width*0.30, height/2 - pdg.analyze()*350);
    curveVertex(width*0.35, height/2 + pdg.analyze()*300);
    curveVertex(width*0.40, height/2 - pdg.analyze()*450);
    curveVertex(width*0.45, height/2 + pdg.analyze()*400);
    curveVertex(width*0.5, height/2 - pdg.analyze()*500);
    curveVertex(width*0.55, height/2 + pdg.analyze()*400);
    curveVertex(width*0.60, height/2 - pdg.analyze()*450);
    curveVertex(width*0.65, height/2 + pdg.analyze()*300);
    curveVertex(width*0.70, height/2 - pdg.analyze()*350);
    curveVertex(width*0.75, height/2 + pdg.analyze()*200);
    curveVertex(width*0.80, height/2 - pdg.analyze()*100);
    curveVertex(width*0.85, height/2 + pdg.analyze()*50);
    curveVertex(width*0.90, height/2 - pdg.analyze()*20);
    curveVertex(width*0.95, height/2 + pdg.analyze()*10);

    curveVertex(width, height/2);
    curveVertex(width, height/2);

    endShape();


    strokeWeight(30);   //ici on retrouve les lignes qui relient les points du squellette   
    strokeCap(ROUND);   //Les extrémités sont rondes
    line(pgx, pgy, elx, ely);  //Le poignet gauche au poignet gauche

    line(elx, ely, slx, sly);

    line(slx, sly, srx, sry);

    line(srx, sry, erx, ery);

    line(erx, ery, pdx, pdy);

    line(slx, sly, hlx, hly);

    line(srx, sry, hrx, hry);

    line(hlx, hly, hrx, hry);


    image(masque, nx, ny, 200, 250);  //Le masque se fixe sur le point du nez


    blob1.draw(pgx, pgy);    //On dessine les blobs et les zones du corps qui réagissent avec
    blob2.draw(pgx, pgy);
    blob3.draw(pgx, pgy);
    blob4.draw(pgx, pgy);
    blob5.draw(pdx, pdy);
    blob6.draw(pdx, pdy);
    blob7.draw(pdx, pdy);
    blob8.draw(pdx, pdy);
    blob9.draw(pdx, pdy);
    blob10.draw(pgx, pgy);
    blob11.draw(pdx, pdy);
    blob12.draw(pgx, pgy);
  }

  time++;  //variable qui évolue en fonction du temps
}


class Blob {         //Notre class Blob
  float pos_x;       //On a crée des variables de positions, de taille, de son...
  float pos_y;
  float taille_x;
  float taille_y;
  String filename;
  float d;
  SoundFile son;
  Amplitude amp;
  boolean was_in_blob;  //On a crée un vrai/faux ( pour faire une condition )
  int type;          // 1:loop ou 2:beat 

  boolean is_playing = false; 


  Blob(PApplet app, String filename_in, float pos_x_in, float pos_y_in, float taille_y_in, float taille_x_in, int type_in ) {
    pos_x = pos_x_in;
    pos_y = pos_y_in;            //On donne des valeurs à chaque varaibles du blob
    taille_x= taille_x_in;            
    taille_y= taille_y_in;
    filename = filename_in;

    son = new SoundFile(app, filename);      //le son qui sera jouer
    amp = new Amplitude(app);
    amp.input(son);                          //Amplitude du son jouer!
    was_in_blob = false;
    type = type_in;
  }



  //Ici se trouve la condition pour que le son ne soit jouer qu'à l'entrée de la mains.Il s'arrète quand la mains re rentre à l'intérieur.
  //On a crée une distance pour que le son soit jouer ( en gros si px et py sont à moins de 100px d'un blob alors le son joue (is playing = true )
  // On a fait aussi une condition pour que la couleur change quand un son est activé et pareil pour sa taille qui varie en fonction de l'amplitude "amp" du son joué. 

  void draw(float px, float py) {

    float ti = 100;
    float num1 = 360;
    float num2 = 360;
    float num3 = 50;

    float delta = 0;
    float di = dist(px, py, pos_x, pos_y);
    if (di < 100) {
      if (!was_in_blob) {
        was_in_blob = true;

        if (son.isPlaying()) {
          son.pause();
          is_playing = false;
        } else {
          is_playing = true;
          son.play();
          son.loop();  //Son jouer en boucle
        }
      }
      delta = random(40);

      num1 = 99;
      num2 = 250;
      num3 = 200;
    } else {
      was_in_blob = false;
    }
    if (d<150) {
      delta = random(map(d, 0, 150, 50, 0));
    }


    for (int i = 0; i < 360; i+=3) {
      float x = cos(radians(i)) * taille_y + pos_x; //Les blob sont en fait dans une ellipse et ne remplisse qu'une partie de celle-ci d'où le fait qu'elle doit l'impression de se déformer.
      float y = sin(radians(i)) * taille_x + pos_y;
      float w = sin(radians(time+i )) * ti;
      w = abs(w);

      float col=map(i, 0, num1, num2, num3);
      float col1=map(i, 0, num1, num2, num3);
      float col2=map(i, 0, num1, num2, num3);
      fill(col, col1, col2);



      noStroke();
      if (is_playing) {
        if (type == 1) fill(col, 0, 200);
        if (type == 2) fill(col, 0, 200);
        //ti = 100;
        delta = random(50);
      } else {
        if (type == 1) fill(col, 158, 40);
        if (type == 2)fill(col, 2, 50);
      }
      ellipse(x, y, w+(amp.analyze()*100), w+(amp.analyze()*100)); //ici l'amplitude du son qui fait varrier la taille de l'amplitude ( amplitude est une valeur entre 0 et 1 donc on la multiplie par 50
    }
  }
}

boolean was_in_blob = true;



//Ici on retrouve nos récupération de données pour identifier les parties de corps 
//On leurs donne des valeurs style (pdx,pdy...) 
//C'est PoseHook qui nous permet de recevoir ces informations entre 0 et 1 

void oscEvent(OscMessage theOscMessage) {

  if (theOscMessage.checkAddrPattern("/wrist/right")==true) {
    pdx = map(theOscMessage.get(0).floatValue(), 1, -1, 0, width);
    pdy = map(theOscMessage.get(1).floatValue(), 1, -1, 0, height);
  }
  if (theOscMessage.checkAddrPattern("/wrist/left")==true) {
    pgx = map(theOscMessage.get(0).floatValue(), 1, -1, 0, width);
    pgy = map(theOscMessage.get(1).floatValue(), 1, -1, 0, height);
  }  

  if (theOscMessage.checkAddrPattern("/nose")==true) {
    nx = map(theOscMessage.get(0).floatValue(), 1, -1, 0, width);
    ny = map(theOscMessage.get(1).floatValue(), 1, -1, 0, height);
  }
  if (theOscMessage.checkAddrPattern("/knee/left")==true) {
    klx = map(theOscMessage.get(0).floatValue(), 1, -1, 0, width);
    kly = map(theOscMessage.get(1).floatValue(), 1, -1, 0, height);
  }

  if (theOscMessage.checkAddrPattern("/knee/right")==true) {
    krx = map(theOscMessage.get(0).floatValue(), 1, -1, 0, width);
    kry = map(theOscMessage.get(1).floatValue(), 1, -1, 0, height);
  }

  if (theOscMessage.checkAddrPattern("/shoulder/left")==true) {
    slx = map(theOscMessage.get(0).floatValue(), 1, -1, 0, width);
    sly = map(theOscMessage.get(1).floatValue(), 1, -1, 0, height);
  }

  if (theOscMessage.checkAddrPattern("/shoulder/right")==true) {
    srx = map(theOscMessage.get(0).floatValue(), 1, -1, 0, width);
    sry = map(theOscMessage.get(1).floatValue(), 1, -1, 0, height);
  }


  if (theOscMessage.checkAddrPattern("/hip/left")==true) {
    hlx = map(theOscMessage.get(0).floatValue(), 1, -1, 0, width);
    hly = map(theOscMessage.get(1).floatValue(), 1, -1, 0, height);
  }

  if (theOscMessage.checkAddrPattern("/hip/right")==true) {
    hrx = map(theOscMessage.get(0).floatValue(), 1, -1, 0, width);
    hry = map(theOscMessage.get(1).floatValue(), 1, -1, 0, height);
  }

  if (theOscMessage.checkAddrPattern("/elbow/left")==true) {
    elx = map(theOscMessage.get(0).floatValue(), 1, -1, 0, width);
    ely = map(theOscMessage.get(1).floatValue(), 1, -1, 0, height);
  }

  if (theOscMessage.checkAddrPattern("/elbow/right")==true) {
    erx = map(theOscMessage.get(0).floatValue(), 1, -1, 0, width);
    ery = map(theOscMessage.get(1).floatValue(), 1, -1, 0, height);
  }
}

void keyPressed() {  //Affichage du menu quand on touche la touche espace
  if (key == ' ') {
    mode_menu = !mode_menu;  //Mode_menu devient l'inverse
  }
}
