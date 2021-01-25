void parse_patch(String[] lines, int tab) {
  for (int i = 0; i < lines.length; i++) {

    String[] s = split(lines[i], " ");
    //if (s.length>4) println(i, s[4], s.length);

    ///////////////////////////////////////////////////////////////////
    // check for horizontal sliders
    if (s.length>10 && s[1].contains("obj") && s[4].contains("hsl")) {
      float x = map(int(s[2]), 0, patchWidth, 0, width);
      float y = map(int(s[3]), 0, patchHeight, 0, height);
      float w = map(int(s[5]), 0, patchWidth, 0, width);
      float h = map(int(s[6]), 0, patchHeight, 0, height);

      Controller c = new HSlider(x, y, w, h, s[13], float(s[7]), float(s[8]));
      c.moveTo(tab);
      g.addController(c);
      c.register(new CallBackHandler(c) {
        public void onEvent() {
          sendFloatMessage("/"+c.label, c.value);
          //println(c.label, c.value);
        }
      }
      );
    }

    ///////////////////////////////////////////////////////////////////
    // check for vertical sliders
    if (s.length>10 && s[1].contains("obj") && s[4].contains("vsl")) {
      float x = map(int(s[2]), 0, patchWidth, 0, width);
      float y = map(int(s[3]), 0, patchHeight, 0, height);
      float w = map(int(s[5]), 0, patchWidth, 0, width);
      float h = map(int(s[6]), 0, patchHeight, 0, height);
      Controller c = new VSlider(x, y, w, h, s[13], float(s[7]), float(s[8]));
      c.moveTo(tab);
      g.addController(c);
      c.register(new CallBackHandler(c) {
        public void onEvent() {
          sendFloatMessage("/"+c.label, c.value);
          //println(c.label, c.value);
        }
      }
      );
    }

    ///////////////////////////////////////////////////////////////////
    // check buttons
    if (s.length>10 && s[1].contains("obj") && s[4].contains("bng")) {
      float x = map(int(s[2]), 0, patchWidth, 0, width);
      float y = map(int(s[3]), 0, patchHeight, 0, height);
      float w = map(int(s[5]), 0, patchWidth, 0, width);
      float h = map(int(s[7]), 0, patchHeight, 0, height);

      if (s[11].contains("caresse")) {
        Controller c= new ButtonCaresse(x, y, w, w, s[11]);
        c.moveTo(tab);
        g.addController(c);
        c.register(new CallBackHandler(c) {
          public void onEvent() {
            sendFloatMessage("/"+c.label, c.value);
          }
        }
        );
      }
      
       else if (s[11].contains("nourrir")) {
        Controller c= new ButtonNourrir(x, y, w, w, s[11]);
        c.moveTo(tab);
        g.addController(c);
        c.register(new CallBackHandler(c) {
          public void onEvent() {
            sendFloatMessage("/"+c.label, c.value);
          }
        }
        );
      } 
      
      else if (s[11].contains("chien")) {
        Controller c= new ButtonChien(x, y, w, w, s[11]);
        c.moveTo(tab);
        g.addController(c);
        c.register(new CallBackHandler(c) {
          public void onEvent() {
            sendFloatMessage("/"+c.label, c.value);
          }
        }
        );
      } 
      
      else if (s[11].contains("selfie")) {
        Controller c= new ButtonSelfie(x, y, w, w, s[11]);
        c.moveTo(tab);
        g.addController(c);
        c.register(new CallBackHandler(c) {
          public void onEvent() {
            sendFloatMessage("/"+c.label, c.value);
          }
        }
        );
      } 
      
      else if (s[11].contains("baguette")) {
        Controller c= new ButtonBaguette(x, y, w, w, s[11]);
        c.moveTo(tab);
        g.addController(c);
        c.register(new CallBackHandler(c) {
          public void onEvent() {
            sendFloatMessage("/"+c.label, c.value);
          }
        }
        );
      } 
      
      else {

        Controller c= new Button(x, y, w, h, s[11]);
        c.moveTo(tab);
        g.addController(c);
        c.register(new CallBackHandler(c) {
          public void onEvent() {
            sendFloatMessage("/"+c.label, c.value);
          }
        }
        );
      }
    }


    ///////////////////////////////////////////////////////////////////
    // check toggle
    if (s.length>10 && s[1].contains("obj") && s[4].contains("tgl")) {
      float x = map(int(s[2]), 0, patchWidth, 0, width);
      float y = map(int(s[3]), 0, patchHeight, 0, height);
      float w = map(int(s[5]), 0, patchWidth, 0, width);
      float h = map(int(s[5]), 0, patchHeight, 0, height);

      Controller c = new Toggle(x, y, w, h, s[9]);
      c.moveTo(tab);
      g.addController(c);
      c.register(new CallBackHandler(c) {
        public void onEvent() {
          sendFloatMessage("/"+ c.label, c.value);
          // println(c.label, c.value);
        }
      }
      );
    }

    ///////////////////////////////////////////////////////////////////
    // check for numbers 
    if (s.length>10 && s[1].contains("obj") && s[4].contains("nbx")) {
      float x = map(int(s[2]), 0, patchWidth, 0, width);
      float y = map(int(s[3]), 0, patchHeight, 0, height);
      float w = map(int(s[5])*fontSize*0.5, 0, patchWidth, 0, width); // pd uses a weird unit as width (eg characterd width)
      float h = map(int(s[6]), 0, patchHeight, 0, height);

      Controller c = new NumberField(x, y, w, h, s[13]);
      c.moveTo(tab);
      g.addController(c);
      c.register(new CallBackHandler(c) {
        public void onEvent() {
          if (c.getClass().getSimpleName().contains("NumberField")) {
            NumberField nf = (NumberField) c;
            sendFloatMessage("/" + nf.label, float(nf.content));
            //println(nf.label, nf.content);
          }
        }
      }
      );
    }


    //////////////////////////////////////////////////////////////////////////
    // check for touch surface eg  canvas with receive value set to "touch" 
    if (s.length>10 && s[1].contains("obj") && s[4].contains("cnv") && s[9].contains("touch")) {
      float x = map(int(s[2]), 0, patchWidth, 0, width);
      float y = map(int(s[3]), 0, patchHeight, 0, height);
      float w = map(int(s[6]), 0, patchWidth, 0, width); 
      float h = map(int(s[7]), 0, patchHeight, 0, height);

      Controller c = new Pad(x, y, w, h, s[10], 0, 127);
      c.moveTo(tab);
      g.addController(c);
      c.register(new CallBackHandler(c) {
        public void onEvent() {
          if (c.getClass().getSimpleName().contains("Pad")) {
            Pad p = (Pad) c;
            float[] a = {p.xvalue, p.yvalue};
            sendArrayMessage("/"+p.label, a);
            // println(p.label, p.xvalue, p.yvalue);
          }
        }
      }
      );
    }

    //////////////////////////////////////////////////////////////////////////////////////
    // check for color selector surface eg  canvas with receive value set to "color" 
    if (s.length>10 && s[1].contains("obj") && s[4].contains("cnv") && s[9].contains("color")) {
      float x = map(int(s[2]), 0, patchWidth, 0, width);
      float y = map(int(s[3]), 0, patchHeight, 0, height);
      float w = map(int(s[6]), 0, patchWidth, 0, width);
      float h = map(int(s[7]), 0, patchHeight, 0, height);

      Controller c =new ColorSelector(x, y, w, h, s[10]);
      c.moveTo(tab);
      g.addController(c);
      c.register(new CallBackHandler(c) {
        public void onEvent() {
          if (c.getClass().getSimpleName().contains("ColorSelector")) {
            ColorSelector cs = (ColorSelector) c;
            sendColorMessage("/" + cs.label, color(cs.r, cs.g, cs.b));
            //println(cs.label, cs.r, cs.g, cs.b);
          }
        }
      }
      );
    }


    //////////////////////////////////////////////////////////////////////////////////////
    // check for text
    if (s.length>3 && s[1].contains("text") ) {
      float x = map(int(s[2]), 0, patchWidth, 0, width);
      float y = map(int(s[3]), 0, patchHeight, 0, height);
      String t =" " ;
      for (int j = 4; j < s.length; j++) { 
        if (s[j].charAt(s[j].length()-1) == ';' ) {
          s[j] =  s[j].substring(0, s[j].length() - 1);
        }
        t += s[j] + " " ;
      }

      Controller c =new TextLabel(x, y, t, cCaption);
      c.moveTo(tab);
      g.addController(c);
    }


    ///////////////////////////////////////////////////////////////////
    // check for horizontal radio button
    if (s.length>10 && s[1].contains("obj") && s[4].contains("hradio")) {
      float x = map(int(s[2]), 0, patchWidth, 0, width);
      float y = map(int(s[3]), 0, patchHeight, 0, height);
      float w = map(int(s[5]), 0, patchWidth, 0, width);
      float h = map(int(s[5]), 0, patchHeight, 0, height);

      Controller c = new HRadio(x, y, w*int(s[8]), h, s[11], int(s[8]));
      c.moveTo(tab);
      g.addController(c);
      c.register(new CallBackHandler(c) {
        public void onEvent() {
          sendFloatMessage("/" + c.label, c.value);
          //println(c.label, c.value);
        }
      }
      );
    }


    ///////////////////////////////////////////////////////////////////
    // check for horizontal radio button
    if (s.length>10 && s[1].contains("obj") && s[4].contains("vradio")) {
      float x = map(int(s[2]), 0, patchWidth, 0, width);
      float y = map(int(s[3]), 0, patchHeight, 0, height);
      float w = map(int(s[5]), 0, patchWidth, 0, width);
      float h = map(int(s[5]), 0, patchHeight, 0, height);

      Controller c = new VRadio(x, y, w, h*int(s[8]), s[11], int(s[8]));
      c.moveTo(tab);
      g.addController(c);
      c.register(new CallBackHandler(c) {
        public void onEvent() {
          sendFloatMessage("/" + c.label, c.value);
          //println(c.label, c.value);
        }
      }
      );
    }
  }
}
