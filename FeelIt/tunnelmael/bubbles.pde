class Confetti {
  // Introduir les variables 
  private float rotY;
  private float rotZ;
  private float radius;
  private float tempRadius;
  private color col;
  private float finalZ;
  private float tempZ = 0;
  
  //Paramètres des confettis : rotation et couleur
  Confetti() {
    rotY = random(TWO_PI);
    rotZ = random(-PI, PI);
    radius = pow(random(8000000), .3333);
    tempRadius = 0;
    col = color(#F29420);
    finalZ = random(-1000, 1000);
  }
  
  void run() {
    update();
    display();
  }
  
  void update() {
    if(state == 0) {
      tempRadius = 0;
      tempZ = 0;
    }
    if(state > 0) {
      if(tempRadius< radius-0.1) {
        tempRadius += ((radius-tempRadius)/10);
      }else{
        tempRadius = radius;
      }
      
    }
    if(state > 1) {
      if(tempZ < finalZ-0.1 || tempZ > finalZ+0.1) {
        tempZ += ((finalZ-tempZ)/50);
      }else{
        tempZ = finalZ;
      }
    }
  }
  //Position de l'état
  void display() {
    pushMatrix();
    
    if(state == 2) {
      translate(0,tempZ,0);
    }
    rotateY(rotY);
    rotateZ(rotZ);
    translate(tempRadius,0,0);
    
    rotateY(HALF_PI);
    rotateX(tempRadius/10f);
    rotateY(tempRadius/10f);
    rotateZ(tempRadius/10f);
    scale(0.1+tempRadius/radius);
    
    fill(#F29420);
    //box(10);
    rect(-5,-5,10,10);
    popMatrix();
  }
}
