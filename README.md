# new_try

# Flutter Alarm Location App

A Flutter-based mobile app for a job interview task assessment. It features onboarding screens, location access, and alarm settings with notifications.

## Features
- 3 onboarding screens with a "Skip" option.
- Location permission and display.
- Alarm setting with time picker and notification.
- Local storage of alarms.

Flutter-alarm-location-app/
├── android/              # Android configuration
├── ios/                  # iOS configuration
├── lib/
│   ├── features/
│   │   ├── onboarding/   # Onboarding screens
│   │   │   ├── onboarding_screen.dart
│   │   ├── location/     # Location handling
│   │   │   ├── location_screen.dart
│   │   │   └── location_service.dart
│   │   ├── alarm/        # Alarm functionality
│   │   │   ├── alarm_screen.dart
│   └── main.dart         # App entry point
├── assets/               # Static assets (e.g., images from Figma)
├── test/                 # Unit and widget tests
├── .gitignore
├── pubspec.yaml          # Dependencies and configuration
├── README.md             # This file
└── analysis_options.yaml # Static analysis options
