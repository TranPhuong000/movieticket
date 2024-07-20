import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie/components/custom_background.dart';
import 'package:movie/pages/splash_onboarding/onboarding.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 3000), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const OnBoarding(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const CustomBackground(),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/MovieLogo.png',
                    height: 200,
                    width: 200,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Ticket Trove',
                      style: TextStyle(
                          fontSize: 45,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: GoogleFonts.racingSansOne().fontFamily),
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



// Scaffold(
//       body: Center(
//         child: Container(
//           height: double.infinity,
//           width: double.infinity,
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//                 colors: [
//                   // Color.fromRGBO(59, 21, 120, 1),
//                   // Color.fromRGBO(56, 75, 132, 1),
//                   // Color.fromRGBO(83, 34, 89, 1),
//                   Color.fromRGBO(45, 45, 130, 1),
//                   Color.fromRGBO(56, 75, 132, 1),
//                   Color.fromRGBO(70, 38, 89, 1),
//                 ],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//                 stops: [0.05, 0.46, 0.87]),
//           ),
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Image.asset(
//                   'assets/images/MovieLogo.png',
//                   height: 200,
//                   width: 200,
//                 ),
//                 Container(
//                   alignment: Alignment.center,
//                   child: Text(
//                     'Ticket Trove',
//                     style: TextStyle(
//                         fontSize: 45,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                         fontFamily: GoogleFonts.racingSansOne().fontFamily),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );