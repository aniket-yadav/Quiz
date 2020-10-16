import 'package:flutter/material.dart';
import 'package:quiz/view/answers.dart';
import 'package:quiz/view/questions.dart';
import 'package:quiz/modal/quizmodel.dart';
import '../helper/quizsqa.dart';

class Quiz extends StatefulWidget {
  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  List<QuizQuestions> qa = new List<QuizQuestions>(10);
  bool isLoading = true;
  bool isSelected = false;
  int point = 0;
  List<int> visitedIndex = new List<int>(10);
  List<String> subans = new List<String>(10);
  String anssub = "";
  int _index = 0;

  void checkAnswer(String op) {
    setState(() {
      isSelected = true;
      subans.add(op);
      anssub = subans[_index];
    });
    if (_index == 9) {
      setState(() {
        visitedIndex.add(_index);
      });
    }
    if (op == qa[_index].answer) {
      setState(() {
        point += 1;
      });
    }
  }

  void restart() {
    setState(() {
      isSelected = false;
      isLoading = true;
      visitedIndex = [];
      point = 0;
      subans = [];
      anssub = "";
      _index = 0;
    });
    qA();
  }

  void onNext() {
    if (_index < qa.length - 1 && isSelected) {
      setState(() {
        visitedIndex.add(_index);
        _index += 1;
        isSelected = false;
      });
    }

    if (visitedIndex.contains(_index)) {
      setState(() {
        isSelected = true;
        anssub = subans[_index];
      });
    }
  }

  void onPrevious() {
    if (_index > 0) {
      setState(() {
        _index -= 1;
        anssub = subans[_index];
        isSelected = true;
      });
    }
  }

  Future<void> onSubmit() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Score'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text("Your Score is $point out of 10."),
                Text("Click restart to play again."),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              onPressed: () {
                restart();
                Navigator.of(context).pop();
              },
              child: Text("Restart"),
            )
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
      isSelected = false;
      point = 0;
      visitedIndex = [];
      subans = [];
      anssub = "";
      _index = 0;
    });
    qA();
  }

  Future<void> qA() async {
    QuizQA a = QuizQA();
    await a.getQA();
    if (a.qa.isNotEmpty) {
      setState(() {
        isLoading = false;
        qa = a.qa;
      });
    } else {
      qA();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 20,
      ),
      child: isLoading
          ? Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Questions(qa[_index].question),
                SizedBox(
                  height: 20,
                ),
                for (String str in qa[_index].options)
                  Answers(
                      check: checkAnswer,
                      option: str,
                      isSelected: isSelected,
                      answer: qa[_index].answer,
                      anssub: anssub),
                Spacer(),
                Row(
                  children: [
                    SizedBox(
                      child: (_index == 0)
                          ? SizedBox()
                          : RaisedButton(
                              padding: EdgeInsets.only(
                                top: 15,
                                bottom: 15,
                              ),
                              color: Colors.blue,
                              textColor: Colors.white,
                              child: Text(
                                "previous",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: "Arial",
                                  fontSize: 20,
                                ),
                              ),
                              onPressed: onPrevious,
                            ),
                    ),
                    Spacer(),
                    SizedBox(
                      child: (_index == 9)
                          ? SizedBox(
                              child: RaisedButton(
                                padding: EdgeInsets.only(
                                  top: 15,
                                  bottom: 15,
                                ),
                                color: Colors.blue,
                                textColor: Colors.white,
                                child: Text(
                                  "submit",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: "Arial",
                                    fontSize: 20,
                                  ),
                                ),
                                onPressed: onSubmit,
                              ),
                            )
                          : RaisedButton(
                              padding: EdgeInsets.only(
                                top: 15,
                                bottom: 15,
                              ),
                              color: Colors.blue,
                              textColor: Colors.white,
                              child: Text(
                                "Next",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: "Arial",
                                  fontSize: 20,
                                ),
                              ),
                              onPressed: onNext,
                            ),
                    ),
                  ],
                )
              ],
            ),
    );
  }
}
