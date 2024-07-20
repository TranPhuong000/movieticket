import 'package:flutter/material.dart';
import '../splash_onboarding/onboarding1.dart';
import '../splash_onboarding/onboarding2.dart';
import '../splash_onboarding/onboarding3.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!
            .round(); // Cập nhật trang hiện tại khi trang thay đổi
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            PageView(
              controller: _pageController,
              children: const [
                Onboarding1(),
                Onboarding2(),
                Onboarding3(),
              ],
            ),
            Positioned(
              bottom: 45.0,
              left: 0.0,
              right: 0.0,
              child: AnimatedOpacity(
                opacity: _currentPage < 2 ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 100),
                child: Center(
                  child: SmoothPageIndicator(
                    controller: _pageController,
                    count: 3,
                    effect: const ExpandingDotsEffect(
                      spacing: 8.0,
                      dotWidth: 10.0,
                      dotHeight: 10.0,
                      dotColor: Colors.grey,
                      activeDotColor: Colors.blue,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
