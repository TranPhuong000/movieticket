import 'package:flutter/material.dart';

class Promo extends StatelessWidget {
  const Promo({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, bottom: 12),
      child: Container(
        height: size.height / 8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          gradient: const LinearGradient(
            colors: [
              Colors.blue,
              Colors.lightBlue,
            ],
          ),
        ),
        child: Row(
          children: [
            const Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 8,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Student Holiday',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Text('Maximal only for two people',
                        style: TextStyle(
                          fontSize: 10,
                        )),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: RichText(
                  text: const TextSpan(children: [
                    TextSpan(
                        text: 'OFF',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(
                        text: '50%',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ]),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
