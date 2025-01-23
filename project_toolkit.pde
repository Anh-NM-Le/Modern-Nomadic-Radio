//import beads.*;
//import controlP5.*;

//NotificationServer server;
////Printer printer;
////Talker talker;
//boolean talking;
//AudioContext ac;
//ControlP5 p5;
//Gain masterGain;

//// This setup function demonstrates how you might initialize 
//// the NotificationServer and load JSON data. You should
//// create your own setup function for your own project, though.
////void setup() {
////  size(350, 360);
  
////  ac = new AudioContext();
////  p5 = new ControlP5(this);
////  masterGain = new Gain(ac, 1, 1.0);
////  ac.out.addInput(masterGain);
  
////  // Create and initialize the NotificationServer
////  server = new NotificationServer();
 
////  // This is an example of instantiating a custom class (seen below)
////  // and registering it as a listener to the server. 
////  talker = new Talker();
////  server.addListener(talker);
////  talking = true; // default to talk mode
  
////  // Printer is an alternative notification listener that just
////  // prints the notifications it receives
////  printer = new Printer();
  
////  // Switch between data streams
////  p5.addButton("Data1").setPosition(50, 50).setSize(100, 50);
////  p5.addButton("Data2").setPosition(50, 120).setSize(100, 50);
////  p5.addButton("Data3").setPosition(50, 190).setSize(100, 50);
////  p5.addButton("Data4").setPosition(50, 260).setSize(100, 50);
  
////  // Toggle which notification listener is active
////  p5.addButton("Toggle").setPosition(200, 50).setSize(100, 50).setLabel("Toggle Talk/Print");

////  // Demonstrate the play-multiple-sounds code
////  p5.addButton("PlayMultiple").setPosition(200, 120).setSize(100, 50);
  
////  ac.start();
////}

////// Examples of how to load a set of JSON-encoded notifications into
////// the NotificationServer. Note that the code here purges any
////// existing notifications before starting dispatch.
////void Data1() {
////  println("Data1");
////  server.purgeTasksAndCancel();
////  server.loadAndScheduleJSONData(loadJSONArray("ExampleData_1.json"));
////}

////void Data2() {
////  println("Data2");
////  server.purgeTasksAndCancel();
////  server.loadAndScheduleJSONData(loadJSONArray("ExampleData_2.json"));
////}

////void Data3() {
////  println("Data3");
////  server.purgeTasksAndCancel();
////  server.loadAndScheduleJSONData(loadJSONArray("ExampleData_3.json"));
////}

////void Data4() {
////  println("Data4");
////  server.purgeTasksAndCancel();
////  server.loadAndScheduleJSONData(loadJSONArray("ExampleData_4.json"));
////}

////// Toggle talking versus printing by adding/removing the appropriate
////// listener
////void Toggle() {
////  if (talking) {
////    server.removeListener(talker);
////    server.addListener(printer);
////  } else {
////    server.removeListener(printer);
////    server.addListener(talker);
////  }
////  talking = !talking;
////}

////// Demonstrate how to use the play multiple sounds code
////void PlayMultiple() {
////  soundsToPlay.add("one.wav");
////  soundsToPlay.add("meow.wav");
////  soundsToPlay.add("two.wav");
////  soundsToPlay.add("meow.wav");
////  soundsToPlay.add("three.wav");
////  soundsToPlay.add("meow.wav");
////  soundsToPlay.add("four.wav");
////  soundsToPlay.add("meow.wav");
////  soundsToPlay.add("five.wav");
////  soundsToPlay.add("meow.wav");

////  // See the "play multiple sounds" tab
////  PlaySounds();
////}


////void draw() {
////}

