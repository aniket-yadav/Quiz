import 'package:flutter/material.dart';
import './quiz.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Quiz",
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Arial",
            fontSize: 30,
          ),
        ),
        centerTitle: true,
        elevation: 5,
      ),
      body: Quiz(),
    );
  }
}
