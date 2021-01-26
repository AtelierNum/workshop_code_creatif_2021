void setup_galaxie() {

  ellipses=new ArrayList<Ellipse>();  //Initialiser la structure
  for (int i=0; i<max_ellipses; i++) {  //"Construite" les objets balle
    ellipses.add(new Ellipse());  //Appelle le constructeur de la classe
  }
}

void draw_galaxie() {
  //Parcourir la structure pour retirer les éléments 1 par 1
  for (int i=0; i<ellipses.size(); i++) {
    Ellipse b=ellipses.get(i);  //Récupérer l'objet
    b.deplacer();
    b.dessiner();
    b.dessiner2();
  }
}
