import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../location/location_screen.dart';

class OnboardingContent {
  final String title;
  final String subtitle;
  final String imagePath;

  OnboardingContent({
    required this.title,
    required this.subtitle,
    required this.imagePath,
  });
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  final List<OnboardingContent> _pages = [
    OnboardingContent(
      title: "Sync with Nature’s \nRhythm",
      subtitle:
      "Experience a peaceful transition into the evening\nwith an alarm that aligns with the sunset.",
      imagePath: "assets/images/onboarding1.png",
    ),
    OnboardingContent(
      title: "Effortless and Automatic",
      subtitle: "Your perfect reminder, always 15 minutes before\nsundown.",
      imagePath: "assets/images/onboarding2.png",
    ),
    OnboardingContent(
      title: "Relax and Unwind.",
      subtitle:
      "Let go of stress and allow your body to relax naturally\nwith a gentle alarm tuned to daylight cycles.",
      imagePath: "assets/images/onboarding3.png",
    ),
  ];

  void _finishOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seenOnboarding', true);
    if (context.mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LocationScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF212327), // Background set to dark grey
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: _pages.length,
            onPageChanged: (index) => setState(() => _currentIndex = index),
            itemBuilder: (_, index) {
              final page = _pages[index];
              return Column(
                children: [
                  // Image covering upper 55% of screen
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.55,
                    width: double.infinity,
                    child: Image.asset(
                      page.imagePath,
                      fit: BoxFit.cover, // Covers the area, cropping if necessary
                    ),
                  ),
                  // Remaining content
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title and Subtitle with flexible space
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  page.title,
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  page.subtitle,
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Fixed bottom section for dots and button
                          Container(
                            padding: const EdgeInsets.only(bottom: 40.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(
                                    _pages.length,
                                        (index) => Container(
                                      margin: const EdgeInsets.symmetric(horizontal: 4),
                                      width: 8,
                                      height: 8,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: _currentIndex == index ? Color(0xFF8A2BE2) : Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 24),
                                ElevatedButton(
                                  onPressed: _currentIndex == _pages.length - 1
                                      ? _finishOnboarding
                                      : () => _controller.nextPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFF8A2BE2),
                                    foregroundColor: Colors.white,
                                    minimumSize: const Size(360, 50),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: Text(
                                    _currentIndex == _pages.length - 1 ? "Done" : "Next",
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          // Skip button at top right
          Positioned(
            top: 40,
            right: 20,
            child: TextButton(
              onPressed: _finishOnboarding,
              child: const Text(
                "Skip",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}