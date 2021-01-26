// Louis l'étoile

// réglages combinaison boutons
import com.dhchoi.CountdownTimer;
import com.dhchoi.CountdownTimerService;
CountdownTimer timer;
String timerCallbackInfo = "";

boolean[] bouton_cible = {false, false, false, false, false, false};
boolean[] bouton_user  = {false, false, false, false, false, false};
String[] bouton_symbole = {"○", "◊", "+", "Δ", "☼", "x"};
SoundFile[] bouton_sound;

boolean win = false;
IntList valeurs; // liste des valeurs pour tirages aléatoires multiples
String etat = "";
int score_global = 0;
int temps_reponse = 2000;   // en millisecondes


//Musique
import processing.sound.*;
SoundFile son;
SoundFile bouton1;
SoundFile bouton2;
SoundFile bouton3;
SoundFile bouton4;
SoundFile bouton5;
SoundFile bouton6;

// Définir les dimensions de l'espace virtuel
int espace_largeur = 1040; // largeur 
int espace_hauteur = 9000; // hauteur

// Dimensions de la fenêtre
int fenetre_largeur, fenetre_hauteur;
int origine_x, origine_y; // origine de la fenêtre dans l'espace virtuel

// Définir la structure de donnée qui contient les objets
ArrayList<Boule> boules;
int max_boules = 1000; // nombre de boules

//image de fond
PImage img;


//PGraphics calque_temp;
Balle maBalle = new Balle(300, 350, color(255, 224, 51, 50)); // départ de la balle

boolean started = false; // boucle de commencement
boolean restart = true; // boucle de recommencement
int restart_time; // temps pour recommencer



void setup() {
  

  // réglages
  smooth(); //Lissage des dessins
  frameRate(25); //Nombre de chargement par seconde


  // importation du son
  son = new SoundFile(this, "Schizolebon.mp3");
  
  bouton_sound = new SoundFile[6];
  bouton_sound[0] = new SoundFile(this, "bouton1.mp3");
  bouton_sound[1] = new SoundFile(this, "bouton2.mp3");
  bouton_sound[2] = new SoundFile(this, "bouton3.mp3");
  bouton_sound[3] = new SoundFile(this, "bouton4.mp3");
  bouton_sound[4] = new SoundFile(this, "bouton5.mp3");
  bouton_sound[5] = new SoundFile(this, "bouton6.mp3");
  //démarer la musique à partir d'un certain moment
  son.jump(16);
  son.amp(0.3);

  //affichage décor
  img = loadImage ("fond.png"); // image de fond
  //size(600, 1000); // taille de la fenêtre
  fullScreen();
  fenetre_largeur = width;
  fenetre_hauteur = height;

  //position de la fenêtre
  origine_x = 0;
  origine_y = 8000;

  // créer les objets sur l'espace virtuel
  boules = new ArrayList<Boule>();
  for (int i=0; i < max_boules; i++) {
    boules.add(new Boule(espace_largeur, espace_hauteur));
  }


  textSize(5);

  //réglages boutons et timer
  restart_time = millis();

  textSize(15);
  valeurs = new IntList();
  valeurs.append(0);
  valeurs.append(1);
  valeurs.append(2);
  valeurs.append(3);
  valeurs.append(4);
  valeurs.append(5);

  timer = CountdownTimerService.getNewCountdownTimer(this).configure(100, temps_reponse);
}




