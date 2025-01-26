import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:fyp2_app/shared/app_theme.dart';

import '../sign_in_up/sign_wrapper.dart';
import 'components/welcome_screen1.dart';
import 'components/welcome_screen2.dart';
import 'components/welcome_screen3.dart';
import 'components/welcome_screen4.dart';

class WelcomeFlow extends StatefulWidget {
  final VoidCallback onComplete;

  const WelcomeFlow({
    super.key,
    required this.onComplete,
  });

  @override
  State<WelcomeFlow> createState() => _WelcomeFlowState();
}

class _WelcomeFlowState extends State<WelcomeFlow> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.creamBackground,
      body: Stack(
        children: [
          // Page View
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _currentPage = index);
            },
            children: const [
              WelcomeScreen1(),
              WelcomeScreen2(),
              WelcomeScreen3(),
              WelcomeScreen4(),
            ],
          ),

          // Navigation and Indicators
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Column(
              children: [
                // Page Indicator
                Center(
                  child: SmoothPageIndicator(
                    controller: _pageController,
                    count: 4,
                    effect: WormEffect(
                      dotColor: AppTheme.secondaryBrown.withOpacity(0.3),
                      activeDotColor: AppTheme.accentGreen,
                      dotHeight: 8,
                      dotWidth: 8,
                      spacing: 12,
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                // Navigation Buttons
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Back Button (hide on first screen)
                      if (_currentPage > 0)
                        TextButton(
                          onPressed: () {
                            _pageController.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          },
                          child: Text(
                            'Back',
                            style: AppTheme.buttonTextStyle.copyWith(
                              color: AppTheme.secondaryBrown,
                            ),
                          ),
                        )
                      else
                        const SizedBox(width: 80),

                      // Next/Get Started Button
                      ElevatedButton(
                        onPressed: () {
                          if (_currentPage < 3) {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          } else {
                            // Directly navigate to SignParent
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignParent()),
                            );
                          }
                        },
                        style: AppTheme.primaryButtonStyle,
                        child: Text(
                          _currentPage == 3 ? 'Get Started' : 'Next',
                          style: AppTheme.buttonTextStyle,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
