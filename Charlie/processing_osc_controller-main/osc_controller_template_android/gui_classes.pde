/*
class for top level interaction :
 - lists all controllers and tabs and call their dedicated functions
 - Overloaded constructor for tabs or no tabs option
 */

class GUI {

  ArrayList<Controller> controllers;
  Tab tabs;
  boolean tabbed = false;

  GUI() {
    controllers = new ArrayList();
  }

  GUI(float minHeight, String[] tabsNames) { 
    controllers = new ArrayList();
    tabs = new Tab(minHeight, tabsNames);
    tabbed = true;
  }


  void addController(Controller c) {
    controllers.add(c);
  }

  void updateControllers() {
    if (tabbed) {
      tabs.draw();
      tabs.update(mouseX, mouseY);

      for (int i = 0; i < controllers.size(); i++) {
        Controller c = controllers.get(i);
        if (c.tabId == tabs.value) {
          c.draw();
          c.update(mouseX, mouseY);
        }
      }
    } else {
      for (int i = 0; i < controllers.size(); i++) {
        Controller c = controllers.get(i);
        c.draw();
        c.update(mouseX, mouseY);
      }
    }
  }

  void forwardKeyEvent(char k) {
    for (int i = 0; i < controllers.size(); i++) {
      Controller c = controllers.get(i);
      if (c.getClass().getSimpleName().contains("NumberField")) {  
        NumberField nf = (NumberField) c;
        if (key != CODED) {
          nf.fillup(key);
        } else {
          if (keyCode == 67) {
            nf.removeLast();
          } else if (keyCode == 66) {
            nf.focus = false;
          }
        }
      }
    }
  }


  Controller getControllerByName(String name) {
    Controller r = null;
    for (int i = 0; i < controllers.size(); i++) {
      Controller c = controllers.get(i);
      if (c.label.contains(name)) r = c;
    }
    return r;
  }
}

/* A main controller class :
 - all components will extend this class
 - a function is used to register callback function through the use of the interface below
 */
class Controller {
  float xpos, ypos;
  String label;
  color colorBack;
  color colorFront;
  int tabId = -1;

  float value = 0;
  float pvalue = 0;
  CallBackHandler cbh;


  Controller(float xpos, float ypos, String label) {
    this.xpos = xpos;
    this.ypos = ypos;
    this.label = label;
    colorBack = cGuiback;
    colorFront = cGuifront;
    cbh = new CallBackHandler(this);
  }

  void draw() {
  }
  void update(float mx, float my) {
  }
  void moveTo(int tabId) {
    this.tabId = tabId;
  }

  void onChange() {
    cbh.onEvent();
  };

  public void register(CallBackHandler cbh) {
    this.cbh = cbh;
  }
}

/* interface
 */
interface CallBack {                
  public void onEvent();
}

/* class to handle callbacks
 */
class CallBackHandler  implements CallBack {  
  Controller c;
  CallBackHandler (Controller c) {
    this.c = c;
  }
  public void onEvent( ) {
    //println("I've been called back");
  }
}

/*
Components
 */

class Button extends Controller {
  float w, h;
  float rounded = 10;
  float innerPadding = 4;
  boolean pressed = false;

  Button(float xpos, float ypos, float w, float h, String label) {
    super( xpos, ypos, label);
    this.w = w;
    this.h = h;
  }

  void draw() {
    noStroke();
    fill(colorBack);
    rect(xpos, ypos, w, h, rounded);
    if (pressed) {
      fill(colorFront);
      rect(xpos+innerPadding, ypos +innerPadding, w-innerPadding*2, h-innerPadding*2, rounded);
    }
    fill(255);
    textAlign(CENTER, BOTTOM);
    text(label, xpos + w/2, ypos);
  }

  void update(float mx, float my) {
    if (mx > xpos && mx <xpos + w  
      && my> ypos  && my < ypos +h  && mousePressed) {
      pressed = true;
      value = 1;
      if (pvalue != value) onChange();
    } else {
      pressed = false;
      value = 0;
    }
    pvalue = value;
  }
}

class ButtonCaresse extends Controller {
  float w, h;
  float rounded = 10;
  float innerPadding = 4;
  boolean pressed = false;
  PImage img;

