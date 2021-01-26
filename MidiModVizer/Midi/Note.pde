
/*
    Authored by Thomas Castleman, 2018
*/

// Note class handles attributes that all played notes share
class Note {
  
  int channel, velocity, pitch;   // store the channel, velocity and pitch
  int lifespan;                   // lifespan of note, in frames
  boolean isReleased;             // whether or not the note has been released yet
  float x, y;
  float size;
  color col;




  // constructor for new Note object
  Note(int channel_, int pitch_, int velocity_) {
    this.channel = channel_;
    this.pitch = pitch_;
    this.velocity = velocity_;
    this.lifespan = 7;                  // temps que reste une note
    this.isReleased = true;
    
    this.x = map(pitch, 20, 70, 0, width);  // placer les notes en fonction de leurs pitch 
    this.y = height / 2 + (channel * 20);   // placer les notes en fonction de leurs channel midi
    
    this.size = map(velocity * velocity / 100 , 0, 127, 5, 100);  //changer la taille des notes en fonction de leurs vélocité
    
    this.col = color(pitch*2+20,0,channel*10+20);
  }
  
  // update note properties
  void update() {

  }
  
  // display note on canvas
  void display() {
    strokeWeight(0);
    fill(this.col);
    ellipse(this.x, this.y, this.size, this.size);

  }

}
