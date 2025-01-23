// Name: Anh Nguyen Mai Le
// GTID: 903569479
// PD2

import beads.*;
import controlP5.*;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;

NotificationServer server;
Printer printer;
Talker talker;
boolean talking;
AudioContext ac;
ControlP5 p5;
Gain masterGain;
ControlP5 cp5;
CheckBox checkbox;
int myColorBackground;
String currentContext = "None";
boolean isPresenting = false;

void setup() {
  size(800, 600);
  //size(1000, 800);
  smooth();
  cp5 = new ControlP5(this);
  checkbox = cp5.addCheckBox("checkBox")
                .setPosition(200, 50)
                .setSize(40, 40)
                .setItemsPerRow(1)
                .setSpacingColumn(50)
                .setSpacingRow(20)
                .addItem("Twitter", 0)
                .addItem("Email", 50)
                .addItem("Voice Mail", 100)
                .addItem("Phone Call", 150)
                .addItem("Text", 200)
                ;
  ac = new AudioContext();
  p5 = new ControlP5(this);
  masterGain = new Gain(ac, 1, 1.0);
  ac.out.addInput(masterGain);
  
  // Create and initialize the NotificationServer
  server = new NotificationServer();
 
  // This is an example of instantiating a custom class (seen below)
  // and registering it as a listener to the server. 
  talker = new Talker();
  server.addListener(talker);
  talking = true; // default to talk mode
  
  // Printer is an alternative notification listener that just
  // prints the notifications it receives
  printer = new Printer();
  
  // Switch between contexts
  p5.addButton("Working_Out").setPosition(50, 50).setSize(100, 50)
    .onClick((event) -> Working_Out());
  p5.addButton("Walking").setPosition(50, 120).setSize(100, 50)
    .onClick((event) -> Walking());
  p5.addButton("Socializing").setPosition(50, 190).setSize(100, 50)
    .onClick((event) -> Socializing());
  p5.addButton("Presenting").setPosition(50, 260).setSize(100, 50)
    .onClick((event) -> Presenting());
  
  // Switch between data streams
  p5.addButton("Data1").setPosition(300, 50).setSize(100, 50);
  p5.addButton("Data2").setPosition(300, 120).setSize(100, 50);
  p5.addButton("Data3").setPosition(300, 190).setSize(100, 50);
  p5.addButton("Data4").setPosition(300, 260).setSize(100, 50);
  
  //p5.addButton("Reset").setPosition(450, 50).setSize(100, 50).setLabel("Reset Context");
  
  // Toggle which notification listener is active
  p5.addButton("Toggle").setPosition(450, 50).setSize(100, 50).setLabel("Toggle Talk/Print");

  //// Demonstrate the play-multiple-sounds code
  //p5.addButton("PlayMultiple").setPosition(350, 120).setSize(100, 50);
  
  ac.start();
}

void Working_Out() {
  SamplePlayer workingout;
  try {
    workingout = new SamplePlayer(ac, new Sample(sketchPath("data/workingout.wav")));
    workingout.setLoopType(SamplePlayer.LoopType.LOOP_FORWARDS);
    masterGain.addInput(workingout);
    workingout.start();
  } catch(Exception e) {
    e.printStackTrace();
  }
  currentContext = "WorkingOut";
}

void Walking() {
  SamplePlayer walking;
  try {
    walking = new SamplePlayer(ac, new Sample(sketchPath("data/walking.wav")));
    walking.setLoopType(SamplePlayer.LoopType.LOOP_FORWARDS);
    masterGain.addInput(walking);
    walking.start();
  } catch(Exception e) {
    e.printStackTrace();
  }
  currentContext = "Walking";
}

void Socializing() {
  SamplePlayer socializing;
  try {
    socializing = new SamplePlayer(ac, new Sample(sketchPath("data/socializing.wav")));
    socializing.setLoopType(SamplePlayer.LoopType.LOOP_FORWARDS);
    masterGain.addInput(socializing);
    socializing.start();
  } catch(Exception e) {
    e.printStackTrace();
  }
  currentContext = "Socializing";
}

