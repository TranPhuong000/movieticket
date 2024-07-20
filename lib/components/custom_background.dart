import 'package:flutter/material.dart';

class CustomBackground extends StatelessWidget {
  const CustomBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            //   Color.fromRGBO(58, 20, 119, 1),
            // Color.fromRGBO(56, 75, 132, 1),
            // Color.fromRGBO(83, 34, 89, 1),
            Color.fromRGBO(45, 45, 130, 1),
            Color.fromRGBO(56, 75, 132, 1),
            Color.fromRGBO(70, 38, 89, 1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.05, 0.46, 0.87],
        ),
      ),
    );
  }
}
