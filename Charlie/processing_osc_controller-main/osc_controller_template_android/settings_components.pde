//Textfield iptext;
//Textfield porttext;

void create_settings() {


  Controller c = new NumberField(width*0.25, height*.25, width*.5, eltHeight, "Ip adress");
  c.moveTo(0);
  g.addController(c);
  c.register(new CallBackHandler(c) {
    public void onEvent() {
      if (c.getClass().getSimpleName().contains("NumberField")) {
        NumberField nf = (NumberField) c;
        ip = nf.content;
        //println(nf.label, nf.content);
      }
    }
  }
  );


  c = new NumberField(width*0.25, height*.5, width*.5, eltHeight, "Port number");
  c.moveTo(0);
  g.addController(c);
  c.register(new CallBackHandler(c) {
    public void onEvent() {
      if (c.getClass().getSimpleName().contains("NumberField")) {
        NumberField nf = (NumberField) c;
        port = int(nf.content);
        //println(nf.label, nf.content);
      }
    }
  }
  );


  c= new Button(width*0.25, height*.75, width*.5, eltHeight, "Connect");
  c.moveTo(0);
  g.addController(c);
  c.register(new CallBackHandler(c) {
    public void onEvent() {
      myRemoteLocation = new NetAddress(ip, port);
      println(ip, port, "connecting to new remote location ...");
      //println(c.label, c.value);
    }
  }
  );
}

// callbacks
/*
public void ip(String _ip) {
 ip =_ip;
 }
 
 public void port(String _port) {
 port =int(_port);
 }
 
 public void CONNECT() {
 myRemoteLocation = new NetAddress(ip, port);
 println(ip, port, "connecting to new remote location ...");
 }*/
