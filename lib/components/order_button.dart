import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  const OrderButton({
    super.key,
    required this.onTap,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: SizedBox(
          width: 150,
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              color: Colors.blue,
            ),
            child: Text(text,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white,
                  fontFamily: GoogleFonts.montserrat().fontFamily,
                )),
          ),
        ),
      ),
    );
  }
}
