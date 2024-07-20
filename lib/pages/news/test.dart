import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Autocomplete Example')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Autocomplete<String>(
            optionsBuilder: (TextEditingValue textEditingValue) {
              if (textEditingValue.text == '') {
                return const Iterable<String>.empty();
              }
              return movieTitles.where((String option) {
                return option.contains(textEditingValue.text.toLowerCase());
              });
            },
            onSelected: (String selection) {
              print('You just selected $selection');
            },
          ),
        ),
      ),
    );
  }
}

const List<String> movieTitles = <String>[
  'Siêu lừa gặp siêu lầy',
  'Mèo đi chơi',
  'Avatar',
  'Titanic',
  'The Matrix',
  'Inception',
];
