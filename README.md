# Videocalling App

A videocalling app where I show how structure an application with GetX and Clean Architecture.

## Android and IOS

Add your own files to configure this project.

All those files necessary are from Firebase Core. Check out the docs.

# TODO

Add the configuration for IOS

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
