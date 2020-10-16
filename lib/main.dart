import 'package:flutter/material.dart';
import 'package:quiz/view/home.dart';

void main() => runApp(Quiz());

class Quiz extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      title: "Quiz",
      home: Home(),
    );
  }
}
