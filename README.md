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

## Tools/Packages Used
- **Flutter SDK**: The core framework for building the cross-platform mobile app (version 3.x recommended).
- **flutter_local_notifications**: ^9.9.1 - For scheduling and displaying local notifications for alarms.
- **shared_preferences**: ^2.2.2 - For persisting alarm data locally on the device.
- **geolocator**: ^9.0.2 - For requesting and retrieving the user's location.
- **intl**: ^0.18.0 - For formatting dates and times in the alarm system.
- **timezone**: ^0.9.2 - For handling time zones in notification scheduling.
- **Android Studio/Xcode**: IDEs for emulator/simulator testing and build configuration.
- **Figma**: Used to follow the provided design[](https://www.figma.com/design/FbHsUNPJ3tRWWdvh32cmh0/Test-01-%7C%7C-Figma?node-id=2001-183&t=PtunpJ3oiYPBvBA8-1).

## Project Setup Instructions

### Prerequisites
- [Flutter SDK](https://flutter.dev/docs/get-started/install) installed (version 3.x recommended).
- Android Studio or Xcode with an emulator/simulator configured.
- An Android or iOS device (optional for testing on hardware).

### Steps
1. **Clone the Repository**:
   ```bash
   git clone https://github.com/AhsanulAminShanto/Flutter-alarm-location-app.git
   cd Flutter-alarm-location-app

dependencies:
  flutter:
    sdk: flutter
  flutter_local_notifications: ^9.9.1
  shared_preferences: ^2.2.2
  geolocator: ^9.0.2
  intl: ^0.18.0
  timezone: ^0.9.2

### Notes
- **Placement**: These sections can be placed after the "Features" section and before "Usage" in the `README.md`.
- **Customization**: Update the Loom link placeholder with your actual video link after recording.
- **Permissions**: Ensure these are added to your project files as described.
- **Timestamp**: Instructions are current as of 08:02 PM +06 on Wednesday, August 06, 2025.

Let me know if you need further adjustments or help integrating this into your repository!

![image alt](https://github.com/AhsanulAminShanto/Flutter-alarm-location-app/blob/master/Screenshot%20of%20the%20Flutter%20Alarm%20App/1.PNG?raw=true)
![image alt](https://github.com/AhsanulAminShanto/Flutter-alarm-location-app/blob/master/Screenshot%20of%20the%20Flutter%20Alarm%20App/2.PNG?raw=true)
![image alt](https://github.com/AhsanulAminShanto/Flutter-alarm-location-app/blob/master/Screenshot%20of%20the%20Flutter%20Alarm%20App/3.PNG?raw=true)
![image alt](https://github.com/AhsanulAminShanto/Flutter-alarm-location-app/blob/master/Screenshot%20of%20the%20Flutter%20Alarm%20App/4.PNG?raw=true)
![image alt](https://github.com/AhsanulAminShanto/Flutter-alarm-location-app/blob/master/Screenshot%20of%20the%20Flutter%20Alarm%20App/5.PNG?raw=true)
![image alt](https://github.com/AhsanulAminShanto/Flutter-alarm-location-app/blob/master/Screenshot%20of%20the%20Flutter%20Alarm%20App/6.PNG?raw=true)
