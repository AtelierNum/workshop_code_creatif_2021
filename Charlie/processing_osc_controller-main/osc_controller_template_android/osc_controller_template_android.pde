// add gui elements

import oscP5.*;
import netP5.*;


OscP5 oscP5;
NetAddress myRemoteLocation;
String ip = "127.0.0.1";
int port = 9000;

String[] pages = {"Settings", "boutons"}; // name of the pd patch to use as layout
PFont font ;
int patchWidth = 600;
int patchHeight = 800;

color cBack = #000000; // background
color cGuiback = #5A5858; // gui background
color cGuifront = #FF76B0; // gui foreground
color cCaption = #FFFFFF; // texts around


int fontSize = 48;
int eltHeight = 100;

GUI g;

void setup() {
  fullScreen();
  orientation(PORTRAIT);

  font = createFont("arial", fontSize);
  textSize(fontSize);


  oscP5 = new OscP5(this, 12001);
  myRemoteLocation = new NetAddress(ip, port);

  g = new GUI(eltHeight, pages);


  // add tab for each pd patch and populate it
  for (int i = 1; i < pages.length; i ++) { 
    String[] patch = loadStrings(pages[i] +".pd");
    // populate the tab with gui elements
    parse_patch(patch, i);
  }

  create_settings();
}


void draw() {
  background(cBack);
  g.updateControllers();

  
}

void keyReleased(){
  g.forwardKeyEvent(key);
}



// Code fourni par Berenger Recoule
