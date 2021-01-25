void initialisation() {
  
  
  //Creation des etoiles sur le background 
  for (int i = 0; i < stars.length; i++) { 
    stars[i] = new Star();
  }

  //Creer l'objet FFT pour analyser la chanson




  filePlayer = new FilePlayer( minim.loadFileStream(fileName) );

  //utile a l'initialisation. Permet ensuite de recuperer les datas sur le son et de les modifier
  rateControl = new TickRate(1.f);
  moog    = new MoogFilter( 1200, 0.5 );
  gain = new Gain(0.f);
  out = minim.getLineOut();
  hpf = new HighPassSP(1000, out.sampleRate());
  filePlayer.patch(rateControl).patch(moog).patch(gain).patch( hpf ).patch(out);

  fft = new FFT(out.bufferSize(), filePlayer.sampleRate());

  //leapmotion
  leap = new LeapMotion(this);

  test = 0;
  test1 = 0;

  //Un cube par bande de frequence
  nbCubes = (int)(fft.specSize()*specHi);
  cubes = new Cube[nbCubes];

  //Creer  les objets
  //Creer les objets cubes
  for (int i = 0; i < nbCubes; i++) {
    cubes[i] = new Cube();
  }



}
