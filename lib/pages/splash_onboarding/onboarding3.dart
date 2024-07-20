import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie/mainPage.dart';
import 'package:movie/pages/homePage/homePage.dart';
import 'package:movie/pages/login_signup/login_screen.dart';
import 'package:movie/components/custom_background.dart';

class Onboarding3 extends StatefulWidget {
  const Onboarding3({super.key});

  @override
  State<Onboarding3> createState() => _Onboarding3State();
}

class _Onboarding3State extends State<Onboarding3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(225, 11, 15, 47),
      body: SafeArea(
        child: Stack(
          children: [
            const CustomBackground(),
            // Hình ảnh ở dưới
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Image.asset(
                'assets/images/IntroOnboarding3.png',
                fit: BoxFit.fill,
              ),
            ),
            // Tấm màn ở trên
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromRGBO(11, 15, 47, 0.185),
                      Color.fromRGBO(11, 15, 47, 1),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(11, 15, 407, 0.2),
                      blurRadius: 80.0,
                      spreadRadius: 6.0,
                    ),
                  ],
                ),
              ),
            ),
            // Logo
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/MovieLogo.png',
                    height: 230,
                    width: 230,
                  ),
                  SizedBox(
                    width: 255,
                    height: 65,
                    child: FilledButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                          const Color.fromRGBO(61, 84, 248, 1),
                        ),
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()),
                        );
                      },
                      child: Text(
                        'Bắt đầu',
                        style: TextStyle(
                          fontSize: 22,
                          fontFamily: GoogleFonts.montserrat().fontFamily,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
