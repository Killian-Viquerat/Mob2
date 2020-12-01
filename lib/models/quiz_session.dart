import 'package:flutter/foundation.dart';
import 'package:quiz/models/question.dart';

import 'dart:developer';
class QuizSession with ChangeNotifier {
  var _questions = [
    Question("2 + 2", ["1", "2", "4"], "4", "come on"),
    Question("Meaning of life?", ["God", "42", "Me"], "42", "H2G2"),
    Question("May the Force be with you", ["Star Wars", "Forest Gump", "American Pie"], "Star Wars", "Skywalker"),
  ];

  var questionPassed = 0; 
  var _currentQuestionIndex = 0;
  bool show = false;
  var score = 0;

  Question get currentQuestion => _questions[_currentQuestionIndex];
  Question get lastQuestion => _questions[_questions.length-1];
  int get length => _questions.length;

  void reset() {
    questionPassed = 0;
    notifyListeners();
  }

  void showhint(){
    show = !show;
    notifyListeners();
  }

  void nextQuestion() {
    _currentQuestionIndex = (_currentQuestionIndex + 1) % _questions.length;
    questionPassed+=1;
    notifyListeners();
  }

  bool checkAnswer(String answer) {
     if(_questions[_currentQuestionIndex].isCorrectAnswer(answer)){
       score++;
       return true;
     }
     return false;
  }
}
