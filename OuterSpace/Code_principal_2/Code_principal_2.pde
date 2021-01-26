//pour prendre la photo
import processing.video.*;
//capture
Capture video;
PGraphics image_capture;

// Variables pour la préparation du code, à ch S SSanger au moment adéquat
boolean DEV = false;

//pour insérer le son PLANETE

import processing.sound.*;
SoundFile backgroundmusic;
SoundFile effet_1;
//son FLAMMES
SoundFile effet_2;
//son ETOILE
SoundFile effet_3;
//son PULSAR
SoundFile effet_4;
//son TROU NOIR
SoundFile effet_5;


//TRANSITIONS
float speedy = 2;
PImage starwarsfond;
Starlight[] starlights;

//BASIC
int scene = 0;
int n_scene = 6;
boolean b_save; 

//SCENE 1 
//pour les météorites
Spot[] spots; 
float x;
//pour faire la planète
PShape globe;
boolean show_meteorites=false;
PImage fond1;
PImage silhouette_1;

//SCENE 2
PVector offset1, offset2;
float scale = 0.01;
color c1, c2;
float lapse = -20;
PImage fond2;
PImage silhouette_2;
//ANIMATION 
//boolean show_flamme = false;

//SCENE 3 
float speed = 1;
boolean show_galaxie = false;
PImage fond3;
PImage silhouette_3;
//ANIMATION
ArrayList<Ellipse> ellipses; //Déclarer une structure de données pour y mettre les objets
int max_ellipses=400; //Nombre de balles créées

//SCENE 4
//PULSAR ÉTOILE
int dim;
//ANIMATION PULSAR 
final int NUM_LINES = 500;  
float maxRadius;            
final int NUM_TURNS = 10;  
float startAngle = 0;       
final float START_ANGLE_CHANGE = 0.5; 
float xPE;
float yPE;
boolean show_pulsar = false; 
PImage fond4;
PImage silhouette_4;

//SCENE 5
//TROU NOIR 
float kMax;
float step;
int n = 200; // nombre de blobs
float radius = 120; // diamètre du cercle
float inter = 0.01; // différence entre les tailles de 2 blobs
float maxNoise = 500.0; 
int maxblob = 100; //nombre maximum de blob
PImage silhouette_5;

// Variables pour les transitions
boolean transition_ok = false;
int transition_start;
int transition_duree = 2000;


float noiseProg(float x) {
  return x*x;
}


void setup() {
  // BASIC
  size(1920, 1080, P3D);

  //TRANSITION
 setup_TRANSITION ();

  // PLANETE 1
  setup_planete();

  //FLAMMES 2
  setup_flammes();

  //ETOILES 3
  setup_etoiles();
  setup_galaxie();

  //Setup PULSAR 4
  setup_PULSAR4();

  //Setup TROU NOIR 5
  setup_TROUNOIR5();

  //Setup capture
  String[] cameras = Capture.list();
  printArray(cameras);
  video=new Capture(this, 1920, 1080, cameras[1], 30);
  video.start();
  image_capture = createGraphics(1920, 1080);
  //setup_capture();

  if (!DEV)backgroundmusic=new SoundFile(this, "zodiac.mp3");
  if (!DEV) backgroundmusic.loop();
  if (!DEV) backgroundmusic.amp(.15);
}


//Draw pricipal
void draw() {
  //capture
  //background(0);


  // PASSAGE DE SCENE EN SCENE
  if (scene == 0) {
    background(0);
  } else if (scene == 1) {
    if (millis() - transition_start < transition_duree) jouer_transition();
    else draw_planete();
  } else if (scene == 2) {
    if (millis() - transition_start < transition_duree) jouer_transition();
    else draw_flammes();
  } else if (scene == 3) {
    if (millis() - transition_start < transition_duree) jouer_transition();
    else draw_etoiles();
  } else if (scene == 4) {
    if (millis() - transition_start < transition_duree) jouer_transition();
    else draw_PULSAR4();
  } else if (scene == 5) {
    if (millis() - transition_start < transition_duree) jouer_transition();
    else {
      draw_TROUNOIR5();
      show_pulsar = false;
    }
  }
  //println(scene);
  //ANIMATIONS
  // ANIMATION SCENE 4
  if (show_pulsar) {
    // println("galaxie");
    draw_ANIMPULSAR4();
  }

  if (video.available() == true) {
    video.read();
  }
  image(video, 0, -3600, 640, 360);

  if (b_save) {
    println("export image");
    image_capture.beginDraw();
    image_capture.image(video, 0, 0, 1920, 1080);
    image_capture.endDraw();
    image_capture.save("out_" + millis() + ".jpg");
    b_save = false;
  }
  
  //if (show_flamme) {
  //  mousePressed_flammes();
  //}
}

void stop_son() {
  if (!DEV) effet_1.stop();
  if (!DEV) effet_2.stop();
  if (!DEV) effet_3.stop();
  if (!DEV) effet_4.stop();
  if (!DEV) effet_5.stop();
}

// INTERACTIONS AU CLAVIER
void keyPressed() {
  // CHANGEMENT DE SCENE  
  //if (key==CODED)
  //if (key == LEFT) {
  if (key == 'S') {
    stop_son();
    scene = scene +1;
    if (scene == n_scene) {
      scene = 0;
    }
    //transition_ok = true;
    transition_start = millis();
    println("transition_start fixée : " + transition_start);
  } else if (scene == 1) {
    keyPressed_planete();
  } else if (scene == 2) {
    keyPressed_flammes();
  } else if (scene == 3) {
    keyPressed_etoiles();
  } else if (scene == 4) {
    keyPressed_pulsar();
  } else if (scene == 5) {
    keyPressed_trou_noir();
  }
  //println(scene);
}

//INTERACTION AU CLIC (animations)
void mousePressed() {
  //capture
  //video.read();
  b_save = true;
  //ANIMATION SCENE 2
  if (scene==2) {
    mousePressed_flammes();
  }
  //ANIMATION SCENE 3
  if (scene==3) {
    mousePressed_etoiles();
  }

  //if (scene == 2){
  //  show_flamme = true;
  //} else {show_flamme = false;
  //ANIMATION SCENE 4
  if (scene == 4 ) {
    show_pulsar = true;
  } else {
    show_pulsar = false;
  }

  mousePressed_planete();
}
