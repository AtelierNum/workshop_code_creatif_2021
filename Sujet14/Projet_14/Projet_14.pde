import processing.sound.*; //importe la biblioteque de son processing

/*
 Déplacement dans un espace défini par une carte en pixels
 workshop code créatif I2 2020-2021, 4 janvier 2021
 
 Une image est utilisée pour définir les déplacements possibles 
 ou les collisions avec les murs
 
 un facteur d'échelle est utilisé, il correspond à
 1 pixel de la carte = (facteur_echelle) pixels de l'affichage
 */

import oscP5.*;
import netP5.*;

OscP5 oscP5;

long  currentTime = 0 ;
long previousTimeY = 0 ;
long previousTimeX = 0 ;

int interval = 200;


PImage carte;                     // carte image pour la détection (100 x 100)
PImage carte_visuelle;            // carte visuelle 
int carte_largeur, carte_hauteur; // dimensions en pixel de lcarte
int facteur_echelle = 40;         // facteur d'échelle de la carte
int cases = 20;                   // PAIR! Nombre de cases représentées dans la fenetre (width / facteur_echelle)
int pos_x, pos_y;                 // Position du personnage dans la carte
int depl_x, depl_y;               // valeurs de déplacement par interaction clavier


/* **************************************************
 Permet d'appliquer un état modifiable aux sons afin de le jouer une seule fois
 ************************************************** */


SoundFile sonVert255;
boolean sonVert255HasPlayed = false;
SoundFile sonVert251;
boolean sonVert251HasPlayed = false;
SoundFile sonVert235;
boolean sonVert235HasPlayed = false;
SoundFile sonVert225;
boolean sonVert225HasPlayed = false;
SoundFile sonVert215;
boolean sonVert215HasPlayed = false;
//5
SoundFile sonVert205;
boolean sonVert205HasPlayed = false;
SoundFile sonVert195;
boolean sonVert195HasPlayed = false;
SoundFile sonVert185;
boolean sonVert185HasPlayed = false;
SoundFile sonVert175;
boolean sonVert175HasPlayed = false;
SoundFile sonVert165;
boolean sonVert165HasPlayed = false;
//10
SoundFile sonVert155;
boolean sonVert155HasPlayed = false;
SoundFile sonVert145;
boolean sonVert145HasPlayed = false;
SoundFile sonVert135;
boolean sonVert135HasPlayed = false;
SoundFile sonRouge255;
boolean sonRouge255HasPlayed = false;
SoundFile sonRouge246;
boolean sonRouge246HasPlayed = false;
//15
SoundFile sonRouge237;
boolean sonRouge237HasPlayed = false;
SoundFile sonRouge228;
boolean sonRouge228HasPlayed = false;
SoundFile sonRouge219;
boolean sonRouge219HasPlayed = false;
SoundFile sonRouge210;
boolean sonRouge210HasPlayed = false;
SoundFile sonRouge201;
boolean sonRouge201HasPlayed = false;
//20
SoundFile sonRouge192;
boolean sonRouge192HasPlayed = false;
SoundFile sonRouge183;
boolean sonRouge183HasPlayed = false;
SoundFile sonRouge174;
boolean sonRouge174HasPlayed = false;
SoundFile sonRouge165;
boolean sonRouge165HasPlayed = false;
SoundFile sonRouge156;
boolean sonRouge156HasPlayed = false;
//25
SoundFile sonRouge147;
boolean sonRouge147HasPlayed = false;
SoundFile sonRouge138;
boolean sonRouge138HasPlayed = false;
SoundFile sonRouge129;
boolean sonRouge129HasPlayed = false;
SoundFile sonRouge120;
boolean sonRouge120HasPlayed = false;
SoundFile sonRouge111;
boolean sonRouge111HasPlayed = false;
//30
SoundFile sonRouge102;
boolean sonRouge102HasPlayed = false;
SoundFile sonRouge93;
boolean sonRouge93HasPlayed = false;
SoundFile sonRouge84;
boolean sonRouge84HasPlayed = false;
SoundFile sonRouge75;
boolean sonRouge75HasPlayed = false;
SoundFile sonRouge66;
boolean sonRouge66HasPlayed = false;
//35
SoundFile sonRouge57;
boolean sonRouge57HasPlayed = false;
SoundFile sonRouge48;
boolean sonRouge48HasPlayed = false;
SoundFile sonRouge39;
boolean sonRouge39HasPlayed = false;
SoundFile sonRouge30;
boolean sonRouge30HasPlayed = false;
SoundFile sonRouge21;
boolean sonRouge21HasPlayed = false;
//40
SoundFile sonRouge12;
boolean sonRouge12HasPlayed = false;
SoundFile sonRouge3;
boolean sonRouge3HasPlayed = false;

SoundFile sonRouge25533;
boolean sonRouge25533HasPlayed = false;
//42

SoundFile sonBleu255;
boolean sonBleu255HasPlayed = false;
SoundFile sonBleu245;
boolean sonBleu245HasPlayed = false;
SoundFile sonBleu235;
boolean sonBleu235HasPlayed = false;
SoundFile sonBleu225;
boolean sonBleu225HasPlayed = false;


boolean are_sounds_playing = false;

void setup() {

  size(800, 800);
  carte = loadImage("carte.png"); //charge la carte des événement qui permet de déclencher les sons
  carte_visuelle = loadImage("carte_visuelle.png"); //charge la carte visuelle 
  carte_largeur = carte.width;
  carte_hauteur = carte.height;

  oscP5 = new OscP5(this, 12000);
  // La position de départ est fixée au milieu
  //pos_x = (int)carte_largeur / 2;
  //pos_y = (int)carte_hauteur / 2;


//point de départ du personnage
  pos_x = 56;
  pos_y = 78;


  /* **************************************************
   importation des fichiers son
   ************************************************** */

  /* sonFond = new SoundFile(this, "music_fond.wav");
   sonFond.play();*/

  sonBleu255 = new SoundFile(this, "poeme_je_vois.wav");
  sonBleu245 = new SoundFile(this, "poeme_la_raisonnance.wav");
  sonBleu235 = new SoundFile(this, "poeme_tu_te-souviens.wav");
  sonBleu225 = new SoundFile(this, "poeme_tu_es_arrive_2.wav");

  sonVert255 = new SoundFile(this, "le_poeme_debout.wav");
  sonVert251 = new SoundFile(this, "la_salle_incinerateur.wav");
  sonVert235 = new SoundFile(this, "salle_sas.wav");
  sonVert225 = new SoundFile(this, "salle_camera.wav");
  sonVert215 = new SoundFile(this, "salle_dossier.wav");
  //5
  sonVert205 = new SoundFile(this, "verriere.wav");
  sonVert195 = new SoundFile(this, "salle_controle.wav");
  sonVert185 = new SoundFile(this, "salle_entrainement.wav");
  sonVert175 = new SoundFile(this, "salle_reveil.wav");
  sonVert165 = new SoundFile(this, "dortoir_adulte.wav");

  //10
  sonVert155 = new SoundFile(this, "dortoir_enfant.wav");
  sonVert145 = new SoundFile(this, "salle_jeu.wav");
  sonVert135 = new SoundFile(this, "accueil.wav");
  sonRouge255 = new SoundFile(this, "eloigne_toi_de_ça.wav");
  sonRouge246 = new SoundFile(this, "ou_est_ce_qu'on_est_exactement.wav");
  //15
  sonRouge237 = new SoundFile(this, "obliger_arracher.wav");
  sonRouge228 = new SoundFile(this, "ustensile.wav");
  sonRouge219 = new SoundFile(this, "il_est_marrant_celui_la.wav");
  sonRouge210 = new SoundFile(this, "enregis_517.wav");
  sonRouge201 = new SoundFile(this, "salle_camera_declenchement_2.wav");

  //20
  sonRouge192 = new SoundFile(this, "salle_camera_declenchement.wav"); 
  sonRouge183 = new SoundFile(this, "rapport_638.wav");
  sonRouge174 = new SoundFile(this, "ne_rentre_pas_dans_cette_salle.wav");
  sonRouge165 = new SoundFile(this, "salle_dossier_declenchement_2.wav");
  sonRouge156 = new SoundFile(this, "sujet_14.wav");
  //25
  sonRouge147 = new SoundFile(this, "salle_jour_declenchement_1.wav");
  sonRouge138 = new SoundFile(this, "arretez_le.wav");
  sonRouge129 = new SoundFile(this, "salle_controle_declenchement_1.wav");
  sonRouge120 = new SoundFile(this, "ca_sert_a_rien.wav");
  sonRouge111 = new SoundFile(this, "ce_quil_ton_appris.wav");

  //30
  sonRouge102 = new SoundFile(this, "cooperait_pas_assez.wav");
  sonRouge93 = new SoundFile(this, "numero_8.wav");
  sonRouge84 = new SoundFile(this, "rire_reflexe.wav");
  sonRouge75 = new SoundFile(this, "exercice_pourri.wav");
  sonRouge66 = new SoundFile(this, "quand_meme_a_sourire.wav");
  //35
  sonRouge57 = new SoundFile(this, "jouer_a_ca.wav");
  sonRouge48 = new SoundFile(this, "niaise.wav");
  sonRouge39 = new SoundFile(this, "poeme_cest_bon.wav");
  //38
  sonRouge25533 = new SoundFile(this, "ca_te_rappelle_quelque_chose.wav");
}

void draw() {
  
  are_sounds_playing = testAudio();

  // Démarrage
  if (frameCount == 1) {
    tester_origine();
    afficher_carte();
  }
  
  currentTime = millis();

  // Si déplacement on réaffiche la carte en grand et on change la position
  if (depl_x != 0 || depl_y != 0) {

    background(0);

    // Récupérer la valeur du pixel de destination sur la carte
    color test = carte.get(pos_x + depl_x, pos_y + depl_y);
    float niveau = brightness(test);
    
    //permet d'afficher dans la console la couleur rvb de la case sur laquelle le personnage se trouve
    float r = red(test);
    float g = green(test);
    float b = blue(test);
    println(green(test));
    println(red(test));
    println(blue(test));


    /* **************************************************
     Joue une piste en fonction de la couleur sous le personnage
     ************************************************** */

    if ( r < 255 && g == 255) {
      if (sonVert255HasPlayed == false) {
        sonVert255.play();
        sonVert255HasPlayed = true;
      }
    }
    if ( r < 255 && g == 251) {
      if (sonVert251HasPlayed == false) {
        sonVert251.play();
        sonVert251HasPlayed = true;
      }
    }
    if ( r < 255 && g == 241) {
      if (sonVert235HasPlayed == false) {
        sonVert235.play();
        sonVert235HasPlayed = true;
      }
    }
    if ( r < 255 && g == 230) {
      if (sonVert225HasPlayed == false) {
        sonVert225.play();
        sonVert225HasPlayed = true;
      }
    }
    if ( r < 255 && g == 220) {
      if (sonVert215HasPlayed == false) {
        sonVert215.play();
        sonVert215HasPlayed = true;
      }
    }
    //5
    if ( r < 255 && g == 210) {
      if (sonVert205HasPlayed == false) {
        sonVert205.play();
        sonVert205HasPlayed = true;
      }
    }
    if ( r < 255 && g == 200) {
      if (sonVert195HasPlayed == false) {
        sonVert195.play();
        sonVert195HasPlayed = true;
      }
    }
    if ( r < 255 && g == 189) {
      if (sonVert185HasPlayed == false) {
        sonVert185.play();
        sonVert185HasPlayed = true;
      }
    }
    if ( r < 255 && g == 179) {
      if (sonVert175HasPlayed == false) {
        sonVert175.play();
        sonVert175HasPlayed = true;
      }
    }
    if ( r < 255 && g == 169) {
      if (sonVert165HasPlayed == false) {
        sonVert165.play();
        sonVert165HasPlayed = true;
      }
    }
    //10
    if ( r < 255 && g == 159) {
      if (sonVert155HasPlayed == false) {
        sonVert155.play();
        sonVert155HasPlayed = true;
      }
    }
    if ( r < 255 && g == 149) {
      if (sonVert145HasPlayed == false) {
        sonVert145.play();
        sonVert145HasPlayed = true;
      }
    }
    if ( r < 255 && g == 138) {
      if (sonVert135HasPlayed == false) {
        sonVert135.play();
        sonVert135HasPlayed = true;
      }
    }
    if ( g < 255 && r == 255 && b == 62) {
      if (sonRouge255HasPlayed == false) {
        sonRouge255.play();
        sonRouge255HasPlayed = true;
      }
    }
    if ( g < 255 && r == 255 && b == 86) {
      if (sonRouge246HasPlayed == false) {
        sonRouge246.play();
        sonRouge246HasPlayed = true;
      }
    }
    //15
    if ( g < 255 && r == 249 ) {
      if (sonRouge237HasPlayed == false) {
        sonRouge237.play();
        sonRouge237HasPlayed = true;
      }
    }
    if ( g < 255 && r == 229) {
      if (sonRouge228HasPlayed == false) {
        sonRouge228.play();
        sonRouge228HasPlayed = true;
      }
    }
    if ( g < 255 && r == 219) {
      if (sonRouge219HasPlayed == false) {
        sonRouge219.play();
        sonRouge219HasPlayed = true;
      }
    }
    if ( g < 255 && r == 210) {
      if (sonRouge210HasPlayed == false) {
        sonRouge210.play();
        sonRouge210HasPlayed = true;
      }
    }
    if ( g < 255 && r == 190) {
      if (sonRouge201HasPlayed == false) {
        sonRouge201.play();
        sonRouge201HasPlayed = true;
      }
    }
    //20
    if ( g < 255 && r == 200) {
      if (sonRouge192HasPlayed == false) {
        sonRouge192.play();
        sonRouge192HasPlayed = true;
      }
    }
    if ( g < 255 && r == 180) {
      if (sonRouge183HasPlayed == false) {
        sonRouge183.play();
        sonRouge183HasPlayed = true;
      }
    }
    if ( g < 255 && r == 171) {
      if (sonRouge174HasPlayed == false) {
        sonRouge174.play();
        sonRouge174HasPlayed = true;
      }
    }
    if ( g < 255 && r == 161) {
      if (sonRouge165HasPlayed == false) {
        sonRouge165.play();
        sonRouge165HasPlayed = true;
      }
    }
    if ( g < 255 && r == 151) {
      if (sonRouge156HasPlayed == false) {
        sonRouge156.play();
        sonRouge156HasPlayed = true;
      }
    }

    if ( g < 255 && r == 141) {
      if (sonRouge147HasPlayed == false) {
        sonRouge147.play();
        sonRouge147HasPlayed = true;
      }
    }
    //25
    if ( g < 255 && r == 255 && b == 33) {
      if (sonRouge25533HasPlayed == false) {
        sonRouge25533.play();
        sonRouge25533HasPlayed = true;
      }
    }
    if ( g < 255 && r == 131) {
      if (sonRouge138HasPlayed == false) {
        sonRouge138.play();
        sonRouge138HasPlayed = true;
      }
    }
    if ( g < 255 && r == 112) {
      if (sonRouge129HasPlayed == false) {
        sonRouge129.play();
        sonRouge129HasPlayed = true;
      }
    }
    if ( g < 255 && r == 102) {
      if (sonRouge120HasPlayed == false) {
        sonRouge120.play();
        sonRouge120HasPlayed = true;
      }
    }
    if ( g < 255 && r == 92) {
      if (sonRouge111HasPlayed == false) {
        sonRouge111.play();
        sonRouge111HasPlayed = true;
      }
    }
    //30
    if ( g < 255 && r == 63) {
      if (sonRouge102HasPlayed == false) {
        sonRouge102.play();
        sonRouge102HasPlayed = true;
      }
    }
    if ( g < 255 && r == 53) {
      if (sonRouge93HasPlayed == false) {
        sonRouge93.play();
        sonRouge93HasPlayed = true;
      }
    }
    //32
    if ( g < 255 && r == 83) {
      if (sonRouge84HasPlayed == false) {
        sonRouge84.play();
        sonRouge84HasPlayed = true;
      }
    }
    if ( g < 255 && r == 73) {
      if (sonRouge75HasPlayed == false) {
        sonRouge75.play();
        sonRouge75HasPlayed = true;
      }
    }
    if ( g < 255 && r == 44) {
      if (sonRouge66HasPlayed == false) {
        sonRouge66.play();
        sonRouge66HasPlayed = true;
      }
    }
    if ( g < 255 && r == 24) {
      if (sonRouge57HasPlayed == false) {
        sonRouge57.play();
        sonRouge57HasPlayed = true;
      }
    }
    if ( g < 255 && r == 14) {
      if (sonRouge48HasPlayed == false) {
        sonRouge48.play();
        sonRouge48HasPlayed = true;
      }
    }
    //37
    if ( g < 255 && r == 4) {
      if (sonRouge39HasPlayed == false) {
        sonRouge39.play();
        sonRouge39HasPlayed = true;
      }
    }


    if ( r ==24 && g < 255 && b == 255) {
      if (sonBleu255HasPlayed == false) {
        sonBleu255.play();
        sonBleu255HasPlayed = true;
      }
    }

    if ( r == 23 && g < 255 && b == 255) {
      if (sonBleu245HasPlayed == false) {
        sonBleu245.play();
        sonBleu245HasPlayed = true;
      }
    }

    if ( r == 21 && g < 255 && b == 245) {
      if (sonBleu235HasPlayed == false) {
        sonBleu235.play();
        sonBleu235HasPlayed = true;
      }
    }

    if ( r == 20 && g < 255 && b == 235) {
      if (sonBleu225HasPlayed == false) {
        sonBleu225.play();
        sonBleu225HasPlayed = true;
      }
    }

    println("jouer le son");

    // Ce pixel correspond il à une case accessible ?
    if (niveau > 2) { // si la nouvelle position est valide
      print("yop ... ");
      pos_x += depl_x;   // alors on y va
      pos_y += depl_y;
    } else {             // sinon, pas de déplacement
      print ("aïe ... ");
    }
  }
  afficher_carte();

  // Remettre les valeurs de déplacement à 0 
  depl_x = 0; 
  depl_y = 0;


  // Afficher le symbole du personnage (carré rouge)
  noStroke();
  fill(255, 0, 0);
  rect(width/2, height/2, facteur_echelle, facteur_echelle);

}

/* **************************************************
 Afficher l'image correspondant à la zone de carte
 ************************************************** */
void afficher_carte() {

  for (int x = -cases/2; x <= cases/2; x++) {
    for (int y = -cases/2; y <= cases/2; y++) {
      color tuile = carte.get(x + pos_x, y + pos_y);
      noStroke();
      if (x + pos_x >= 0 && x + pos_x < carte.width && y + pos_y >= 0 && y + pos_y < carte.height) {
        fill(tuile);
      } else {
        fill(128);
      }
      // On pourrait remplacer ci-dessous pour afficher une image
      rect(width/2 + x*facteur_echelle, height/2 + y*facteur_echelle, facteur_echelle, facteur_echelle);
    }
  } 
  // Calculer l'origine dans la carte visuelle
  int o_x = (pos_x - cases/2) * facteur_echelle;
  int o_y = (pos_y - cases/2) * facteur_echelle;
  //println("position de la case en haut à gauche : " + (pos_x - cases/2) + ", " + (pos_y - cases/2) + " / origine : " + o_x + ", " + o_y);
  PImage visu = carte_visuelle.get(o_x, o_y, width, height);
  image(visu, 0, 0);
}

/* ***************************************************
 Test au démarrage pour vérifier la position de départ
 *************************************************** */
