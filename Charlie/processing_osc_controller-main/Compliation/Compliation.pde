import oscP5.*;
import netP5.*;
import ddf.minim.*;
Minim minim;
AudioPlayer choc;
AudioPlayer thug;
AudioPlayer piranha;
AudioPlayer vomis;
AudioPlayer nyancat;
AudioPlayer harry;
AudioPlayer faim;
AudioPlayer etourdi;
AudioPlayer ouaf;
AudioPlayer joie;
AudioPlayer leFrance;
AudioPlayer pasContent;
AudioPlayer amoureux;
AudioPlayer vicious;
AudioPlayer ennuiSon;
Chat c;

OscP5 oscP5;
NetAddress myRemoteLocation;
boolean nourrir = false;
boolean bread = false;
boolean chien = false;
boolean caresse = false;
boolean photo = false;
boolean photoRandom = false;
int nourrir_timer, baguette_timer, chien_timer, caresse_timer, photo_timer;
int nourrir_tap, baguette_tap, chien_tap, caresse_tap, photo_tap = 0;
boolean potter = false;
boolean amour = false;
boolean vomir = false;
boolean vicieux = false;
boolean nyan = false;
boolean ennuie = false;
int bagette_spammed = 0;

PImage lunette;
PImage baguette;
PImage beret;
PFont police;
PImage tartine;
float orientationAlpha = 0;
float orientationBeta = 0;
float orientationGamma = 0;
float audioFrequency = 0;
float light = 0;
float linearAcceleration = 0;
boolean neutre = false;
int neutre_timer = 60000;
int dort_timer = 65000;
int miaou_timer = 1500;

int previousTimeNeutre = 0;
int previousTimeDort = 0;
int previousMiaou = 0;
int currentTime = 0;

int index = 0;
float averageAcc [] = new float[100]; //Tableau de moyenne des valeurs de acceleration, pour créer un délai par la suite

int sleepMode = 0;

void setup() {
  size(1920, 1080);
  nourrir_timer = millis();
  c = new Chat();
  frameRate(25);
  minim = new Minim(this);
  choc = minim.loadFile("choc.mp3");
  thug = minim.loadFile("Snoops dogs.mp3");
  piranha = minim.loadFile("piranha plants music.mp3");
  vomis = minim.loadFile("vomis.mp3");
  nyancat = minim.loadFile("nyancat.mp3");
  harry = minim.loadFile("harrypotter.mp3");
  faim = minim.loadFile("g faim.mp3");
  etourdi = minim.loadFile("etourdi.mp3");
  ouaf = minim.loadFile("ouaf.mp3");
  joie = minim.loadFile("joie.mp3");
  leFrance = minim.loadFile("france.mp3");
  pasContent = minim.loadFile("colere.mp3");
  amoureux = minim.loadFile("amour.mp3");
  vicious = minim.loadFile("vicieux.mp3");
  ennuiSon = minim.loadFile("ennui.mp3");
  police= loadFont ("Arial-Black-48.vlw");
  textFont(police, 192);
  lunette = loadImage("unnamed.png");
  tartine = loadImage("bread.png");
  baguette = loadImage("baguette.png");
  beret = loadImage("beret.png");
  /* start oscP5, listening for incoming messages at port 12000 */
  oscP5 = new OscP5(this, 7348);

  for (int i = 0; i < averageAcc.length; i ++) { //On ajoute les valeurs au tableau
    averageAcc[i] = 0;
  }
}

