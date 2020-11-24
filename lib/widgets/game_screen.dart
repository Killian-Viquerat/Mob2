import 'dart:io';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:quiz/models/quiz_session.dart';
import 'package:quiz/models/question.dart';
import 'package:quiz/models/score.dart';

class GameScreen extends StatelessWidget {

  Score score = new Score();
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz"),
      ),
      body: ChangeNotifierProvider(
        create: (_) => QuizSession(),
        child: Consumer<QuizSession>(
          builder: (consumerContext, session, __) => getScreen(consumerContext, session),
        ),
      ),
    );
  }

  Widget getScreen(BuildContext context,QuizSession session){
    if(session.questionPassed == session.length){
      return buildScore(context, score, session);
    }else{
      return buildQuestion(context, session.currentQuestion);
    }
  }

  Widget buildQuestion(BuildContext context, Question question) {
    var session = Provider.of<QuizSession>(context, listen: false);
    var answerButtons = question.answers.map((answer) {
      return (
            ElevatedButton(
              onPressed: () {
                if (session.checkAnswer(answer)) {
                    score.add();
                }
                session.nextQuestion();
                if(session.show){
                  session.showhint();
                }
              },
              child: SizedBox(
                width: double.infinity,
                child: Text(answer, textScaleFactor: 2.0, textAlign: TextAlign.center)
              )
            )
          );
    });
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(question.caption, textScaleFactor: 2.0),
            ...answerButtons,
            ElevatedButton(
              onPressed: () {
                session.showhint();
              },
              child: SizedBox(
                width: double.infinity,
                child: Text("?", textScaleFactor: 2.0, textAlign: TextAlign.center)
              )
            ),
            Visibility(child: Text(session.currentQuestion.hint), visible: session.show)
          ]
        ),
      );
    }

  Widget buildScore(BuildContext context,Score score,QuizSession session){
    return Center(
      child: Column(
        children: <Widget>[
          Text("Score:" + score.score.toString() + "/" + session.length.toString()),
          ElevatedButton(
              onPressed: () {
                  session.reset();
                  score.reset();
                },
                child: SizedBox(
                  width: double.infinity,
                  child: Text("New Game", textScaleFactor: 2.0, textAlign: TextAlign.center)
                )
          ),
        ],
        )
     );
  }
}
