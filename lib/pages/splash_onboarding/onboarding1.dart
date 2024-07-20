import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie/components/custom_background.dart';

class Onboarding1 extends StatefulWidget {
  const Onboarding1({super.key});

  @override
  State<Onboarding1> createState() => _Onboarding1State();
}

class _Onboarding1State extends State<Onboarding1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const CustomBackground(),
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: PageView.builder(
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/MovieLogo.png',
                              height: 290,
                            ),
                            Text(
                              'Trải nghiệm mới',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 35,
                                    fontFamily:
                                        GoogleFonts.montserrat().fontFamily,
                                  ),
                            ),
                            const SizedBox(height: 22),
                            Text(
                              'Xem phim mới dễ dàng',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 20,
                                fontFamily: GoogleFonts.montserrat().fontFamily,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'hơn bao giờ hết',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 20,
                                fontFamily: GoogleFonts.montserrat().fontFamily,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