void draw() {
  background(62, 60, 85);
  float average = 0;
  currentTime = millis();

  for (int i = 0; i < averageAcc.length; i ++) {
    average += averageAcc[i];
  }
  average = average/averageAcc.length; // Calcul de la moyenne
  //println(average);


  if (orientationAlpha > 150) {
    c.base();
    c.neutre();
    resetTimersIfSleep();
  } else {
    if (average > 0.5) { //Si la moyenne de l'acceleration est > à 0.5
      c.base();
      c.etourdi();
      if (etourdi.isPlaying() == false) {
        etourdi.play(0);
      }
      resetTimersIfSleep();
    } else {
      if (light > 90) {
        c.base();
        c.choc();
        resetTimersIfSleep();
        if (choc.isPlaying() == false) {
          choc.play(0);
        }
      } else {
        if (light < 1) {
          c.base();
          c.dort();
          resetTimersIfSleep();
          if (!piranha.isPlaying()) {
            piranha.play();
          }
          //println(light);
        } else {
          if ((orientationGamma > 80) && (orientationGamma < 200)) {
            c.base();
            c.dab();
            if (!thug.isPlaying()) {
              thug.play();
            }
            resetTimersIfSleep();
          } else {
            if (audioFrequency > 7000) {
              c.base();
              c.choc();
              resetTimersIfSleep();
            } else {
              if (sleepMode == 0) {
                c.base();
                c.neutre();
                choc.pause();
                thug.pause();
                piranha.pause();
                //nyancat.pause();

                if (currentTime - previousTimeNeutre  > neutre_timer) {
                  previousTimeNeutre = currentTime;
                  sleepMode = 1;
                }
                if (currentTime - previousMiaou > miaou_timer) {
                  if (!faim.isPlaying()) {
                    faim.play();
                  }
                }
              } else if (sleepMode == 1) { 
                c.base();
                c.ennui();
                if (!ennuie) {
                  ennuie = true;
                  if (ennuiSon.isPlaying() == false) {
                    ennuiSon.play(0);
                  }
                }
                if (currentTime - previousTimeDort > dort_timer) {
                  previousTimeDort = currentTime;
                  sleepMode = 2;
                }
              } else if (sleepMode >= 2) {
                c.base();
                c.dort();
              }
            }
          }
        }
      }
    }
  }
  if (millis() - photo_timer > 5000) {
    vomir= false;
    amour = false;
  }
  if (nourrir == true) {

    if (millis() - nourrir_timer > 5000) {
      nourrir= false;
      nyan = false;
      nourrir_tap = 0;
    }
    c.joie();

    if (joie.isPlaying() == false) {
      joie.play(0);
    }
    if (nourrir_tap > 7) {
      c.tartine();
      //c.nyan();
      nyan = true;
      joie.pause();
      if (!nyancat.isPlaying()) {
        nyancat.play();
      }
    }
  } else if (bread == true) { 
    if (leFrance.isPlaying() == false) {
      leFrance.play(0);
    }
    if (millis() - baguette_timer > 5000) {
      bread= false;
      baguette_tap = 0;
      potter = false;
    }
    if (!potter) c.france();
    if (baguette_tap > 7) {
      //c.base();
      baguette_tap = 0;
      if (random(100) > 50) {
        potter = true;
        if (potter == true) {
          if (!harry.isPlaying()) harry.play();
          leFrance.pause();
        }
      } else {
        potter = false;
        c.france();
      }
    }
  } else if (photo == true) {


    if (millis() - photo_timer > 5000) {
      photo= false;
      photo_tap = 0;
      amour = false;
      vomir= false;
      vicieux = false;
      //photoRandom = true;
    }
    if (photoRandom && photo_tap == 1) {
      float r = random(100);
      if (r > 80) {
        amour = true;
        if (amour == true) {
          if (!amoureux.isPlaying()) amoureux.play(0);
        }
      } else if (r > 50 && r< 80) {
        vomir = true;
        if (vomir == true) {
          if (!vomis.isPlaying()) vomis.play(0);
        }
      } else {
        vicieux = true;
        if (vicieux == true) {
          if (!vicious.isPlaying())  vicious.play(0);
        }
      }
      photoRandom = false;
    }


    //println("photo ", photo_tap);



    // photo = false;
  } else if (chien == true) { 
    if (!ouaf.isPlaying()) ouaf.play();
    if (millis() - chien_timer > 5000) {
      chien= false;
      chien_tap=0;
    }

    c.dog();
    if (chien_tap > 7) {
      c.colere();
       if (!pasContent.isPlaying()) {
        pasContent.play(0);
            joie.pause();
      }
    }
  } else if (caresse == true) {
    if (!joie.isPlaying()) joie.play(0);
    if (millis() - caresse_timer > 5000) {
      caresse= false;
      caresse_tap = 0;
    }
    c.joie();
    if (caresse_tap > 7) {
      c.colere();
      if (pasContent.isPlaying() == false) {
        pasContent.play(0);
        joie.pause();
      }
    }
  } else {

    //c.neutre();
    nyancat.pause();
    harry.pause();
    leFrance.pause();
  }

  if (potter) {
    c.potter();
    leFrance.pause();
  }
  if (vicieux) {
    c.vicieux();
  }
  if (amour) {
    c.amour();
  }
  if (vomir) {
    c.vomir();
  }
  if (nyan) {
    c.nyan();
  }
  if (photo_tap > 7) {
    vomir = false;
    amour = false;
    vicieux = false;
    //photo_tap = 0;
    c.colere();
  }
}

