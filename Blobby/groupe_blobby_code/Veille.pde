class Veille {
//Ecran de veille
  void afficher() {
    fill(0, 0, 0, 180);
    rect(0, 0, width, height);

    fill (255, 127, 172);
    textFont(title, 200);
    textAlign(CENTER);
    text("Blobby", width/2, height/2); 
    textSize(120);

    fill(255);
    textAlign(CENTER);
    textFont(undertitle, 50);
    text("Pars à la course au bonheur", width/2, height/1.75); 
    textSize(40);
  }
}
