//Importation de la librairie gerant le leapmotion
import de.voidplus.leapmotion.*;
LeapMotion leap;

//Importation de la librairie gerant le son
import processing.sound.*;

//Classe des univers
UniversColere uColere;
UniversSerein uSerein;
UniversSucces uSucces;
UniversAngoisse uAngoisse;

// Permet de dire qu'elle emotion est active
int currentEmotionIndex = 1;

//Création d'un cube qui limitera l'espace disponible pour nos particules
float box = 240/3;

// Section pour l'effet hologramme
VideoCreate videoQuad = new VideoCreate();
PGraphics scene;
int sceneSize;

void setup() {
  size(1000, 1000, P3D);   //Taille de l'écran
  background(0);

  //Import des fichiers de musique se trouvant dans le dossier data
  SoundFile son1 = new SoundFile(this, "serein.mp3");
  SoundFile son2 = new SoundFile(this, "angoisse.mp3");
  SoundFile son3 = new SoundFile(this, "colere.mp3");
  SoundFile son4 = new SoundFile(this, "sucess.mp3");

  // Section pour l'effet hologramme
  sceneSize = height/3;
  scene = createGraphics(sceneSize, sceneSize, P3D);

  // Initialisation des différents univers
  uSerein = new UniversSerein(son1, #4976E3, #0A8987, #163AB7, #1665B7, 1, 1);
  uAngoisse = new UniversAngoisse(son2, #C300FF, #A500FF, #7600FF, #5000FF, 0.0001, 3);
  uColere = new UniversColere(son3, #5620AF, #D80B94, #861107, #CB15AD, 3, 2);
  uSucces = new UniversSucces(son4, #FFFFFF, #FFFDB2, #FFFA6A, #FFF936, 1.5, 1.5);

  // Controlleur du Leap motion
  leap = new LeapMotion(this);
}

void draw() {
  
  scene.beginDraw(); // On transforme la scene en une image simple afin de la dupliquer sans surcharger la mémoire
  scene.background(0);
  
  // Choisir l'émotion a jouer en fonction de la valeur de currentEmotionIndex
  switch (currentEmotionIndex) {
  case 1:
    uSerein.update(scene);
    break;
  case 2:
    uColere.update(scene);
    break;
  case 3:
    uSucces.update(scene);
    break;
  case 4:
    uAngoisse.update(scene);
    break;
  default:
    uSerein.update(scene);
    break;
  }
  
scene.endDraw(); // On finalise l'image avant qu'elle ne soit dupliqué
 videoQuad.videoOlogra(); // C'est ici que l'image est dupliquée et préparée pour l'effet hologramme
}

// Changement d'univers avec les touches de Makey makey   
void keyPressed() {
  if (key == CODED) {
    //Affecte la valeur à currentEmotionIndex en fonction de la touche presse
    switch (keyCode) {
    case RIGHT:
      currentEmotionIndex = 1;
      break;
    case LEFT:
      currentEmotionIndex = 2;
      break;
    case UP:
      currentEmotionIndex = 3;
      break;
    case DOWN:
      currentEmotionIndex = 4;
      break;
    default:
      // Ne fait rien pour les autres touches
      break;
    }
    //Permet de ne pas avoir de son qui est joué en parallèle
    uSerein.stopSound();
    uColere.stopSound();
    uSucces.stopSound();
    uAngoisse.stopSound();
  }
};

// Classe permetant de géré l'affichage en 4 images de la scene
class VideoCreate {

  VideoCreate() {
  }

  void videoOlogra() {
    //Scenes Translate and Rotate
    //TOP
    translate(width/2-sceneSize/2, 0);
    pushMatrix();
    image(scene, 0, 0);
    popMatrix();

    //RIGHT
    translate((sceneSize*2)-1, (height/2)-(sceneSize/2)-1);
    pushMatrix();
    rotate(PI/2);
    image(scene, 0, 0);
    popMatrix();

    //DOWN
    translate(-sceneSize+1, (sceneSize*2)-1);
    pushMatrix();
    rotate(PI);
    image(scene, 0, 0);
    popMatrix();

    //LEFT
    translate((-sceneSize*2)+1, -sceneSize+1);
    pushMatrix();
    rotate(3*PI/2);
    image(scene, 0, 0);
    popMatrix();
  }
}
