ArrayList<PVector> chaoticPoints(float x1, float y1, float x2, float y2, float chaos) {
  ArrayList<PVector> ptlist = new ArrayList<PVector>();  
  float d_x = x2-x1;
  float d_y = y2-y1;
  float mag = sqrt(d_x*d_x + d_y*d_y);
  if (mag > 10) {
    float ch = randomGaussian()*chaos/2.0;  // randomGaussian seems to give a better result but is a bit slower
    //float ch = random(-chaos, chaos);

    // Prendre un point au hasard sur la ligne perpendiculaire pour créer un segment et 
    // passant par le milieu de segment 
    float xc = ((x1+x2)/2) - d_y*ch;
    float yc = ((y1+y2)/2) + d_x*ch;
    ptlist.addAll(chaoticPoints(x1, y1, xc, yc, chaos));
    ptlist.addAll(chaoticPoints(xc, yc, x2, y2, chaos));
    return ptlist;
  } else {
    line(x1, y1, x2, y2);
    ptlist.add(new PVector(x1, y1));
    return ptlist;
  }
}
//Dessiner des lignes approximatives
void drawChaoticLine(ArrayList<PVector> points) {
  for (int i=0; i<points.size()-1; i++) {
    PVector p1 = points.get(i);
    PVector p2 = points.get(i+1);
    line(p1.x, p1.y, p2.x, p2.y);
  }
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  chaos += e/10.0;
}