void tester_origine() {
  //println("taille de la carte : largeur : " + carte.width + " / hauteur : " + carte.height);
  //println("position : x : " + pos_x + " / y : " + pos_y);
  color test = carte.get(pos_x, pos_y);
  float niveau = brightness(test);
  if (niveau < 1) println(niveau + " : Attention! Le point de départ est impossible");
}

/* **************************************************
 Contrôle du mouvement au clavier
 ************************************************** */

void keyPressed() {

  //**************************************************
  //Empecher les déplacement si une piste joue
  //************************************************** 

  if (sonVert255.isPlaying() || sonVert251.isPlaying() || sonVert235.isPlaying() || sonVert225.isPlaying() || sonVert215.isPlaying() 

    || sonVert205.isPlaying() || sonVert195.isPlaying() || sonVert185.isPlaying() || sonVert175.isPlaying() || sonVert165.isPlaying() 

    || sonVert155.isPlaying() || sonVert145.isPlaying() || sonVert135.isPlaying() || sonRouge255.isPlaying() || sonRouge246.isPlaying()

    || sonRouge237.isPlaying() || sonRouge228.isPlaying() || sonRouge219.isPlaying() || sonRouge210.isPlaying() || sonRouge201.isPlaying() 

    || sonRouge192.isPlaying() || sonRouge183.isPlaying() || sonRouge174.isPlaying() || sonRouge165.isPlaying() || sonRouge156.isPlaying() 

    || sonRouge147.isPlaying() || sonRouge138.isPlaying() || sonRouge129.isPlaying() || sonRouge120.isPlaying() || sonRouge111.isPlaying()

    || sonRouge102.isPlaying() || sonRouge93.isPlaying() || sonRouge84.isPlaying() || sonRouge75.isPlaying() || sonRouge66.isPlaying() 

    || sonRouge57.isPlaying() || sonRouge48.isPlaying() || sonRouge39.isPlaying()  || sonBleu255.isPlaying() || sonBleu245.isPlaying() || sonBleu235.isPlaying() || sonBleu225.isPlaying() ) 

  {
  } else {
    if (key == CODED) {
      if (keyCode == UP) {
        depl_y -= 1;
      } 
      if (keyCode == DOWN) {
        depl_y += 1;
      } 
      if (keyCode == LEFT) {
        depl_x -= 1;
      } 
      if (keyCode == RIGHT) {
        depl_x += 1;
      }
    }
  }
}


