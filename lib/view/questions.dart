import 'package:flutter/material.dart';

class Questions extends StatelessWidget {
  final String qsn;
  Questions(this.qsn);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20, left: 10, right: 10),
      child: Center(
        child: Text(
          qsn,
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontFamily: "Arial",
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
