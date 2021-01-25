class Chat {


  Chat() {
  }

  void tartine() {
    tartine.resize(800, 861);                  //tartine pour le nyan cat
    image(tartine, 550, 100);
  }

  void base() {              // la base du visage du chat
    fill(206);
    noStroke();
    rect(710, 340, 500, 500);

    fill(206);
    beginShape();
    vertex(1210, 340);
    vertex(1010, 340);
    vertex(1010, 340);
    vertex(1210, 140);
    endShape();

    fill(206);
    beginShape();
    vertex(710, 340);
    vertex(710, 140);
    vertex(710, 140);
    vertex(910, 340);
    endShape();

    fill(206);
    noStroke();
    rect(410, 540, 300, 70);
    fill(255);
    rect(510, 640, 200, 70);
    rect (640, 470, 70, 70);


    fill(206);
    noStroke();
    rect(1210, 540, 300, 70);
    fill(255);
    noStroke();
    rect (1210, 470, 70, 70);
    fill(255);
    noStroke();
    rect(1210, 640, 200, 70);
  }

  void nez () {                     // le nez du chat(qui ne sera pas présent partout)
    fill(255, 142, 208);
    noStroke();
    ellipse(950, 630, 40, 40);
  }
  void neutre() {                    // le chat quand il n'y a pas d'interaction
    c.base();
    fill(0);
    noStroke();
    rect(840, 500, 40, 100);

    fill(0);
    noStroke();
    rect(1020, 500, 40, 100);

    c.nez();
  }

  void choc() {                      // le chat quand il est secoué

    c.base();
    fill(255);
    ellipse(1050, 555, 120, 120);

    fill(255);
    ellipse(850, 555, 120, 120);

    fill(0);
    noStroke();
    ellipse(850, 550, 30, 40);

    fill(0);
    noStroke();
    ellipse(1050, 550, 30, 40);

    fill(108);
    noStroke();
    beginShape();
    vertex (950, 670);
    vertex (950, 670);
    vertex (1000, 740);
    vertex (900, 740);
    endShape(); 

    c.nez();
  }

  void triste() {    // le chat triste quand on le tape
    c.base();
    fill(108);
    noStroke();
    beginShape();
    vertex (950, 670);
    vertex (950, 670);
    vertex (1000, 740);
    vertex (900, 740);
    endShape(); 

    fill(108);
    noStroke();
    beginShape();
    vertex (1080, 500);
    vertex (990, 550);
    vertex (1080, 600);
    vertex (1130, 590);
    vertex (1030, 550);
    vertex (1130, 500);
    endShape(); 

    fill(108);
    noStroke();
    beginShape();
    vertex (830, 500);
    vertex (930, 550);
    vertex (830, 600);
    vertex (780, 590);
    vertex (880, 550);
    vertex (780, 500);
    endShape(); 

    fill(64, 190, 255);
    noStroke();
    ellipse(1075, 640, 40, 60);
  }

  void drawx(float x, float y) {     // construction des yeux en X
    pushMatrix();
    translate(x, y);
    int v = 100;
    int h = 100;
    int e_v = 30;
    int e_h = 42;

    fill(108);
    beginShape();
    vertex(e_h/2, 0);
    vertex(h, v);
    vertex(h - e_h, v);
    vertex(0, e_v);

    vertex(-h + e_h, v);
    vertex(-h, v);
    vertex(-e_h/2, 0);

    vertex(-h, -v);
    vertex(-h + e_h, -v);
    vertex(0, -e_v);

    vertex(h-e_h, -v);
    vertex(h, -v);
    endShape(CLOSE);
    popMatrix();
  }
  void dead() {     // le chat mort après avoir été trop secoué
    c.base();
    c.nez();
    c.drawx(840, 500);
    c.drawx(1060, 500);
  }

  void dort() {     // chat qui dort si inactivité ou si plongé dans le noir
    c.base();
    fill(108);
    rect(770, 550, 150, 20);
    rect(980, 550, 150, 20);
    c.nez();
    fill(240);
    text("z", 1400, 200);
    text("z", 1250, 250);
    text("z", 1550, 150);
  }

  void vomir() {                // chat vomit si on le secoue trop
    c.base();
    c.nez();
    c.drawx(840, 500);
    c.drawx(1060, 500);

    noFill();
    stroke(0);
    strokeWeight(12);
    ellipse(955, 740, 350, 100);

    fill(255, 232, 113);
    noStroke();
    rect(830, 720, 250, 400);

    fill(255, 232, 113);
    ellipse(955, 715, 250, 50);
  }

  void dab() {                        // lunette apparaisse si on dabe
    c.base();
    lunette.resize(600, 300);
    image(lunette, 655, 400);
    c.nez();

    fill(108);
    rect(850, 700, 200, 6);
  }

  void peur() {                      //selfie
    c.base();
    fill(255);
    strokeWeight(8);
    ellipse(1050, 555, 120, 150);

    fill(255);
    ellipse(850, 555, 120, 150);

    fill(108);
    beginShape();
    vertex (950, 650);
    vertex (950, 650);
    vertex (1000, 740);
    vertex (900, 740);
    endShape();

    fill(64, 190, 255);
    noStroke();
    beginShape();
    vertex (1150, 350);
    vertex (1150, 350);
    vertex (1130, 392);
    vertex (1170, 392);
    endShape();

    fill(64, 190, 255);
    noStroke();
    ellipse(1150, 400, 40, 60);

    c.nez();
  }

  void amour() {                    //selfie
    c.base();
    fill(255, 0, 38);
    noStroke();
    beginShape();
    vertex (780, 450);
    vertex (850, 600);
    vertex (920, 450);
    vertex (850, 480);
    endShape();

    fill(255, 0, 38);
    noStroke();
    beginShape();
    vertex (980, 450);
    vertex (1050, 600);
    vertex (1120, 450);
    vertex (1050, 480);
    endShape();

    c.nez();

    fill(100);
    noStroke();
    arc(900, 670, 100, 100, 0, PI+QUARTER_PI, CHORD);
  }
  void nyan() { 
    c.base();
    fill(108);
    noStroke();
    rect(840, 500, 40, 100);
    rect(1020, 500, 40, 100);

    noFill();
    stroke(108);
    strokeWeight(6);
    arc(900, 670, 100, 100, 0, PI);
    arc(1000, 670, 100, 100, 0, PI);

    fill(#FF89D0);
    noStroke();
    ellipse(800, 630, 70, 30);
    fill(#FF89D0);
    noStroke();
    ellipse(1100, 630, 70, 30);

    c.nez();// donne trop à manger, se transforme en nyan cat
  }
  void potter() {
    c.base();
    fill(255);
    stroke(0);
    strokeWeight(8);
    ellipse(1050, 555, 120, 120);

    fill(255);
    stroke(0);
    ellipse(850, 555, 120, 120);

    fill(0);
    noStroke();
    rect(900, 550, 100, 8);

    c.nez();

    fill(0);
    noStroke();
    rect(910, 340, 10, 60);
    rect(850, 390, 60, 10);

    fill(0);
    noStroke();
    beginShape();
    vertex (850, 400);
    vertex (890, 470);
    vertex (870, 400);
    endShape();
  }
  void colere() {                                       // le chat se met en colère, spam un bouton 
    c.base();
    noFill();
    stroke(108);
    strokeWeight(8);
    line(770, 480, 920, 530);
    line(980, 530, 1140, 480); 
    c.nez();

    fill(108);
    stroke(108);
    strokeWeight(4);
    arc(900, 520, 50, 130, 0, PI);
    arc(1000, 520, 50, 130, 0, PI);
  }
  void vicieux() {
    c.base();
    fill(108);
    noStroke();
    rect(780, 520, 130, 10);
    rect(1010, 520, 130, 10);

    fill(108);
    stroke(108);
    strokeWeight(8);
    arc(875, 525, 60, 90, 0, PI);
    arc(1105, 525, 60, 90, 0, PI);

    c.nez();

    noFill();
    stroke(108);
    strokeWeight(8);
    arc(980, 705, 130, 80, 0, PI);
  }
  void rire() {
    c.base();
    fill(108);
    noStroke();
    beginShape();
    vertex (1080, 500);
    vertex (990, 550);
    vertex (1080, 600);
    vertex (1130, 590);
    vertex (1030, 550);
    vertex (1130, 500);
    endShape(); 

    fill(108);
    noStroke();
    beginShape();
    vertex (830, 500);
    vertex (930, 550);
    vertex (830, 600);
    vertex (780, 590);
    vertex (880, 550);
    vertex (780, 500);
    endShape(); 

    pushMatrix();
    rotate(-40);
    fill(64, 190, 255);
    noStroke();
    ellipse(-980, 140, 50, 80);
    popMatrix();
    pushMatrix();
    rotate(40);
    fill(64, 190, 255);
    noStroke();
    ellipse(-290, -1270, 50, 80);
    popMatrix();
    fill(108);
    noStroke();
    arc(950, 630, 250, 250, 0, PI, CHORD);
  }
  void joie() {                       //remet de la lumière
    c.base();

    fill(108);
    noStroke();
    rect(840, 500, 40, 100);
    rect(1020, 500, 40, 100);

    noFill();
    stroke(108);
    strokeWeight(6);
    arc(900, 670, 100, 100, 0, PI);
    arc(1000, 670, 100, 100, 0, PI);
  }
  void dog() {                          //appuie sur image de chien, se transforme en chien
    fill(206);
    noStroke();
    rect(710, 340, 500, 500);

    fill(206);
    noStroke();
    rect(410, 540, 300, 70);
    fill(255);
    rect(510, 640, 200, 70);
    rect (640, 470, 70, 70);


    fill(206);
    noStroke();
    rect(1210, 540, 300, 70);
    fill(255);
    noStroke();
    rect (1210, 470, 70, 70);
    fill(255);
    noStroke();
    rect(1210, 640, 200, 70);

    fill(206);
    rect(710, 200, 190, 200);
    rect(1020, 200, 190, 200);

    c.nez();

    fill(108);
    noStroke();
    rect(840, 500, 40, 100);
    rect(1020, 500, 40, 100);

    rect(900, 685, 110, 10);
    arc(955, 690, 70, 160, 0, PI);

    fill(255);
    beginShape();
    vertex(710, 200);
    vertex(900, 200);
    vertex(900, 200);
    vertex(800, 300);
    endShape();

    fill(255);
    beginShape();
    vertex(1020, 200);
    vertex(1210, 200);
    vertex(1210, 200);
    vertex(1110, 300);
    endShape();
  }
  void france() {
    c.base();
    fill(108);
    noStroke();
    rect(840, 500, 40, 100);

    fill(108);
    noStroke();
    rect(1020, 500, 40, 100);

    c.nez();

    noFill();
    stroke(108);
    strokeWeight(6);
    arc(865, 650, 150, 100, 0, PI);
    arc(1035, 650, 150, 100, 0, PI);



    baguette.resize(700, 700);
    image(baguette, 810, 350);

    beret.resize(700, 700);
     image(beret, 500, -50);
  }
  void ennui() {                      // si on n'a pas d'interaction, s'ennuie
    c.base();
    fill(108);
    noStroke();
    rect(780, 520, 130, 10);
    rect(1010, 520, 130, 10);

    fill(108);
    strokeWeight(8);
    arc(850, 525, 60, 90, 0, PI);
    arc(1080, 525, 60, 90, 0, PI);
    c.nez();
    fill(108);
    rect(860, 720, 200, 5);
  }
  void etourdi() {                      // si on secoue le telephone, le chat a le tourni
    pushMatrix();
    translate(width/2, height/4);
    for (int i=0; i < 5; i++) {
      rotate((i/5)*TWO_PI  +millis()/1000.);
      stroke(155);
      strokeWeight(3);
      noFill();
      ellipse(0, 0, 300, 100 );
     // noLoop();
    }
    popMatrix();

    noFill();
    stroke(108);
    strokeWeight(4);
    circle(830, 520, 150);
    circle(1080, 520, 150);

    noStroke();
    fill(108);
    rect(730, 510, 200, 5);
    rect(980, 510, 200, 5);
    c.nez();
    fill(108);
    arc(820, 510, 50, 45, 0, PI);
    arc(1080, 510, 50, 45, 0, PI);
    
    //noLoop();
  }
}
