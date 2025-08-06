import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'features/onboarding/onboarding_screen.dart';
import 'features/location/location_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();

  // ✅ TEMPORARY LINE — forces onboarding to show again for testing
  await prefs.remove('seenOnboarding');

  final seen = prefs.getBool('seenOnboarding') ?? false;
  print("👀 seenOnboarding = $seen"); // Debug log

  runApp(MyApp(seenOnboarding: seen));
}

class MyApp extends StatelessWidget {
  final bool seenOnboarding;
  const MyApp({super.key, required this.seenOnboarding});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alarm App',
      debugShowCheckedModeBanner: false,
      home: seenOnboarding ? const LocationScreen() : const OnboardingScreen(),
    );
  }
}
