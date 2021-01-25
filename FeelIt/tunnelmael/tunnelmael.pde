// version 3

//Source pour ajouter la musique : "https://poanchen.github.io/blog/2016/11/15/how-to-add-background-music-in-processing-3.0"
import processing.sound.*;
import oscP5.*;
import netP5.*;


OscP5 oscP5;
NetAddress myRemoteLocation;

//Entrée des variables

boolean add_objet = false;

//Chargement des pistes musicales

SoundFile file;
SoundFile file2;
SoundFile file3;
SoundFile file4;
SoundFile file5;
SoundFile file6;

SoundFile currently_playing;

PImage img1U0;
PImage img2U0;
PImage img1U1;
PImage img2U1;
PImage img1U2;
PImage img2U2;
PImage img1U3;
PImage img2U3;
PImage img1U4;
PImage img2U4;
PImage img1U5;
PImage img2U5;

int univers = 6; //Créer 6 univers
int spawnRateUnivers = 60;

int n_angles = 10;

//couleurs
color violet = color(89, 0, 122);
color noir = color(0);
color jaune = color(255, 216, 0);
color rouge = color(241, 31, 31);
color vert = color(19, 189, 5);
color bleu = color(47, 106, 221);
color orange = color(255, 128, 0);
color blanc = color(255, 255, 255);

//variables liées au tunnel
int n_elem = 20;
int marg = 50;
float z_min = -6000; //pronfondeur min
float z_max = 800;   //profondeur max

Frame[] frames; //Créer l'objet frame

//variable bruit
float rand_amp = 0;
float in_rand_amp = 0;

//variable vitesse
float speed = 15;

//variable bruit
float noise_amp = 1.0;
float noise_max = 1000.0;

//définir nombre d'objets
int n_objets;

ArrayList<Frame_alt> objets = new ArrayList<Frame_alt>();

//variables position
float posx;
float posy;

color current_col;

//variable point de vue zoom
float echelle = 1.0;
float in_echelle = 0.0;

int rot_speed = 1;

//ambiance
ArrayList<Firework> fireworks = new ArrayList();

//liste de points créant les éclairs
ArrayList<PVector> points;

//nombre d'éclairs
float chaos = 0.35;

//pluie
Drop[] drops = new Drop[200];

//confettis
Confetti[] confettis = new Confetti[1000];
int state = 1;



void setup() {
  // size(600, 600, P3D);
  // perspective(PI/6, float(width)/float(height), -10000, 500);
  fullScreen(P3D);
  frames = new Frame[n_elem];
  img1U0 = loadImage("peur1.png");
  img2U0 = loadImage("peur2.png");
  img1U1 = loadImage("colere1.png");
  img2U1 = loadImage("colere2.png");
  img1U2 = loadImage("joie2.png");
  img2U2 = loadImage("joie4.png");
  img1U3 = loadImage("tristesse1.png");
  img2U3 = loadImage("tristesse2.png");
  img1U4 = loadImage("degout1.png");
  img2U4 = loadImage("degout2.png");
  img1U5 = loadImage("surprise1.png");
  img2U5 = loadImage("surprise2.png");

  //Définir la couleur par défaut (sans émotion)
  current_col = blanc;

  //Définir le cadre
  for (int i = 0; i < n_elem; i ++) {
    float pos_z = map(i, 0, n_elem, z_min, z_max);
    frames[i] = new Frame(width/3, pos_z);
  }

  //Ajouter les pistes audio
  file = new SoundFile(this, sketchPath("nuit-depouvante-dans-la-foret-musique-dhorreur-et-bruits-terrifiants_Gm2Ai6L3.mp3"));
  file2 = new SoundFile(this, sketchPath("evrybody-wants-to-be-a-cat-instrumental-from-the-aristocats_NoLy300I.mp3"));
  file3 = new SoundFile(this, sketchPath("bloodspot-volcanos-brutal-death-metal-thrash-metal_ryKkvLrb.mp3"));
  file4 = new SoundFile(this, sketchPath("20210106172236_314fb615-b5b1-44cf-893d-9770c569e475.mp3"));
  file5 = new SoundFile(this, sketchPath("nicolas-godin-bach-off-copy_FkgDPecP.mp3"));
  file6 = new SoundFile(this, sketchPath("nicolas-godin-bach-off.mp3"));

  //Entrée et sortie Joystick
  oscP5 = new OscP5(this, 12000);
  myRemoteLocation = new NetAddress("127.0.0.1", 8888);

  //Définir la pluie
  for (int i = 0; i < drops.length; i++) {

    drops[i] = new Drop();
  }

  //Définir les feux d'artifice
  fireworks.add(new Firework(random(width), random(height)));

  //Définir les confettis
  for (int i = 0; i < confettis.length; i++) {
    confettis[i] = new Confetti();
  }
}