////// This is basically the simplest NotificationListener we can create;
////// it just prints out the notification as it comes in.
////class Printer implements NotificationListener {
////  public void notificationReceived(Notification notification) {
////    println(notification.getType().toString() + " notification received at " +
////            Integer.toString(notification.getTimestamp()) + " ms");
////    String debugOutput = ">>> ";
////    switch (notification.getType()) {
////      case Tweet:
////        debugOutput += "Tweet received: ";
////        break;
////      case PhoneCall:
////        debugOutput += "Phone call received: ";
////        break;
////      case VoiceMail:
////        debugOutput += "Voice mail received: ";
////        break;
////      case TextMessage:
////        debugOutput += "Text message received: ";
////        break;
////      case Email:
////        debugOutput += "Email received: ";
////        break;
////      default:
////        debugOutput += "WARNING: Unknown notification type";
////        break;
////    }
////    debugOutput += notification.toString();
    
////    println(debugOutput);
////  }
////}

////// This is an example of a slightly more complex notification
////// listener; this one speaks the notifications as they come in.
////class Talker implements NotificationListener {
////  // We'll use the SpeechWrapper code to speak the notifications  
////  SpeechWrapper wrapper;
  
////  public Talker() {
////    this.wrapper = new SpeechWrapper();
////  }
  
////  public void notificationReceived(Notification notification) { 
////    println("Notification received by Talker: " + notification.getType().toString());
    
////    String outputSpeech = "";
////    switch (notification.getType()) {
////      case Tweet:
////        outputSpeech += "New tweet from ";
////        break;
////      case Email:
////        outputSpeech += "New email from ";
////        break;
////      case VoiceMail:
////        outputSpeech += "New voicemail from ";
////        break;
////      case PhoneCall:
////        outputSpeech += "Phone call from ";
////        break;
////      case TextMessage:
////        outputSpeech += "New message from ";
////        break;
////    }
////    outputSpeech += notification.getSender() + ", " + notification.getMessage();
////    // This will queue each message to play as soon as the previous one finishes.
////    wrapper.textToSpeechAudio(outputSpeech);
////  }
////}

//ControlP5 cp5;
//CheckBox checkbox;
//int myColorBackground;

//void setup() {
//  size(800, 400);
//  smooth();
//  cp5 = new ControlP5(this);
//  checkbox = cp5.addCheckBox("checkBox")
//                .setPosition(100, 200)
//                .setSize(40, 40)
//                .setItemsPerRow(3)
//                .setSpacingColumn(30)
//                .setSpacingRow(20)
//                .addItem("0", 0)
//                .addItem("50", 50)
//                .addItem("100", 100)
//                .addItem("150", 150)
//                .addItem("200", 200)
//                .addItem("255", 255)
//                ;
//}

//void keyPressed() {
//  if (key==' ') {
//    checkbox.deactivateAll();
//  } 
//  else {
//    for (int i=0;i<6;i++) {
//      // check if key 0-5 have been pressed and toggle
//      // the checkbox item accordingly.
//      if (keyCode==(48 + i)) { 
//        // the index of checkbox items start at 0
//        checkbox.toggle(i);
//        println("toggle "+checkbox.getItem(i).getName());
//        // also see 
//        // checkbox.activate(index);
//        // checkbox.deactivate(index);
//      }
//    }
//  }
//}

//void draw() {
//  background(170);
//  pushMatrix();
//  translate(width/2 + 200, height/2);
//  stroke(255);
//  strokeWeight(2);
//  fill(myColorBackground);
//  ellipse(0,0,200,200);
//  popMatrix();
//}

//void controlEvent(ControlEvent theEvent) {
//  if (theEvent.isFrom(checkbox)) {
//    myColorBackground = 0;
//    print("got an event from "+checkbox.getName()+"\t\n");
//    // checkbox uses arrayValue to store the state of 
//    // individual checkbox-items. usage:
//    println(checkbox.getArrayValue());
//    int col = 0;
//    for (int i=0;i<checkbox.getArrayValue().length;i++) {
//      int n = (int)checkbox.getArrayValue()[i];
//      print(n);
//      if(n==1) {
//        myColorBackground += checkbox.getItem(i).internalValue();
//      }
//    }
//    println();    
//  }
//}

//void checkBox(float[] a) {
//  println(a);
//}