  ButtonCaresse(float xpos, float ypos, float w, float h, String label) {
    super( xpos, ypos, label);
    this.w = w;
    this.h = h;
    img = loadImage("caresse.png");
  }

  void draw() {
    noStroke();
    fill(colorBack);
    rect(xpos, ypos, w, h, rounded);
    if (pressed) {
      fill(colorFront);
      rect(xpos+innerPadding, ypos +innerPadding, w-innerPadding*2, h-innerPadding*2, rounded);
      image(img,xpos+innerPadding, ypos +innerPadding, w-innerPadding*2, h-innerPadding*2);
    }
    image(img,xpos+innerPadding, ypos +innerPadding, w-innerPadding*2, h-innerPadding*2);
    fill(255);
    textAlign(CENTER, BOTTOM);
    text(label, xpos + w/2, ypos);
  }

  void update(float mx, float my) {
    if (mx > xpos && mx <xpos + w  
      && my> ypos  && my < ypos +h  && mousePressed) {
      pressed = true;
      value = 1;
      if (pvalue != value) onChange();
    } else {
      pressed = false;
      value = 0;
    }
    pvalue = value;
  }
}

class ButtonNourrir extends Controller {
  float w, h;
  float rounded = 10;
  float innerPadding = 4;
  boolean pressed = false;
  PImage img;

  ButtonNourrir(float xpos, float ypos, float w, float h, String label) {
    super( xpos, ypos, label);
    this.w = w;
    this.h = h;
    img = loadImage("nourrir.png");
  }

  void draw() {
    noStroke();
    fill(colorBack);
    rect(xpos, ypos, w, h, rounded);
    if (pressed) {
      fill(colorFront);
      rect(xpos+innerPadding, ypos +innerPadding, w-innerPadding*2, h-innerPadding*2, rounded);
      image(img,xpos+innerPadding, ypos +innerPadding, w-innerPadding*2, h-innerPadding*2);
    }
    image(img,xpos+innerPadding, ypos +innerPadding, w-innerPadding*2, h-innerPadding*2);
    fill(255);
    textAlign(CENTER, BOTTOM);
    text(label, xpos + w/2, ypos);
  }

  void update(float mx, float my) {
    if (mx > xpos && mx <xpos + w  
      && my> ypos  && my < ypos +h  && mousePressed) {
      pressed = true;
      value = 1;
      if (pvalue != value) onChange();
    } else {
      pressed = false;
      value = 0;
    }
    pvalue = value;
  }
}

class ButtonChien extends Controller {
  float w, h;
  float rounded = 10;
  float innerPadding = 4;
  boolean pressed = false;
  PImage img;

  ButtonChien(float xpos, float ypos, float w, float h, String label) {
    super( xpos, ypos, label);
    this.w = w;
    this.h = h;
    img = loadImage("chien.png");
  }

  void draw() {
    noStroke();
    fill(colorBack);
    rect(xpos, ypos, w, h, rounded);
    if (pressed) {
      fill(colorFront);
      rect(xpos+innerPadding, ypos +innerPadding, w-innerPadding*2, h-innerPadding*2, rounded);
      image(img,xpos+innerPadding, ypos +innerPadding, w-innerPadding*2, h-innerPadding*2);
    }
    image(img,xpos+innerPadding, ypos +innerPadding, w-innerPadding*2, h-innerPadding*2);
    fill(255);
    textAlign(CENTER, BOTTOM);
    text(label, xpos + w/2, ypos);
  }

  void update(float mx, float my) {
    if (mx > xpos && mx <xpos + w  
      && my> ypos  && my < ypos +h  && mousePressed) {
      pressed = true;
      value = 1;
      if (pvalue != value) onChange();
    } else {
      pressed = false;
      value = 0;
    }
    pvalue = value;
  }
}

class ButtonSelfie extends Controller {
  float w, h;
  float rounded = 10;
  float innerPadding = 4;
  boolean pressed = false;
  PImage img;

  ButtonSelfie(float xpos, float ypos, float w, float h, String label) {
    super( xpos, ypos, label);
    this.w = w;
    this.h = h;
    img = loadImage("selfie.png");
  }