//Réinitialiser à chaque changement d'univers
void init() {
  objets.clear();
}


void draw() {

  background(0); //fond
  noFill();      //retirer la couleur
  pushMatrix();
  translate(width/2, height/2); //centrer le tunnel

  echelle = map(in_echelle, -1, 1, 0.5, 2); //échelle du point de vue zoom du tunnel controlé par le joystick

  rand_amp = map(in_rand_amp, -1, 1, 1, 0); //niveau de bruit controlé par le joystick

  for (Frame current_frame : frames) {
    current_frame.update();
    current_frame.draw();
  }

  for (Frame_alt part : objets) {
    part.update();
    part.draw();
  }

  for (int i = objets.size() - 1; i >= 0; i--) {
    Frame_alt part = objets.get(i);
    if (part.getZ()> z_max) {
      objets.remove(i);
    }
  }

  popMatrix();
  //Condtions d'ajout d'une forme et position
  if (add_objet) {
    add_objet = false;

    objets.add(new Frame_alt(random(-200, 200), random(-200, 200), random(10, 10), z_min, univers));
  }

  //définir les conditions de l'univers de la peur
  if (univers == 0 ) {

    if (int(millis()/10.) % spawnRateUnivers == 0) {
      //println("new object");
      int randomObjectType = int(random(0, 1));
      objets.add(new Frame_alt(random(-200, 200), random(-200, 200), random(10, 10), z_min, randomObjectType));
      spawnRateUnivers = int(random(200, 400));
    }
  }

  //ambiance de l'univers de la colère
  if (univers == 1 ) {

    if (int(millis()/10.) % spawnRateUnivers == 0) {
      //println("new object");
      int randomObjectType = int(random(1, 2));
      objets.add(new Frame_alt(random(-200, 200), random(-200, 200), random(10, 10), z_min, randomObjectType));
      spawnRateUnivers = int(random(200, 400));
    }

    //Créer des éclairs
    noStroke();
    fill(0, 24);
    if (random(100) < 10) {
      PVector p1 = new PVector(random(width), 0);
      PVector p2 = new PVector(random(width), height);

      points = chaoticPoints(p1.x, p1.y, p2.x, p2.y, chaos);
      points.add(p2);

      stroke(64, 46, 255, 32);
      strokeWeight(16);
      drawChaoticLine(points);

      stroke(64, 64, 255, 32);
      strokeWeight(8);
      drawChaoticLine(points);

      stroke(128, 128, 255, 32);
      strokeWeight(4);
      drawChaoticLine(points);

      stroke(255, 255, 255, 255);
      strokeWeight(2);
      drawChaoticLine(points);
    }
  }

  //ambiance de l'univers de la joie
  if (univers == 2 ) {
    if (int(millis()/10.) % spawnRateUnivers == 0) {
      //println("new object");
      int randomObjectType = int(random(2, 3));
      objets.add(new Frame_alt(random(-200, 200), random(-200, 200), random(10, 10), z_min, randomObjectType));
      spawnRateUnivers = int(random(200, 400));
    }

    if (frameCount%5 == 0) {
      fireworks.add(new Firework(random(width), random(height)));
    }
    for (Firework thisFirework : fireworks)
      thisFirework.render();
  }

  //ambiance de l'univers de la tristesse
  if (univers == 3 ) {
    if (int(millis()/10.) % spawnRateUnivers == 0) {
      //println("new object");
      int randomObjectType = int(random(3, 4));
      objets.add(new Frame_alt(random(-200, 200), random(-200, 200), random(10, 10), z_min, randomObjectType));
      spawnRateUnivers = int(random(200, 400));
    }

    translate(0, 0, 0);
    for (int i = 0; i < drops.length; i++) {
      drops[i].fall();
      drops[i].show();
    }
  }

  //Ambiance de l'univers du dégoût
  if (univers == 4 ) {
    if (int(millis()/10.) % spawnRateUnivers == 0) {
      //println("new object");
      int randomObjectType = int(random(4, 5));
      objets.add(new Frame_alt(random(-200, 200), random(-200, 200), random(10, 10), z_min, randomObjectType));
      spawnRateUnivers = int(random(200, 400));
    }
  }

  //Ambiance de l'univers de la surprise
  if (univers == 5 ) {
    if (int(millis()/10.) % spawnRateUnivers == 0) {
      //println("new object");
      int randomObjectType = int(random(5, 6));
      objets.add(new Frame_alt(random(-200, 200), random(-200, 200), random(10, 10), z_min, randomObjectType));
      spawnRateUnivers = int(random(200, 400));
    }
    //définir l'état 1 des confettis
    translate(width/2, height/2, 100);//centrer
    rotateZ(1.4); //rotation vertical
    rotateX(.7f); //rotation horizontale

    fill(#F29420);
    noStroke();
    for (int i = 0; i < confettis.length; i++) {
      confettis[i].run();
    }

    //condition du deuxième état
    if (state == 2) {
      stroke(0, 0, 100);
      strokeWeight(4);
      noStroke();
    }
  }

  //ambiance de l'univers
  if (univers == 6 ) {
    if (int(millis()/10.) % spawnRateUnivers == 0) {
      //println("new object");
      int randomObjectType = int(random(13, 15));
      //objets.add(new Frame_alt(random(-100, 100), random(-100, 100), random(10, 10), z_min, randomObjectType));
      spawnRateUnivers = int(random(200, 400));
    }
  }
}
//Paramètres audio
void playFile(SoundFile file_to_play) {
  if (currently_playing != null && currently_playing.isPlaying()) {
    currently_playing.stop();
  }

  //Jouer une piste audio
  if (!file_to_play.isPlaying()) {
    file_to_play.play();
    currently_playing = file_to_play;
  }
}

// Liaison du code avec les commandes du Joystick
void oscEvent(OscMessage theOscMessage) {
  /* check if theOscMessage has the address pattern we are looking for. */

  //Point de vue droite et gauche
  if (theOscMessage.checkAddrPattern("/joystick/axes/axis1")==true) {
    /* check if the typetag is the right one. */
    if (theOscMessage.checkTypetag("f")) {
      /* parse theOscMessage and extract the values from the osc message arguments. */
      posx = theOscMessage.get(0).floatValue();

      println(" values: , "+ posx);
      return;
    }
  }
  //Point de vue haut et bas
  else if (theOscMessage.checkAddrPattern("/joystick/axes/axis2")==true) {
    /* check if the typetag is the right one. */
    if (theOscMessage.checkTypetag("f")) {
      /* parse theOscMessage and extract the values from the osc message arguments. */
      posy = theOscMessage.get(0).floatValue();

      println(" values: , "+ posy);
      return;
    }
  }
  //Point de vue Zoom
  else if (theOscMessage.checkAddrPattern("/joystick/axes/axis3")==true) {
    /* check if the typetag is the right one. */
    if (theOscMessage.checkTypetag("f")) {
      /* parse theOscMessage and extract the values from the osc message arguments. */
      in_echelle = theOscMessage.get(0).floatValue();

      println(" values: , "+ in_echelle);
      return;
    }
  }
  //intensité du bruit
  else if (theOscMessage.checkAddrPattern("/joystick/axes/axis4")==true) {
    /* check if the typetag is the right one. */
    if (theOscMessage.checkTypetag("f")) {
      /* parse theOscMessage and extract the values from the osc message arguments. */
      in_rand_amp = theOscMessage.get(0).floatValue();

      println(" values: , "+ in_rand_amp);
      return;
    }
  }
  //Apparition des objets avec la gachette
  else if (theOscMessage.checkAddrPattern("/joystick/buttons/button1")==true) {
    add_objet = true;
  }


  // création des univers

  else if (theOscMessage.checkAddrPattern("/joystick/buttons/button9")==true) {
    init();
    current_col = violet;//couleur
    playFile(file);//Jouer l'audio à 0
    univers = 0;//univers de la peur
    speed = 20;//rapidité
    n_angles = 4;//nombre d'angle du tunnel
  } else if (theOscMessage.checkAddrPattern("/joystick/buttons/button7")==true) {
    init();
    current_col = rouge;
    playFile(file3);
    univers = 1;
    speed = 30;
    n_angles = 3;
  } else if (theOscMessage.checkAddrPattern("/joystick/buttons/button6")==true) {
    init();
    current_col = bleu;
    playFile(file4);
    file4.jump(6);
    univers = 3;
    speed = 15;
    n_angles = 30;
  } else if (theOscMessage.checkAddrPattern("/joystick/buttons/button5")==true) {
    init();
    current_col = vert;
    playFile(file5);
    univers = 4;
    speed = 15;
    n_angles = 10;
  } else if (theOscMessage.checkAddrPattern("/joystick/buttons/button8")==true) {
    init();
    current_col = orange;
    playFile(file6);
    univers = 5;
    state++;//nombre d'état
    if (state > 2) state = 0;//Au delà du 2ème état, retour à 0
  } else if (theOscMessage.checkAddrPattern("/joystick/buttons/button10")==true) {
    init();
    current_col = jaune;
    playFile(file2);
    univers = 2;
    
    speed = 15;
    n_angles = 10;
  }


  println("### received an osc message. with address pattern "+theOscMessage.addrPattern());
}

// intéractions clavier
void keyPressed() {

  if (key == 'v') {
    init();
    current_col = violet;//couleur
    playFile(file);//jouer la piste audio 0
    univers = 0;//univers de la peur
    speed = 20;//rapidité
    n_angles = 4;//nombre d'angle du tunnel
  }

  if (key == 'r') {
    init();
    current_col = rouge;
    playFile(file3);
    univers = 1;
    speed = 30;
    n_angles = 3;
  }

  if (key == 'j') {
    init();
    current_col = jaune;
    playFile(file2);
    univers = 2;
    speed = 15;
    n_angles = 10;
    // univers == 2 = true;
  }

  if (key == 'b') {
    init();
    current_col = bleu;
    playFile(file4);
    file4.jump(6);
    univers = 3;
    speed = 15;
    n_angles = 30;
    //  univers == 3 = true;
  }

  if (key == 'g') {
    init();
    current_col = vert;
    playFile(file5);
    univers = 4;
    speed = 15;
    n_angles = 10;
  }

  if (key == 'o') {
    init();
    current_col = orange;
    playFile(file6);
    univers = 5;
    state++;
    if (state > 2) state = 0;
    speed = 15;
    n_angles = 10;
  }

  if (key == 'w') {
    init();
    current_col = blanc;
    univers = 6;
    speed = 15;
    n_angles = 15;
    if (currently_playing != null && currently_playing.isPlaying()) {
      currently_playing.stop(); //Arrêter la musique dans l'univers par défaut
    }
  }
}


// création d'un vecteur
PVector z_to_center(float z) {
  float k = map(z, z_min, z_max, 1, 0);//position de la variable k
  float x = -posx * 2 * z * k;
  float y = -posy * 2 * z * k;
  return new PVector(x, y); //rejouer
}


class Frame {
  float pos_z;
  float s;
  Frame (float s_in, float z) {
    s = s_in;
    pos_z = z;
  }

  //Fonction de mise à jour des positions
  void update() {
    pos_z = pos_z + speed;
    if (pos_z > z_max) { //Si la position au centre en z atteint la position maximale, retourner à la position minimale, celle de départ.
      pos_z = z_min;
    }
  }


  void draw() {
    pushMatrix(); //Rassembler les paramètres du tunnel
    float fc =  (float) frameCount;

    PVector center = z_to_center(pos_z); // Définir le centre du vecteur

    float noise_speed = 1000.0; //vitesse
    float noise_def = 1000.0;   //définition
    float noise_amp_z = map(pos_z, z_max, z_min, 0, 1); //amplitude

    float rand_max = 30;
    translate(
      center.x  + random(-rand_max, rand_max) * rand_amp + (noise(pos_z/noise_def, millis()/noise_speed)-0.5) * noise_max * noise_amp_z * noise_amp,
      center.y  + random(-rand_max, rand_max) * rand_amp + (noise(pos_z/noise_def, 3000 + millis()/noise_speed)-0.5)* noise_max * noise_amp_z * noise_amp,
      pos_z);
    stroke(255, 255, 255, map(pos_z, z_min, z_max, 255, 0));
    strokeWeight(1.5);


    noStroke();

    float rot_speed = 1;

    float pos_col = map(pos_z, z_min, z_max, 0, 1); //positionnement de la couleur
    fill(lerpColor(noir, current_col, pos_col));
    float signal = sin(pos_z/1000 + millis()/1000.0);
    rotateZ(rot_speed * (millis()/1000.0 + pos_z/1000.0)); //rotation et sa vitesse
    //int n_angles = int(map(signal, -1, 1, 5, 30));
    float angle = TWO_PI / n_angles;
    for (int i = 0; i < n_angles; i ++) {   //définir les différents angles
      float x1 = echelle * s * cos(angle*i);
      float y1 = echelle * s * sin(angle*i);
      float x2 = echelle * s * cos(angle*(i+1));
      float y2 = echelle * s * sin(angle*(i+1));
      beginShape();  //construire la forme du tunnel
      vertex(x1, y1);
      vertex(x2, y2);
      vertex(10*x2, 10*y2);
      vertex(10*x1, 10*y1);
      endShape(CLOSE);
    }
    noFill();

    boolean draw_contour = false;
    if (draw_contour) {
      stroke(255);
      beginShape();
      for (int i = 0; i < n_angles; i ++) {
        float x3 = s * cos(angle*i);
        float y3 = s * sin(angle*i);
        vertex(x3, y3);
      }
      endShape(CLOSE);
    }
    popMatrix();
  }
}

class Frame_alt {
  float pos_x;
  float pos_y;
  float pos_z;
  float s;
  int type;  //définir une variable pour chaque type de forme
  float seed;
  float seed2;

  Frame_alt (float pos_x_in, float pos_y_in, float s_in, float z, int type_in) {
    s = s_in;
    pos_x = pos_x_in;
    pos_y = pos_y_in;
    pos_z = z;
    type   = type_in;
    seed = random(-1, 1);
    seed2 = random(-1, 1);
  }


  void update() {
    pos_z = pos_z + 15;
    //   if (pos_z > 500) {
    //     pos_z = -n_elem * 100;
    //  }
  }

  //formes


  void draw() {
    //positionner le départ des formes
    PVector center = z_to_center(pos_z);
    pushMatrix();
    translate(
      center.x,
      center.y,
      pos_z);

    if (type == 0) { //Paramètres de la forme de l'univers 0
      stroke(255);
      rotateX(PI/2);  //rotation horizontale
      rotateZ(-PI/6);//rotation verticale
      noFill();
      translate(pos_x, pos_y, 0); //position
      rotateX(TWO_PI * sin(millis()*seed2/1000.0));
      rotateY(TWO_PI * sin(millis()*seed/1000.0));

      beginShape(); //Contruire la figure
      vertex(-100, -100, -100);
      vertex( 100, -100, -100);
      vertex(   0, 0, 100);

      vertex( 100, -100, -100);
      vertex( 100, 100, -100);
      vertex(   0, 0, 100);

      vertex( 100, 100, -100);
      vertex(-100, 100, -100);
      vertex(   0, 0, 100);

      vertex(-100, 100, -100);
      vertex(-100, -100, -100);
      vertex(   0, 0, 100);
      endShape();
    }

    if (type == 1) { //paramètres de la pyramide de l'univers 1
      stroke(255);
      rotateX(PI/2);
      rotateZ(-PI/6);
      noFill();
      translate(pos_x, pos_y, 0);
      rotateX(TWO_PI * sin(millis()*seed2/1000.0));
      rotateY(TWO_PI * sin(millis()*seed/1000.0));

      beginShape();
      vertex(-100, -100, -100);
      vertex( 100, -100, -100);
      vertex(   0, 0, 100);

      vertex( 100, -100, -100);
      vertex( 100, 100, -100);
      vertex(   0, 0, 100);

      vertex( 100, 100, -100);
      vertex(-100, 100, -100);
      vertex(   0, 0, 100);

      vertex(-100, 100, -100);
      vertex(-100, -100, -100);
      vertex(   0, 0, 100);
      endShape();
    }

    if (type == 2) { //paramètres de la sphère de l'univers 2
      stroke(255);
      lights();
      translate(pos_x, pos_y, 0);
      rotateX(TWO_PI * sin(millis()*seed2/1000.0));
      rotateY(TWO_PI * sin(millis()*seed/1000.0));
      sphere(50);
    }

    if (type == 3) {  //paramètres de la sphère de l'univers 3
      stroke(255);
      lights();
      translate(pos_x, pos_y, 0);
      rotateX(TWO_PI * sin(millis()*seed2/1000.0));
      rotateY(TWO_PI * sin(millis()*seed/1000.0));
      sphere(50);
    }


    if (type == 4) {  //paramètres du cube de l'univers 4
      strokeWeight(2);
      noFill();
      stroke(255);
      translate(pos_x, pos_y, 0);

      rotateX(TWO_PI * sin(millis()*seed2/1000.0));
      rotateY(TWO_PI * sin(millis()*seed/1000.0));
      box(40);
    }

    if (type == 5) {  //paramètres du cube de l'univers 5
      strokeWeight(2);
      noFill();
      stroke(255);
      translate(pos_x, pos_y, 0);

      rotateX(TWO_PI * sin(millis()*seed2/1000.0));
      rotateY(TWO_PI * sin(millis()*seed/1000.0));
      box(40);
    }

    popMatrix();
  }

  //retour formes
  float getZ() {
    return pos_z; //À la sortie, retour de la forme au centre
  }
}
