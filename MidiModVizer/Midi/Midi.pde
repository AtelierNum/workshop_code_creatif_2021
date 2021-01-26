import themidibus.*;                                                                 // importation des bibliothèques 
import java.util.*;
import oscP5.*;
import netP5.*;

OscP5 oscP5;                                                                         
MidiBus bus;
MidiBus sendbus;
NoteManager nm;

float b = 0;                                                                        // création de 3 varriables corespondants aux donnés du gyroscope 
float g = 0;
float a = 0;



  int channel = 2;                                                                  //chanel midi corepondant au synthé
  int number = 43;                                                                  //paramètre du cutoff du filtre (la fréquence du filtre) 



void setup() {
  size(700,700);                                                                   //créatoin d'un écran carré de 700px avec 48 images par secondes et un fond noir
  frameRate(48);
  background(0);
  
  MidiBus.list();
  bus = new MidiBus(this, 2, 5);                                                   // liste des midibus utilisé (entrée midi, sortie midi)
  bus = new MidiBus(this, 3, 6);
  sendbus = new MidiBus(this, 0, 4);
  nm = new NoteManager();
  oscP5 = new OscP5(this, 12000);                                                  // données du téléphones
}

 void oscEvent(OscMessage theOscMessage) {
  if (theOscMessage.checkAddrPattern("/orientation/beta")==true) {                 // transformation des donnes du téléphones en b, g et a
    b = theOscMessage.get(0).intValue();
  }
  if (theOscMessage.checkAddrPattern("/orientation/gamma")==true) {
    g = theOscMessage.get(0).floatValue();
  }
  if (theOscMessage.checkAddrPattern("/orientation/alpha")==true) {
    a = theOscMessage.get(0).floatValue();
  }  

  println("### received an osc message. with address pattern "+theOscMessage.addrPattern());             
}

 
 void controllerChange(int channel, int number, int value) {
  println("Controller Change: " + channel + ", " + number + ", " + value);
}
 
void draw() {
  background(0,0,random(0,50));                                                     // dessin d'une ellipse qui varrie en fonction de g et d'un fond qui clignote en bleu. 
  fill(255);
  ellipse(width*.5, height*.5, g*5, g*5);
  
  nm.track();                                                                       // intégration des notes reçus par midibus (voir fichier Note) 
  
  int channel = 15;                                                                 

  int value = 2*(abs(int(g)));                                                      //transormation des données du téléphone en un entier positif a la bonne échelle pour jouer 
    delay(1);

  sendbus.sendControllerChange(channel, number, value);                             // Send a controllerChange


  println(value);
}




void noteOn(int channel, int pitch, int velocity) {
  nm.addNote(new Note(channel, pitch, velocity));                                   //création d'une note 
  println("Note on: " + channel + ", " + pitch + ", " + velocity);
}

void noteOff(int channel, int pitch, int velocity) {
  nm.releaseNote(new Note(channel, pitch, velocity));                               //fin de note
  println("Note off: " + channel + ", " + pitch + ", " + velocity);
}


 