  void draw() {
    noStroke();
    fill(colorBack);
    rect(xpos, ypos, w, h, rounded);
    if (pressed) {
      fill(colorFront);
      rect(xpos+innerPadding, ypos +innerPadding, w-innerPadding*2, h-innerPadding*2, rounded);
      image(img,xpos+innerPadding, ypos +innerPadding, w-innerPadding*2, h-innerPadding*2);
    }
    image(img,xpos+innerPadding, ypos +innerPadding, w-innerPadding*2, h-innerPadding*2);
    fill(255);
    textAlign(CENTER, BOTTOM);
    text(label, xpos + w/2, ypos);
  }

  void update(float mx, float my) {
    if (mx > xpos && mx <xpos + w  
      && my> ypos  && my < ypos +h  && mousePressed) {
      pressed = true;
      value = 1;
      if (pvalue != value) onChange();
    } else {
      pressed = false;
      value = 0;
    }
    pvalue = value;
  }
}

class ButtonBaguette extends Controller {
  float w, h;
  float rounded = 10;
  float innerPadding = 4;
  boolean pressed = false;
  PImage img;

  ButtonBaguette(float xpos, float ypos, float w, float h, String label) {
    super( xpos, ypos, label);
    this.w = w;
    this.h = h;
    img = loadImage("baguette.png");
  }

  void draw() {
    noStroke();
    fill(colorBack);
    rect(xpos, ypos, w, h, rounded);
    if (pressed) {
      fill(colorFront);
      rect(xpos+innerPadding, ypos +innerPadding, w-innerPadding*2, h-innerPadding*2, rounded);
      image(img,xpos+innerPadding, ypos +innerPadding, w-innerPadding*2, h-innerPadding*2);
    }
    image(img,xpos+innerPadding, ypos +innerPadding, w-innerPadding*2, h-innerPadding*2);
    fill(255);
    textAlign(CENTER, BOTTOM);
    text(label, xpos + w/2, ypos);
  }

  void update(float mx, float my) {
    if (mx > xpos && mx <xpos + w  
      && my> ypos  && my < ypos +h  && mousePressed) {
      pressed = true;
      value = 1;
      if (pvalue != value) onChange();
    } else {
      pressed = false;
      value = 0;
    }
    pvalue = value;
  }
}

////////////////////////////////////////////////////////////////////////////////////////////

class ColorSelector extends Controller {
  float w, h;
  float rounded = 10;
  float r = 255, g = 0, b =0;
  float pr = 0, pg = 0, pb = 0;
  float borderTolerance = 10;
  boolean radial = true;
  PImage img;

  ColorSelector(float xpos, float ypos, float w, float h, String label) {
    super( xpos, ypos, label);
    this.w = w;
    this.h = h;
    img = loadImage("color_wheel.png");
    img.loadPixels();
  }

  void draw() {
    noStroke();
    fill(cBack);
    rect(xpos, ypos, w, h, rounded);

    image(img, xpos, ypos, w, h);

    fill(r, g, b);
    noStroke();
    rect(xpos, ypos + h*.95, w, h*.05);

    fill(255);
    textAlign(LEFT, BOTTOM);
    text(label, xpos, ypos);

    fill(255);
    textAlign(RIGHT, BOTTOM);
    text("("+int(r) +","+int(g)+","+int(b)+")", xpos + w, ypos);
  }

  void update(float mx, float my) {
    if (mx > xpos -  borderTolerance && mx <xpos + w  +  borderTolerance 
      && my> ypos - borderTolerance && my < ypos +h + borderTolerance  && mousePressed) {
      float ex = map(mx, xpos, xpos +w, 0, img.width);
      float wy = map(my, ypos, ypos +w, 0, img.height);  
      color c = img.get(int(ex), int(wy));
      r = red(c);
      g = green(c);
      b = blue(c);
    }  
    if (pr != r || pg!=pg || pb !=b) onChange();
    pr = r;
    pb = b;
    pg = g;
  }
}

////////////////////////////////////////////////////////////////////////////////////////////

class NumberField extends Controller {
  float w, h;
  boolean focus = false;
  String content = "";
  float innerPadding = 4;
  float rounded = 10;
  char pkey='a';
  boolean change = true;

