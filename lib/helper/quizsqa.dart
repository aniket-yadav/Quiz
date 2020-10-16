import 'package:http/http.dart' as http;
import 'dart:convert';
import '../modal/quizmodel.dart';

class QuizQA {
  List<QuizQuestions> qa = [];

  List<int> category = [
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20,
    21,
    22,
    23,
    24,
    25,
    26,
    27,
    28,
    29,
    30,
    31,
    32
  ];

  List<String> difficulty = ['easy', 'medium', 'hard'];

  List<String> type = ['boolean', 'multiple'];
  Future<void> getQA() async {
    category.shuffle();
    difficulty.shuffle();
    type.shuffle();
    String url =
        "https://opentdb.com/api.php?amount=10&category=${category[0]}&difficulty=${difficulty[0]}&type=${type[0]}&encode=base64";

    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);
    if (jsonData['response_code'] == 0) {
      jsonData['results'].forEach((element) {
        String question = utf8.decode(base64.decode(element['question']));
        String answer = utf8.decode(base64.decode(element['correct_answer']));
        List<String> options = [];
        element['incorrect_answers'].forEach((e) {
          String option = utf8.decode(base64.decode(e));
          options.add(option);
        });
        options.add(answer);
        options.shuffle();
        QuizQuestions q =
            QuizQuestions(answer: answer, options: options, question: question);
        qa.add(q);
      });
    }
  }
}