void draw() {


  background (#081E2A); // couleur de fond qui correspond à la fin du dégradé
  image (img, width/3-30, -origine_y + height); // position de l'image de fond

  // Afficher uniquement les objets qui sont visibles dans la fenêtre
  for (int i=0; i < boules.size(); i++) {
    Boule b = boules.get(i);
    b.deplacer();
    if (b.visible(origine_x, origine_y, fenetre_largeur, fenetre_hauteur));
    b.dessiner(origine_x, origine_y);
  }

  // paramètres d'affichage accueil jeu
  //println(second());
  if (restart && millis() - restart_time < 3*1000) {
    draw_accueil();
  } else {
    restart = false;
    if (started == false) {
      started = true;
      maBalle.changeVitesse(5);
    }
  }

  draw_game();
  fill(#081E2A);
  rect(0, 0, 900, 8000);


  // paramètres des boutons
  fill(0);
  textAlign(CENTER, CENTER);
  rectMode(CENTER);

  // Afficher les boutons cible
  for (int i=0; i<6; i++) {
    if (bouton_cible[i] == false) {
      fill(255, 255, 240, 60);
    } else {
      fill(255, 255, 240);
    }
    ellipse(550 + i*80, 30, 40, 40);
    fill(0);
    text(bouton_symbole[i], 550 + i*80, 27);
  }

  // Afficher les boutons user (touches déjà pressées)
  for (int i=0; i<6; i++) {
    if (bouton_user[i] == false) {
      fill(255, 255, 240, 80);
    } else {
      fill(255, 255, 240);
    }
    ellipse(550 + i*80, 80, 25, 25);
    fill(0);
    //text(i, 550 + i*80, 75);
  }

  // etat boutons
  if (frameCount == 1) {
    for (int i=0; i<6; i++) {
      bouton_cible[i] = false;
      bouton_user[i] = false;
    }
    int next = int(random(6));
    timer.start();
    etat = "JOUE!";
  }

  // Quel temps reste t'il ?
  //textAlign(LEFT, CENTER);
  //text("temps restant : " + timerCallbackInfo, 100, 300);
  //text("état : " + etat, 100, 350);

  // Et le score ?
  //text("SCORE : " + score_global, 100, 40);

  // Et le score ?
  //text("utiliser les touches : w, x, c, v, b, n", 250, 350);
}


// affichage page accueil
void draw_accueil() {

  noStroke(); //Pas de contour
  textSize(30); //Taille du texte
  fill(255); //Couleur du texte
  text("Salut à toi Superstar ! ", width/3+170, 200); //Première ligne de texte
  noStroke();
  fill(255, 255, 255); //Caractéristiques de la deuxième ligne de texte
  text("Louis l'étoile est tombé du ciel...", width/3+280, 650);
  fill(255, 255, 255);
  textSize (25);
  text("Aide-le à retrouver sa place dans les étoiles !", width/3+270, 700);
}

// affichage page de fin
void draw_fin() {

  noStroke(); //Pas de contour
  textSize(40); //Taille du texte
  fill(255); //Couleur du texte
  text("Bravo Superstar !! ", width/3+170, 150); //Première ligne de texte
  noStroke();
  fill(255, 255, 255); //Caractéristiques de la deuxième ligne de texte
  text("Tu as réussi !", width/3+280, 650);
  fill(255, 255, 255);
  text("Louis a retrouvé sa place", width/3+270, 700);
  textSize (25);
  text("Appuie sur ENTER pour recommencer", width/3+270, 750);
}


//Affichage jeu
void draw_game() {

  //Paramètres balle
  maBalle.bouge(); //Affichage déplacement de la balle
  origine_y = 8000 + int(maBalle.getYFond()); 
  if (origine_y > 8000) {
    origine_y = 8000;
  }
  if (maBalle.getYFond() > 600) { 
    restart_time = millis();
    restart = true;
    maBalle = new Balle(300, 350, color(255, 224, 51, 50));
  }
  maBalle.display(); //Affichage de la balle

  if ((origine_y < 1000) && (origine_y < 1000)) {
    origine_y = 1000;
    draw_fin(); 
    maBalle.changeVitesse(-10);
    if (key == ENTER) {
      restart_time = millis();
      restart = true;
      maBalle = new Balle(300, 350, color(255, 224, 51, 50));
    }
  }
}

/* *********************************
 Contrôle du mouvement au clavier
 ********************************** */


  


void keyPressed() {
 if (key == CODED) { 
   // if (keyCode == UP) { // si on appuie sur la flèche du haut
   //maBalle.changeVitesse(-50); //Alors la balle change de vitesse, se dirige vers le haut
   // }
   /* if (keyCode == DOWN) { // si on appuiesur la flèche du bas
    origine_y += 30;
    }*/

   if (keyCode == LEFT) { // si on appuie sur la flèche du haut
     bouton_user[0] = true; //Alors la balle change de vitesse, se dirige vers le haut
   }
   if (keyCode == UP) { // si on appuie sur la flèche du haut
     bouton_user[1] = true; //Alors la balle change de vitesse, se dirige vers le haut
   }
   if (keyCode == RIGHT) { // si on appuie sur la flèche du haut
     bouton_user[2] = true; //Alors la balle change de vitesse, se dirige vers le haut
   }
   if (keyCode == DOWN) { // si on appuie sur la flèche du haut
     bouton_user[3] = true; //Alors la balle change de vitesse, se dirige vers le haut
   }
 } 
 if (keyCode == ' ') { // si on appuie sur la flèche du haut
   bouton_user[4] = true; //Alors la balle change de vitesse, se dirige vers le haut
 }
}

void mousePressed() {
 bouton_user[5] = true;
}

void mouseReleased() {
 bouton_user[5] = false;
}




void keyReleased() { //Si la touche est relachée 
 //maBalle.changeVitesse(10); //Alors la balle reprend son mouvement dans le sens initial, à la même vitesse que de base
 //origine_y += 100;
}



void onTickEvent(CountdownTimer t, long timeLeftUntilFinish) {
  timerCallbackInfo = timeLeftUntilFinish + "ms";
}

void onFinishEvent(CountdownTimer t) {
  timerCallbackInfo = "[finished]";
  comparerResultats();
}

void comparerResultats() {
  int score = 0;
  for (int i=0; i<6; i++) {
    if (bouton_cible[i] == bouton_user[i]) score ++;
  }
  if (score == 6) {
    win = true;
    etat = "GAGNE";
    score_global ++;
    maBalle.changeVitesse(-7); //Alors la balle change de vitesse, se dirige vers le haut;
  } else {
    win = false;
    etat = "PERDU";
    score_global -=2;
    maBalle.changeVitesse(5);
    origine_y += 100;
  }

  // a chaque nouveau tirage le timer recommence
  nouveauTirage();
  timer = CountdownTimerService.getNewCountdownTimer(this).configure(100, temps_reponse);
  timer.start();
}

// les boutons sont tous non activés
void nouveauTirage() {
  for (int i=0; i<6; i++) {
    bouton_cible[i] = false;
    bouton_user[i] = false;
  }

  // Combien de boutons sont à activer
  int nb_boutons = int((score_global / 2) + 1);
  if (nb_boutons > 4) nb_boutons = 4; // On ne dépasse jamais 4 boutons maximum 

  // mélange aléatoire
  valeurs.shuffle();
 
  for (int j=0; j < nb_boutons; j++) {
    int t = valeurs.get(j);
    bouton_cible[t] = true;
    bouton_sound [t].play();
  }      
}                          
