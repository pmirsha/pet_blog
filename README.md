# Pet Blog 🐾

A cross-platform Flutter app where pet owners share blog posts about their pets, built with Firebase.

## Tech stack

Flutter, Dart, Firebase Auth, Cloud Firestore, Provider

## Features

- [x] Sign up, log in, log out (with show/hide password)
- [x] Real-time post feed
- [ ] Create post with image
- [ ] Post detail and profile
- [ ] Edit and delete posts
- [ ] Likes and comments
- [ ] Search and categories

## Screenshots

Coming soon.

## Project structure


lib/
├── models/ # Post, AppUser
├── services/ # Auth and Firestore services
├── providers/ # State management (Provider)
├── screens/ # auth, home, ...
└── widgets/ # Reusable UI (PostCard)



## Setup

1. Clone the repo
2. Create a Firebase project and enable Email/Password auth and Firestore
3. Run `flutterfire configure` to generate `lib/firebase_options.dart`
4. Run `flutter pub get`
5. Run `flutter run`

## Author

Mirisha Poudel