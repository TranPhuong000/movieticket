import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MovieTitle extends StatefulWidget {
  const MovieTitle({
    super.key,
  });

  @override
  State<MovieTitle> createState() => _MovieTitleState();
}

class _MovieTitleState extends State<MovieTitle> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 35, top: 5),
          child: const Text(
            'Avengers',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 4, left: 35),
          child: const Text(
            'FX Sudirman XXI',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