  NumberField(float xpos, float ypos, float w, float h, String label) {
    super(xpos, ypos, label);
    this.w = w;
    this.h = h;
  }

  void draw() {
    noStroke();
    fill(colorBack);
    rect(xpos, ypos, w, h, rounded);
    if (focus) {
      noFill();
      stroke(colorFront);
      strokeWeight(innerPadding);
      rect(xpos, ypos, w, h, rounded);
      strokeWeight(1);
    }

    fill(255);
    textAlign(LEFT, BOTTOM);
    text(label, xpos, ypos);

    textAlign(LEFT, CENTER);
    text(content, xpos + innerPadding, ypos +h/2);
  }

  void update(float mx, float my) {
    if (mousePressed) {
      if (mx > xpos && mx <xpos + w  
        && my> ypos  && my < ypos +h  && !focus) {
        focus = true;
        openKeyboard();
      }
    } else if (mx < xpos || mx >xpos + w  
      || my< ypos  || my > ypos +h ) {
      if (focus) {
        focus = false;
        closeKeyboard();
      }
    }
  }

  void fillup(char c) {
    if (focus) {
      if (c =='.' || c=='0' || c=='1' || c=='2' || c=='3' || c=='4'
        || c=='5' || c=='6' || c=='7' || c=='8' || c=='9'
        ) {
        content +=c;
        onChange();
      }
    }
  }

  void removeLast() {
    if (focus && content.length()>0) {
      content = content.substring(0, content.length()-1);
      onChange();
    }
  }
}

////////////////////////////////////////////////////////////////////////////////////////////

class Pad extends Controller {
  float w, h;
  float rounded = 10;
  float ex = 0;
  float wy = 0;
  float xvalue = 0;
  float yvalue= 0;
  float min = 0;
  float max = 127;
  float borderTolerance = 10;
  float px = 0;
  float py = 0;

  Pad(float xpos, float ypos, float w, float h, String label, float min, float max) {
    super( xpos, ypos, label);
    this.min = min;
    this.max = max;
    this.w = w;
    this.h = h;
    this.ex = xpos;
    this.wy = ypos;
  }

  void draw() {
    noStroke();
    fill(colorBack);
    rect(xpos, ypos, w, h, rounded);

    stroke(colorFront);
    line(ex, ypos, ex, ypos+h);
    line(xpos, wy, xpos +w, wy);

    fill(colorFront);
    ellipse(ex, wy, 10, 10);

    fill(255);
    textAlign(LEFT, BOTTOM);
    text(label, xpos, ypos);

    fill(255);
    textAlign(RIGHT, BOTTOM);
    text("("+int(xvalue) +","+int(yvalue)+")", xpos + w, ypos);
  }

  void update(float mx, float my) {
    if (mx > xpos -  borderTolerance && mx <xpos + w  +  borderTolerance 
      && my> ypos - borderTolerance && my < ypos +h + borderTolerance  && mousePressed) {
      xvalue = constrain(map(mx, xpos, xpos + w, min, max), min, max);
      yvalue = constrain(map(my, ypos, ypos +h, min, max), min, max);
      ex = constrain(mx, xpos, xpos +w);
      wy = constrain(my, ypos, ypos+h);
    }

    if (px != xvalue || py !=yvalue) onChange();
    px = xvalue;
    py = yvalue;
  }
}

////////////////////////////////////////////////////////////////////////////////////////////

class HRadio extends Controller {
  float w, h;
  float rounded = 100;
  boolean checked = false;
  boolean change = true;
  int nElts;
  ArrayList<Toggle> elts;
  float outterPadding = 2;

  HRadio(float xpos, float ypos, float w, float h, String label, int nElts) {
    super( xpos, ypos, label);
    this.nElts = nElts;
    this.w = w;
    this.h = h;
    elts = new ArrayList();
    float eltsSize = (w - outterPadding * nElts)/nElts;
    for (int i = 0; i < nElts; i++) {
      Toggle t = new Toggle(xpos + eltsSize * i + outterPadding*i, ypos, eltsSize, eltsSize, "" );
      t.rounded = this.rounded;
      if (i == 0 ) t.checked = true;
      elts.add(t);
    }
  }