/* **************************************************
 Permet les déplacements via un accéléromètre d'une tablette android
 ************************************************** */

void oscEvent(OscMessage theOscMessage) {
  /*
   print("### received an osc message.");
   print(" addrpattern: "+theOscMessage.addrPattern());
   println(" typetag: "+theOscMessage.typetag());
  */
   
  /* **************************************************
   Empecher les déplacement si une piste joue
   ************************************************** */

  if (are_sounds_playing) 

  {
  } else {

    if (theOscMessage.checkAddrPattern("/accelerometer/x")==true) {

      float ax = theOscMessage.get(0).floatValue();  
      //print("ax   ");
      
      if (currentTime - previousTimeX > interval) {
        //println("ok   ");
       if (ax > 0.25) {
       depl_x += 1;
       } else if (ax < -0.25) {
       depl_x -= 1;
       }
       previousTimeX = currentTime;
       }
    }


    if (theOscMessage.checkAddrPattern("/accelerometer/y")==true) {
      
      float ay = theOscMessage.get(0).floatValue();
      
      
       if (currentTime - previousTimeY > interval) {
       if (ay < -0.25) {
       depl_y += 1;
       } else if (ay > 0.25) {
       depl_y -=1;
       }
       previousTimeY = currentTime;
       } 
    } 
  } 
}

boolean testAudio() { //verifie si un son joue afin de bloquer ou non les déplacements
  if (sonVert255.isPlaying() || sonVert251.isPlaying() || sonVert235.isPlaying() || sonVert225.isPlaying() || sonVert215.isPlaying() 

    || sonVert205.isPlaying() || sonVert195.isPlaying() || sonVert185.isPlaying() || sonVert175.isPlaying() || sonVert165.isPlaying() 

    || sonVert155.isPlaying() || sonVert145.isPlaying() || sonVert135.isPlaying() || sonRouge255.isPlaying() || sonRouge246.isPlaying()

    || sonRouge237.isPlaying() || sonRouge228.isPlaying() || sonRouge219.isPlaying() || sonRouge210.isPlaying() || sonRouge201.isPlaying() 

    || sonRouge192.isPlaying() || sonRouge183.isPlaying() || sonRouge174.isPlaying() || sonRouge165.isPlaying() || sonRouge156.isPlaying() 

    || sonRouge147.isPlaying() || sonRouge138.isPlaying() || sonRouge129.isPlaying() || sonRouge120.isPlaying() || sonRouge111.isPlaying()

    || sonRouge102.isPlaying() || sonRouge93.isPlaying() || sonRouge84.isPlaying() || sonRouge75.isPlaying() || sonRouge66.isPlaying() 

    || sonRouge57.isPlaying() || sonRouge48.isPlaying() || sonRouge39.isPlaying()  || sonBleu255.isPlaying() || sonBleu245.isPlaying() || sonBleu235.isPlaying() || sonBleu225.isPlaying() ) {
      
      return true;
    } else {
      return false;
    }
}
