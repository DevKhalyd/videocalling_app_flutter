# TODO

Add the calls history as new page (Test it)

Test the notification when the app is terminated

Create the logic of the chat (Backend side)

Create the cloud functions of the chat (Review after of implement the header of the chat screen)

# Description

A videocalling app where I show how structure an application with GetX and Clean Architecture.

# Set up the project

`flutter pub run build_runner build --delete-conflicting-outputs` or `watch`(Run to generate the files misssing)

## Android and IOS

Add your own files to configure this project.

All those files necessary are from Firebase Core. Check out the docs.

**IOS**

Add the necessary files to configure the permission handler.

https://github.com/AgoraIO/Agora-Flutter-SDK

# Structure

presentation: The UI and their controllers.

domain: The bridge between the data and presentation layers (Models and UseCases).

Use cases means that if I'm usign the AuthRepository the cases can be

- Sign in with Email and Password
- Sign in with Google
- Sign in with Twitter
- Sign in with GitHub

From that use cases should I return a response to interact with the UI... that means with the presentation Layer.

data: Get the data from an API or Local Storage (Firebase, API rest)

TODO: Add the flowcharts of the application.

# Resources

**Paths in flutter**
https://medium.com/flutter-community/paths-in-flutter-a-visual-guide-6c906464dcd0

# NOTES

This project was built with Flutter 2.5.3

# Libraries

All the libraries described here

## Agora

Important to read:

**Example:**

Agora IO:
https://github.com/AgoraIO/Agora-Flutter-SDK/blob/master/example/lib/examples/basic/join_channel_video/join_channel_video.dart

Reference:
https://docs.agora.io/en/Video/API%20Reference/flutter/index.html

# Designs (Inspirations)

https://dribbble.com/shots/8961268-Chat-App