void Presenting() {
  SamplePlayer presenting;
  try {
    presenting = new SamplePlayer(ac, new Sample(sketchPath("data/presenting.wav")));
    presenting.setLoopType(SamplePlayer.LoopType.LOOP_FORWARDS);
    masterGain.addInput(presenting);
    presenting.start();
  } catch(Exception e) {
    e.printStackTrace();
  }
  isPresenting = true;
  currentContext = "Presenting";
}

// Examples of how to load a set of JSON-encoded notifications into
// the NotificationServer. Note that the code here purges any
// existing notifications before starting dispatch.
void Data1() {
  println("Data1");
  server.purgeTasksAndCancel();
  server.loadAndScheduleJSONData(loadJSONArray("ExampleData_1.json"));
}

void Data2() {
  println("Data2");
  server.purgeTasksAndCancel();
  server.loadAndScheduleJSONData(loadJSONArray("ExampleData_2.json"));
}

void Data3() {
  println("Data3");
  server.purgeTasksAndCancel();
  server.loadAndScheduleJSONData(loadJSONArray("ExampleData_3.json"));
}

void Data4() {
  println("Data4");
  server.purgeTasksAndCancel();
  server.loadAndScheduleJSONData(loadJSONArray("ExtraData.json"));
}

// Toggle talking versus printing by adding/removing the appropriate
// listener
void Toggle() {
  if (talking) {
    server.removeListener(talker);
    server.addListener(printer);
  } else {
    server.removeListener(printer);
    server.addListener(talker);
  }
  talking = !talking;
}

// Demonstrate how to use the play multiple sounds code
void PlayMultiple() {
  soundsToPlay.add("one.wav");
  soundsToPlay.add("meow.wav");
  soundsToPlay.add("two.wav");
  soundsToPlay.add("meow.wav");
  soundsToPlay.add("three.wav");
  soundsToPlay.add("meow.wav");
  soundsToPlay.add("four.wav");
  soundsToPlay.add("meow.wav");
  soundsToPlay.add("five.wav");
  soundsToPlay.add("meow.wav");

  // See the "play multiple sounds" tab
  PlaySounds();
}

// This is basically the simplest NotificationListener we can create;
// it just prints out the notification as it comes in.
class Printer implements NotificationListener {
  public void notificationReceived(Notification notification) {
    println(notification.getType().toString() + " notification received at " +
            Integer.toString(notification.getTimestamp()) + " ms");
    String debugOutput = ">>> ";
    switch (notification.getType()) {
      case Tweet:
        debugOutput += "Tweet received: ";
        break;
      case PhoneCall:
        debugOutput += "Phone call received: ";
        break;
      case VoiceMail:
        debugOutput += "Voice mail received: ";
        break;
      case TextMessage:
        debugOutput += "Text message received: ";
        break;
      case Email:
        debugOutput += "Email received: ";
        break;
      default:
        debugOutput += "WARNING: Unknown notification type";
        break;
    }
    debugOutput += notification.toString();
    
    println(debugOutput);
  }
}

// This is an example of a slightly more complex notification
// listener; this one speaks the notifications as they come in.
class Talker implements NotificationListener {
  // We'll use the SpeechWrapper code to speak the notifications  
  SpeechWrapper wrapper;
  boolean[] activeFilters;
  String[] notificationTypes;
  ArrayList<Notification> notificationQueue;
  HashMap<String, String> notificationSounds;
  Queue<String> soundsToPlay;
  
  public Talker() {
    this(new String[] {"Tweet", "Email", "VoiceMail", "PhoneCall", "TextMessage"});
  }
  
  public Talker(String[] notificationTypes) {
    this.wrapper = new SpeechWrapper();
    this.notificationTypes = notificationTypes;
    this.activeFilters = new boolean[notificationTypes.length];
    this.notificationQueue = new ArrayList<>();
    this.notificationSounds = new HashMap<>();
    this.soundsToPlay = new LinkedList<>();
 
    notificationSounds.put("Tweet", "twitter.wav");
    notificationSounds.put("Email", "email.wav");
    notificationSounds.put("VoiceMail", "voicemail.wav");
    notificationSounds.put("PhoneCall", "phonecall.wav");
    notificationSounds.put("TextMessage", "text.wav");
  }
  
  public void updateFilters(boolean[] filters) {
    this.activeFilters = filters.clone(); 
  }
  
