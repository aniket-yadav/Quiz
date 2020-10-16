import 'package:flutter/material.dart';

class Answers extends StatelessWidget {
  final String option;
  final Function check;
  final bool isSelected;
  final String answer;
  final String anssub;
  Answers({this.option, this.check, this.isSelected, this.answer, this.anssub});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Center(
        child: SizedBox(
          width: double.infinity,
          child: RaisedButton(
            padding: EdgeInsets.only(
              top: 10,
              bottom: 10,
            ),
            child: Text(
              option,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "Arial",
                fontSize: 20,
              ),
            ),
            color: isSelected
                ? ((anssub == answer && option == answer)
                    ? Colors.green
                    : (option == anssub
                        ? Colors.red
                        : (option == answer ? Colors.green : Colors.lightBlue)))
                : Colors.lightBlue,
            textColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            onPressed: () => check(option),
          ),
        ),
      ),
    );
  }
}
