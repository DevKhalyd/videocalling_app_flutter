# TODO

- Test that the UI works properly. Caller and Receiver

- Test that in each device contains works properly (Check out the flow)

- Receive the videocalling for the Receiver in the background of the device (Check the package of agora.)

# Videocalling App

A videocalling app where I show how structure an application with GetX and Clean Architecture.

# Set up the project

`flutter pub run build_runner build --delete-conflicting-outputs` or `watch`(Run to generate the files misssing)

## Android and IOS

Add your own files to configure this project.

All those files necessary are from Firebase Core. Check out the docs.

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

# Resources

**Paths in flutter**
https://medium.com/flutter-community/paths-in-flutter-a-visual-guide-6c906464dcd0

# NOTES

This project was built with Flutter 2.5.3
