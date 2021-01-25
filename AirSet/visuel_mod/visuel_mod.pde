//importer les librairies "minim" "leapmotion" et "video"
import ddf.minim.*;
import ddf.minim.analysis.*;
import de.voidplus.leapmotion.*;
import ddf.minim.*;
import ddf.minim.ugens.*;
import ddf.minim.signals.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import processing.video.*;

//menu
int page;
int[] score = new int [3];
color c;

boolean newpage;
boolean menu_on = true;
PFont police;
PImage photo1;
float x;
float y;

//son (lecture et effets)
Minim minim; 
TickRate rateControl;
FilePlayer filePlayer;
AudioOutput out;
MoogFilter  moog;
Gain       gain;
HighPassSP hpf;
FFT fft;

//leapmotion
LeapMotion leap;

Star [] stars = new Star[10000]; //Création d'étoiles  
// Variables qui définissent les "zones" du spectre
// Par exemple, pour les basses, on prend seulement les premières 4% du spectre total
float specLow = 0.03; // 3%
float specMid = 0.125;  // 12.5%
float specHi = 0.13;   // 20%

//variables utilisees dans les effets sonores
float test, test1;
//importation de la musique
String fileName = "shrek.mp3";

// Valeurs de score pour chaque zone de frequence
float scoreLow = 0;
float scoreMid = 0;
float scoreHi = 0;

// Valeur precedentes, pour adoucir la reduction
float oldScoreLow = scoreLow;
float oldScoreMid = scoreMid;
float oldScoreHi = scoreHi;

// Valeur d'adoucissement
float scoreDecreaseRate = 25;

// Cubes qui apparaissent dans l'espace
int nbCubes;
Cube[] cubes;



void setup() {
  //taille de la fenetre, possibilite de la mettre en fenetre
  size (1000, 800, P3D);
  surface.setResizable(true);

  //Charger la librairie minim
  minim = new Minim(this);


  // Elements du menu
  photo1 = loadImage("photo1.png");
  police = loadFont("Notable-Regular-48.vlw");


  //permet de jouer le void contenu dans l'onglet "setupProg"
  initialisation();
}

void keyPressed() {          // Void qui s'éxécute a chaque fois qu'une touche du clavier est activée

  //conditions pour passer le menu
  if (key == ' ') {
    menu_on = !menu_on;
    println(menu_on);
    


    //Commencer la chanson
    filePlayer.play(0);
    filePlayer.loop();
  }
}

void draw() {
  background(0);

  //execute le "void" contenu dans l'onglet "program"
  program();

  if (menu_on) menu();
}

void menu() {
  //menu
  background(0);
  page = 0;            
  imageMode(CENTER);
  image (photo1, width/2, height/2, 824, 480);
}