  public void notificationReceived(Notification notification) {
    if (isPresenting) {
      if (notification.type.toString().equals("PhoneCall")) {
        soundsToPlay.add("vibrate.wav");
      } else {
        return;
      }
    } else {
      String soundFile = notificationSounds.get(notification.type.toString());
      if (soundFile != null) {
        soundsToPlay.add(soundFile);
      }
      for (int i = 0; i < notificationTypes.length; i++) {
        if (activeFilters[i] && notification.getType().toString().equals(notificationTypes[i])) {
          notificationQueue.add(notification);
          break;
        }
      }
    }
    
    notificationQueue.sort((n1, n2) -> {
      if (n1.timestamp != n2.timestamp) {
        return Long.compare(n1.timestamp, n2.timestamp);
      }
      return Integer.compare(n1.priority, n2.priority);
    });
    playNotificationSound(notification.getType().toString());
    processNotifications();
  }
  
  private void playNotificationSound(String soundFile) {
    try {
      Sample sample = new Sample(sketchPath("data/" + soundFile));
      SamplePlayer sound = new SamplePlayer(ac, sample);
      sound.setLoopType(SamplePlayer.LoopType.NO_LOOP_FORWARDS);
      sound.setKillOnEnd(true);
      masterGain.addInput(sound);
   
      if (soundFile.equals("vibrate.wav")) {
        Gain volumeControl = new Gain(ac, 1, 0.001f);
        volumeControl.addInput(sound);
        masterGain.addInput(volumeControl);
      } else {
        masterGain.addInput(sound);
      }
      Bead endListener = new Bead() {
        public void messageReceived(Bead message) {
          SamplePlayer sp = (SamplePlayer) message;
          sp.setEndListener(null);
          println("Done playing " + sp.getSample().getFileName());
          processNotifications();
        }
      };
     
      sound.setEndListener(endListener);
      sound.start();
    } catch (Exception e) {
      e.printStackTrace();
    }
  }  
  
  private void processNotifications() { 
    if (!soundsToPlay.isEmpty()) {
      String soundFile = soundsToPlay.poll();
      playNotificationSound(soundFile);
      if (!notificationQueue.isEmpty()) {
        Notification notification = notificationQueue.remove(0);
        String outputSpeech = getNotificationMessage(notification);
        // This will queue each message to play as soon as the previous one finishes.
        wrapper.textToSpeechAudio(outputSpeech);
      }
    }
  }
  
  private String getNotificationMessage(Notification notification) {
    String message = "";
    switch (notification.getType()) {
        case Tweet:
          message += "New tweet from ";
          break;
        case Email:
          message += "New email from ";
          break;
        case VoiceMail:
          message += "New voicemail from ";
          break;
        case PhoneCall:
          message += "Phone call from ";
          break;
        case TextMessage:
          message += "New message from ";
          break;
    }
    message += notification.getSender() + ", " + notification.getMessage();
    return message;
  }
}

void keyPressed() {
  if (key==' ') {
    checkbox.deactivateAll();
  } 
  else {
    for (int i=0;i<5;i++) {
      // check if key 0-5 have been pressed and toggle
      // the checkbox item accordingly.
      if (keyCode==(48 + i)) { 
        // the index of checkbox items start at 0
        checkbox.toggle(i);
        println("toggle "+checkbox.getItem(i).getName());
        // also see 
        // checkbox.activate(index);
        // checkbox.deactivate(index);
      }
    }
  }
}

void draw() {
  background(0);
  pushMatrix();
  translate(width/2 + 200, height/2);
  stroke(255);
  strokeWeight(2);
  fill(myColorBackground);
  //ellipse(0,0,200,200);
  popMatrix();
}

void controlEvent(ControlEvent theEvent) {
  if (theEvent.isFrom(checkbox)) {
    myColorBackground = 0;
    print("got an event from "+checkbox.getName()+"\t\n");
    float[] arrayValue = checkbox.getArrayValue();
    boolean[] activeFilters = new boolean[arrayValue.length];
    for (int i=0;i<arrayValue.length;i++) {
      int n = (int)arrayValue[i];
      activeFilters[i] = n == 1;
      if(n==1) {
        myColorBackground += checkbox.getItem(i).internalValue();
      }
    }
    println();   
    talker.updateFilters(activeFilters);
  }
}

void checkBox(float[] a) {
  println(a);
}