  void draw() {
    fill(255);
    textAlign(LEFT, BOTTOM);
    text(label, xpos, ypos);
    for (int i = 0; i < nElts; i++) {
      elts.get(i).draw();
    }
  }

  void update(float mx, float my) {
    for (int i = 0; i < nElts; i++) {
      Toggle t =  elts.get(i);
      if (t.checked == false) {
        t.update(mx, my);
      }

      if (t.checked == true  ) {
        value = i;
      } 
      for (int j = 0; j < nElts; j++) {
        if (value!=j) elts.get(j).checked = false;
      }
    }
    if (pvalue != value) onChange();
    pvalue = value;
  }
}

////////////////////////////////////////////////////////////////////////////////////

class VRadio extends Controller {
  float w, h;
  float rounded = 100;
  boolean checked = false;
  boolean change = true;
  int nElts;
  ArrayList<Toggle> elts;
  float outterPadding = 2;

  VRadio(float xpos, float ypos, float w, float h, String label, int nElts) {
    super( xpos, ypos, label);
    this.nElts = nElts;
    this.w = w;
    this.h = h;
    elts = new ArrayList();
    float eltsSize = (h - outterPadding * nElts)/nElts;
    for (int i = 0; i < nElts; i++) {
      Toggle t = new Toggle(xpos, ypos + + eltsSize * i + outterPadding*i, eltsSize, eltsSize, "" );
      t.rounded = this.rounded;
      if (i == 0 ) t.checked = true;
      elts.add(t);
    }
  }

  void draw() {
    fill(255);
    textAlign(CENTER, BOTTOM);
    text(label, xpos + w/2, ypos);
    for (int i = 0; i < nElts; i++) {
      elts.get(i).draw();
    }
  }

  void update(float mx, float my) {
    for (int i = 0; i < nElts; i++) {
      Toggle t =  elts.get(i);
      if (t.checked == false) {
        t.update(mx, my);
      }

      if (t.checked == true  ) {
        value = i;
      } 
      for (int j = 0; j < nElts; j++) {
        if (value!=j) elts.get(j).checked = false;
      }
    }
    if (pvalue != value) onChange();
    pvalue = value;
  }
}

////////////////////////////////////////////////////////////////////////////////////

class HSlider extends Controller {
  float w, h;
  float pos;
  float min, max;
  float rounded = 10;
  float borderTolerance = 10; // on left and right to have min max value more easily
  float innerPadding = 4; // padding between back and front

  HSlider(float xpos, float ypos, float w, float h, String label, float min, float max) {
    super( xpos, ypos, label);

    this.pos = map(value, min, max, 0, w);
    this.min = min;
    this.max = max;
    this.w = w;
    this.h = h;
  }

  void draw() {
    noStroke();
    fill(colorBack);
    rect(xpos, ypos, w, h, rounded);

    fill(colorFront);
    pos = constrain(map(value, min, max, 0, w-innerPadding*2), 0, w-innerPadding*2);
    rect(xpos+innerPadding, ypos+innerPadding, pos, h-innerPadding*2, rounded);



    fill(255);
    textAlign(LEFT, BOTTOM);
    text(label, xpos, ypos);
    textAlign(RIGHT, BOTTOM);
    text(nf(value, 0, 2), xpos + w, ypos);
  }

  void update(float mx, float my) {
    if (mx > xpos-borderTolerance && mx <xpos + w + borderTolerance 
      && my> ypos && my < ypos +h && mousePressed) {
      value = constrain(map(mx, xpos, xpos+ w, min, max), min, max);
    } 
    if (pvalue !=value) { 
      onChange();
      pvalue = value ;
    }
  }
}

////////////////////////////////////////////////////////////////////////////////////

class VSlider extends Controller {
  float w, h;
  float pos;
  float min, max;
  float rounded = 10;
  float borderTolerance = 10; // on left and right to have min max value more easily
  float innerPadding = 4; // padding between back and front

  VSlider(float xpos, float ypos, float w, float h, String label, float min, float max) {
    super( xpos, ypos, label);
    this.pos = map(value, min, max, 0, w);
    this.min = min;
    this.max = max;
    this.w = w;
    this.h = h;
  }

