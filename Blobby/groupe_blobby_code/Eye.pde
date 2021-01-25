class Eye {
  float x, y;
  float s;

  //Position des pupilles
  float pupX = 0;
  float pupY = 0;
  float tPupX, tPupY;


  Eye (float tx, float ty, float ts) {
    x = tx;
    y = ty;
    s = ts;
  }

  void update (float mx, float my) { 
    //newAngle = atan2 (my-y, mx-x);
    tPupX = mx;
    tPupY =my;
  } 

  void display() { 
    //push();
    pushMatrix();
    translate(x, y);
    //println(t);
    fill(255);
    ellipse(0, 0, s/2, s/2);
    pupX = lerp(pupX, tPupX, easing);
    pupY = lerp(pupY, tPupY, easing);

    fill(0);
    ellipse(pupX/2, pupY/2, s/3.4, s/3.4);
    fill(255);
    ellipse((pupX+(s/20))/2, (pupY-(s/20))/2, s/14, s/14);
    popMatrix();
    // pop();

    t += 1;
    //Choix aléatoire du mouveent des pupilles
    if (t > 200) {
      float newX = random(-s/5.5, s/5.5);
      float newY = random(-s/5.5, s/5.5);
      // int pos_x = int(random(0, width));
      //int pos_y = int(random(0, height));
      float louching = random(1);
      if (louching < 0.80) {
        update(newX, newY);
        update (newX, newY);
      } else if (louching > 0.9 && louching < 1) {
        update(newX, newY);
        update (-newX, newY);
      } 
      t = 0;
    }
  }
}
