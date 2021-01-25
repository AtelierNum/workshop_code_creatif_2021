void program() {


  //Faire avancer la chanson. On draw() pour chaque "frame" de la chanson...
  fft.forward(out.mix);

  //Calcul des "scores" (puissance) pour trois catÃ©gories de son : les sons bas, les sons moyens et les gros sons
  //D'abord, sauvgarder les anciennes valeurs
  oldScoreLow = scoreLow;
  oldScoreMid = scoreMid;
  oldScoreHi = scoreHi;

  //Reinitialiser les valeurs
  scoreLow = 0;
  scoreMid = 0;
  scoreHi = 0;

  //Calculer les nouvelles valeurs 
  for (int i = 0; i < fft.specSize()*specLow; i++)
  {
    scoreLow += fft.getBand(i);
  }

  for (int i = (int)(fft.specSize()*specLow); i < fft.specSize()*specMid; i++)
  {
    scoreMid += fft.getBand(i);
  }

  for (int i = (int)(fft.specSize()*specMid); i < fft.specSize()*specHi; i++)
  {
    scoreHi += fft.getBand(i);
  }

  //Faire ralentir la descente.
  if (oldScoreLow > scoreLow) {
    scoreLow = oldScoreLow - scoreDecreaseRate;
  }

  if (oldScoreMid > scoreMid) {
    scoreMid = oldScoreMid - scoreDecreaseRate;
  }

  if (oldScoreHi > scoreHi) {
    scoreHi = oldScoreHi - scoreDecreaseRate;
  }

  //Volume pour toutes les frequences, avec les sons plus haut plus importants.
  //Cela permet Ã  l'animation d'aller plus vite pour les sons plus aigus
  float scoreGlobal = 0.66*scoreLow + 0.8*scoreMid + 1*scoreHi;

  //Couleur subtile de background
  background(scoreLow/100, scoreMid/100, scoreHi/100);

  //Mise Ã  jours du placement des Ã©toiles 
  for (int i = 0; i < stars.length; i++) {
    stars[i].update();
    stars[i].show();
  }

  //Cube pour chaque bande de frequence
  for (int i = 0; i < nbCubes; i++)
  {
    //Valeur de la bande de frequence
    float bandValue = fft.getBand(i);
    //print(bandValue + "  ");

    //La couleur est representee ainsi: rouge pour les basses, vert pour les sons moyens et bleu pour les hautes. 
    //L'opacite est determinee par le volume de la bande et le volume global.
    cubes[i].display(scoreLow, scoreMid, scoreHi, bandValue, scoreGlobal);
  }

  //Ici il faut garder la valeur de la bande precedente et la suivante pour les connecter ensemble
  float previousBandValue = fft.getBand(0);

  //Distance entre chaque point de ligne, negatif car sur la dimension z
  float dist = -25;

  //Multiplier la hauteur par cette constante
  float heightMult = 2;

  //on joue le void "leapmo"  contenu dans l'onglet leap
  leapmo();
}

//Classe pour les cubes qui flottent dans l'espace
class Cube {
  //Position Z d'apparition et position Z maximale
  float startingZ = -10000;
  float maxZ = 1000;

  //Valeurs de positions
  float x, y, z;
  float rotX, rotY, rotZ;
  float sumRotX, sumRotY, sumRotZ;

  //Constructeur
  Cube() {
    //Faire apparaitre le cube Ã  un endroit aleatoire
    if (random(100) > 50) {
      x = random(0, width * 0.45);
    } else {
      x = random(width * 0.6, width);
    }
    y = random(0, height);
    z = random(startingZ, maxZ);

    //Donner au cube une rotation alÃ©atoire
    rotX = random(0, 1);
    rotY = random(0, 1);
    rotZ = random(0, 1);
  }

  void display(float scoreLow, float scoreMid, float scoreHi, float intensity, float scoreGlobal) {
    //Selection de la couleur, opacite determinee par l'intensite (volume de la bande)
    float opacite = map(intensity, 1, 10, 100, 150);
    color displayColor = color(scoreLow*3, scoreMid*3, scoreHi*3, opacite);
    fill(displayColor, 255);

    //Couleur lignes, elles disparaissent avec l'intensite individuelle du cube
    color strokeColor = color(255, 150-(50*intensity));
    stroke(strokeColor);
    strokeWeight(1 + (scoreGlobal/300));

    //Creation d'une matrice de transformation pour effectuer des rotations, agrandissements
    pushMatrix();

    //Deplacement
    translate(x, y, z);

    //Calcul de la rotation en fonction de l'intensite du son pour le cube
    sumRotX += intensity*(rotX/100);
    sumRotY += intensity*(rotY/100);
    sumRotZ += intensity*(rotZ/100);

    //Application de la rotation
    rotateX(sumRotX);
    rotateY(sumRotY);
    rotateZ(sumRotZ);

    //Creation de la boite, taille variable en fonction de l'intensite pour le cube
    box(100+(intensity/2));

    //Application de la matrice
    popMatrix();

    //Déplacement Z
    float zmod = (10 + map(intensity, 0, 2, 0, 16) +(pow((scoreGlobal/30), 2)));
    z+= zmod;
    //println("zmod : " + zmod + "  / intens " + intensity + "  / scoreg " + scoreGlobal + "   / déplacement en z : " + z);

    //Replacer la boite a  l'arriere lorsqu'elle n'est plus visible
    if (z >= maxZ) {
      if (random(100) > 50) {
        x = random(0, width * 0.45);
      } else {
        x = random(width * 0.6, width);
      }
      y = random(0, height);
      z = startingZ;
    }
  }
}


//Classe pour afficher les lignes sur les cotes
class Mur {
  //Position minimale et maximale Z
  float startingZ = -10000;
  float maxZ = 50;

  //Valeurs de position
  float x, y, z;
  float sizeX, sizeY;

  //Constructeur
  Mur(float x, float y, float sizeX, float sizeY) {
    //Faire apparaitre la ligne Ã  l'endroit specifie
    this.x = x;
    this.y = y;
    //Profondeur aleatoire
    this.z = random(startingZ, maxZ);  

    //determination de la taille
    this.sizeX = sizeX;
    this.sizeY = sizeY;
  }

  //Fonction d'affichage
  void display(float scoreLow, float scoreMid, float scoreHi, float intensity, float scoreGlobal) {
    //Couleur determine par les sons bas, moyens et eleve
    //Opacite determine par le volume global
    color displayColor = color(scoreLow*10, scoreMid*10, scoreHi*10, scoreGlobal);

    //Premiere bande, celle qui bouge en fonction de la force
    //Matrice de transformation
    pushMatrix();

    //DÃ©placement
    translate(x, y, z);

    //Agrandissement
    if (intensity > 100) intensity = 100;
    scale(sizeX*(intensity/100), sizeY*(intensity/100), 20);

    //Creation de la "boite"
    box(1);
    popMatrix();

    //Deuxieme bande, celle qui est toujours de la meme taille
    displayColor = color(scoreLow*0.5, scoreMid*0.5, scoreHi*0.5, scoreGlobal);
    fill(displayColor, (scoreGlobal/5000)*(255+(z/25)));
    //Matrice de transformation
    pushMatrix();

    //Deplacement
    translate(x, y, z);

    //Agrandissement
    scale(sizeX, sizeY, 10);

    //Creation de la "boite"
    box(1);
    popMatrix();

    //Deplacement Z
    z+= (pow((scoreGlobal/150), 2));
    if (z >= maxZ) {
      z = startingZ;
    }
  }
}
