//Code pour créer scène 1 avec planète qui tourne, effet météorites, et son météorites
//Code trouvé sur processing.org (sphère, collage d'une image, météorites) et également sur le forum de processing.org
//setup général de la scène 1
void setup_planete() { 
  x = 0.02; 
  fond1=loadImage("fond1.jpg");
  PImage earth = loadImage( "marbre.jpg");
  globe = createShape(SPHERE, 200); 
  globe.setStroke(false);
  globe.setTexture(earth);
  noStroke();

  //setup spécifique aux météorites 
  setup_meteorites();
  if (!DEV) effet_1=new SoundFile(this, "pluie.mp3");
  //keyPressed();
  
  silhouette_1 = loadImage( "ombre1.png");
}


//pour créer la planète
void draw_planete() {

  x +=  0.01;

  image(fond1, 0, 0);
  pushMatrix();
  translate(width/2, height/2, 0);
  lights();
  rotateY(x);  
  shape(globe);
  popMatrix();


  //conditions pour faire apparaitre météorites

  if (show_meteorites) {

    println("meteorites");
    draw_meteorites();
  }
  hint(DISABLE_DEPTH_TEST);
  fill(255);
  image(silhouette_1, 410, 160);
  hint(ENABLE_DEPTH_TEST);
}


void mousePressed_planete() {
  if (scene==1) {
    show_meteorites = true;
  } else {
    show_meteorites = false;
  }
}


//conditions pour lancer le son

void keyPressed_planete() {
  if (key==' ') {
    if (scene == 1) {
      if (!DEV) effet_1.loop();
    } else {
      effet_1.stop();
    }
  }
}