void resetTimersIfSleep() {
  //  if (sleepMode == 2) {
  sleepMode =0;
  ennuie = false;
  previousTimeNeutre = currentTime;
  previousTimeDort = currentTime;
  //  }
}
void oscEvent(OscMessage theOscMessage) {

  /*
  //Orientation Alpha
   if (theOscMessage.checkAddrPattern("/orientation/alpha")==true) {
   
   }*/
  /*
  //Orientation Beta
   if (theOscMessage.checkAddrPattern("/orientation/beta")==true) {
   
   
   //orientationBeta = map(theOscMessage.get(0).floatValue(), -0, 180, 0, 500);
   }*/
  //Orientation Gamma
  if (theOscMessage.checkAddrPattern("/orientation/gamma")==true) {

    orientationGamma = map(theOscMessage.get(0).floatValue(), -0, 180, 0, 500);
    //println(orientationGamma);
  }


  //Audio
  if (theOscMessage.checkAddrPattern("/audio/frequency")==true) {


    audioFrequency = map(theOscMessage.get(0).floatValue(), 20, 35, 0, 100);
    //println(audioFrequency);
  }

  //Light
  if (theOscMessage.checkAddrPattern("/light")==true) {


    light = map(theOscMessage.get(0).floatValue(), 0, 1, 0, 100);
    // println(light);
  }

  //Linear Acceleration Z
  if (theOscMessage.checkAddrPattern("/linear_acceleration/z")==true) {
    linearAcceleration =(float) theOscMessage.get(0).floatValue();
    // println(abs(linearAcceleration));
    averageAcc[index] = abs(linearAcceleration);
    index++;
    //println(index);
    // printArray(averageAcc);
    if (index >= averageAcc.length) index = 0;


    //  linearAcceleration = theOscMessage.get(0).floatValue();
  }

  if (theOscMessage.checkAddrPattern("/nourrir")==true) {
    nourrir = true;
    nourrir_timer = millis();
    nourrir_tap++;
    print(nourrir, nourrir_tap);
    println("nourrir appuyé");
  }

  if (theOscMessage.checkAddrPattern("/baguette")==true) {
    println("baguette appuyé");
    bread = true;
    baguette_timer = millis();
    baguette_tap ++;
    print(baguette);
  }

  if (theOscMessage.checkAddrPattern("/chien")==true) {
    println("chien appuyé");
    chien = true;
    chien_timer = millis();
    chien_tap ++;
    print(chien);
  }
  if (theOscMessage.checkAddrPattern("/selfie")==true) {
    println("selfie appuyé");
    photo = true;
    photo_timer = millis();
    photo_tap ++;
    photoRandom = true;
    print(baguette);
  }
  if (theOscMessage.checkAddrPattern("/caresse")==true) {
    println("caresse appuyé");
    caresse = true;
    caresse_timer = millis();
    caresse_tap ++;
    print(caresse);
  }
  //  println("### received an osc message. with address pattern "+theOscMessage.addrPattern());
}
