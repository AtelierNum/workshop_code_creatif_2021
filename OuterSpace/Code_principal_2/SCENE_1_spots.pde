//class pour créer une météorite

class Spot {
 
  //les paramètres généraux d'une météorites
  float x, y;        
  float diameter;
  float speed;       
  int direction = 1;  
  

  Spot(float xpos, float ypos, float dia, float sp) {
    x = xpos;
    y = ypos;
    diameter = dia;
    speed = sp;
  }
    
  //pour gérer la direction des météorites
  
  void move() {
    y += (speed * direction); 
    if ((y > (height - diameter/1)) || (y < diameter/1)) { 
      direction *= 1; 
    } 
    x += (speed * direction); 
    if ((y > (height - diameter/0.5)) || (y < diameter/1)) { 
      direction *= 1; 
    }
  }
  
  void display() {
    ellipse(x, y, diameter, diameter);
  }
}
