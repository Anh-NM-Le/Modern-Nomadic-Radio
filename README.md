# CS 4590 - Computer Audio (Fall 2024)
## What is Nomadic Radio?
- Nomadic Radio is a wearable computing platform for managing voice and text-based messages in a nomadic environment.
- Nomadic Radio employs an auditory user interface, which synchronizes speech recognition, speech synthesis, non-speech audio and spatial presentation of digital audio, for navigating among messages as well as asynchronous alerting of newly arrived messages.
- Emphasis is placed on an auditory modality as Nomadic Audio is designed to be used while performing other tasks in a user's everyday environment; a range of auditory cues provide peripheral awareness of incoming messages.
  
![image](https://github.com/user-attachments/assets/d898f51c-da91-40c1-97e5-b66ce9b2048c)

# Modern Nomadic Radio
## Project Overview:
##### In this project deliverable, a design document describing the sonification and auditory notification system of a modern Nomadic Radio will be presented. This project, developed using Processing, Beads, ControlP5, and a text-to-speech library, creates a simulated audio user interface system. According to Nitin Sawhney and Chris Schmandt paper on the Nomadic Radio, this design uses a layered approach that adapts based on environmental background noise, information type, information priority/urgency, and user interpretability/additional resources.
## Event Types:
- X/Twitter
- Email
- Text
- Phone call
- Voice mail
## User Contexts:
- Working out
- Walking
- Socializing
- Presenting
## Usage Instructions:

![image](https://github.com/user-attachments/assets/df55d3b6-876a-4ac5-bd85-a38bfdae3f02)

1.	Select context. Choose one of the available contexts (e.g. Presenting, Walking, etc.) via the interface.
2.	Select one or more event types. Use the checkboxes to specify the notification types you want to include in the simulation. Options include Phone Call, Twitter, Email, Text, Voice Mail. 
3.	Select one of four available JSON files that simulate notification data streams. 
4.	The simulator will play the associated sound files for selected notification types. It also generates text-to-speech output for the selected types. When a user is presenting, instead of playing “phonecall.wav”, the system substitutes “vibrate.wav” for phone call notifications, and silences all other notification types.
##### Each notification type is mapped to a distinct sound to enhance auditory recognition
-	Phone call notifications: “phonecall.wav”
-	Voice mail notifications: “voicemail.wav’’
-	Text notifications: “text.wav’’
-	Email notifications: “email.wav”
-	Twitter notifications: “twitter.wav”
##### Notifications are processed in order of timestamp and priority to ensure logical and timely delivery.