  void draw() {
    noStroke();
    fill(colorBack);
    rect(xpos, ypos, w, h, rounded);

    fill(colorFront);
    pos = constrain(map(value, min, max, 0, h-innerPadding*2), 0, h-innerPadding*2);
    rect(xpos+innerPadding, ypos + h-innerPadding, w-innerPadding*2, - pos, rounded);

    fill(255);
    textAlign(CENTER, BOTTOM);
    text(label, xpos + w/2, ypos );
    textAlign(CENTER, TOP);
    text(nf(value, 0, 2), xpos +w/2, ypos+h);
  }

  void update(float mx, float my) {
    if (mx > xpos && mx <xpos + w  
      && my> ypos -borderTolerance && my < ypos +h + borderTolerance && mousePressed) {
      value = constrain(map(my, ypos+ h, ypos, min, max), min, max);
    } 
    if (pvalue !=value) { 
      onChange();
      pvalue = value ;
    }
  }
}

////////////////////////////////////////////////////////////////////////////////////

class Tab extends Controller {
  float h;
  float rounded = 0;
  boolean checked = false;
  boolean change = true;
  int nElts;
  ArrayList<Toggle> elts;
  int value = 0;
  float outterPadding = 2;
  String[]names;

  Tab(float h, String[] names) {
    super( 0, 0, "");
    this.nElts = names.length;
    this.h = h;
    elts = new ArrayList();
    float eltsSize = (width - outterPadding * nElts)/nElts;
    for (int i = 0; i < nElts; i++) {
      Toggle t = new Toggle( eltsSize * i + outterPadding*i, 0, eltsSize, h, names[i] );
      t.innerPadding = 0;
      t.rounded = this.rounded;
      if (i == 0) t.checked = true;
      elts.add(t);
    }
  }

  void draw() {
    fill(255);
    textAlign(LEFT, BOTTOM);
    text(label, xpos, ypos);
    for (int i = 0; i < nElts; i++) {
      Toggle t = elts.get(i);
      t.draw();
      textAlign(CENTER, CENTER);
      text(t.label, t.xpos + t.w/2, t.ypos + t.h/2);
    }
  }

  void update(float mx, float my) {
    for (int i = 0; i < nElts; i++) {
      Toggle t =  elts.get(i);
      t.update(mx, my);
      if (t.checked == true  ) {
        value = i;
      } 
      for (int j = 0; j < nElts; j++) {
        if (value!=j) elts.get(j).checked = false;
      }
    }
  }
}

////////////////////////////////////////////////////////////////////////////////////

class TextLabel extends Controller {

  color colorBack;
  color colorFront;
  color c;

  TextLabel(float xpos, float ypos, String label, color c) {
    super(xpos, ypos, label);
    this.c = c;
  }

  void draw() {
    fill(this.c);
    textAlign(LEFT, TOP);
    text(this.label, this.xpos, this.ypos);
  }
  void update(float mx, float my) {
  }
}

////////////////////////////////////////////////////////////////////////////////////


class Toggle extends Controller {
  float w, h;
  float rounded = 10;
  float borderTolerance = 10; // on left and right to have min max value more easily
  float innerPadding = 4;
  boolean checked = false;
  boolean change = true;

  Toggle(float xpos, float ypos, float w, float h, String label) {
    super( xpos, ypos, label);
    this.w = w;
    this.h = h;
  }

  void draw() {
    noStroke();
    fill(colorBack);
    rect(xpos, ypos, w, h, rounded);
    if (checked) {
      value = 1;
      fill(colorFront);
      rect(xpos+innerPadding, ypos +innerPadding, w-innerPadding*2, h-innerPadding*2, rounded);
    } else {
      value = 0;
    }

    fill(255);
    textAlign(CENTER, BOTTOM);
    text(label, xpos + w/2, ypos );
  }

  void update(float mx, float my) {
    if (mousePressed) {
      if (mx > xpos && mx <xpos + w  
        && my> ypos  && my < ypos +h  && change) {

        change = false;
        checked = ! checked;

        if (checked) value =1;
        else value=0;
        onChange();
      }
    } else {
      change = true;
    }
  }
}
