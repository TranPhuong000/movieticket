import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';
import 'package:movie/components/custom_background.dart';

class Onboarding2 extends StatefulWidget {
  const Onboarding2({super.key});

  @override
  State<Onboarding2> createState() => _Onboarding2State();
}

class _Onboarding2State extends State<Onboarding2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const CustomBackground(),
            Padding(
              padding: const EdgeInsets.all(8.0),
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
                              Text(
                                'Ticket Trove',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 35,
                                        fontFamily:
                                            GoogleFonts.poppins().fontFamily),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Sau khi mua vé xem phim, bạn chỉ cần',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 19,
                                        fontFamily:
                                            GoogleFonts.poppins().fontFamily),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                'quét mã vạch để xem bộ phim của mình.',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 19,
                                        fontFamily:
                                            GoogleFonts.poppins().fontFamily),
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              Image.asset(
                                'assets/images/ImageOB2.png',
                                height: 500,
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
      ),
    );
  }
}


// Positioned(
//               left: -40,
//               top: 290,
//               child: Container(
//                 width: 300,
//                 height: 300,
//                 decoration: const BoxDecoration(
//                   shape: BoxShape.circle,
//                   gradient: LinearGradient(
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                     colors: [
//                       Color.fromRGBO(62, 96, 249, 0.4),
//                       Color.fromRGBO(62, 96, 249, 0.5),
//                     ],
//                   ),
//                 ),
//               ),
//             ),

  // Positioned(
  //             right: -50,
  //             bottom: 260,
  //             child: Container(
  //               width: 300,
  //               height: 300,
  //               decoration: const BoxDecoration(
  //                 shape: BoxShape.circle,
  //                 gradient: LinearGradient(
  //                   begin: Alignment.topRight,
  //                   end: Alignment.bottomLeft,
  //                   colors: [
  //                     Color.fromRGBO(254, 83, 187, 0),
  //                     Color.fromRGBO(254, 83, 187, 0.5),
  //                   ],
  //                 ),
  //               ),
  //               child: BackdropFilter(
  //                 filter: ImageFilter.blur(sigmaX: 0.0, sigmaY: 100.0),
  //                 child: Container(
  //                   decoration: BoxDecoration(
  //                     shape: BoxShape.rectangle,
  //                     color: Colors.white.withOpacity(0.0),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ),