import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobilecomputing_app/Design/LoadingIndicator.dart';
import 'package:mobilecomputing_app/Design/appColors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobilecomputing_app/Utils/Gesture.dart';
import 'package:mobilecomputing_app/main.dart';
import 'package:mobilecomputing_app/mainPage.dart';

/* CATALOG SECTION */
class QuestionCatalog {
  int catalogID;
  String catalogTitle;
  List<QuestionsData> data;
  QuestionsCatalogCardWidget cardWidget;
  QuestionCatalogGameWidget gameWidget;

  QuestionCatalog(String catalogTitle) {
    this.data = new List<QuestionsData>();
    this.catalogTitle = catalogTitle;
    this.catalogID = catalogTitle.hashCode;
    this.cardWidget = new QuestionsCatalogCardWidget(this);
    this.gameWidget = new QuestionCatalogGameWidget(this);
    this._initQuestions();
  }

  void _initQuestions() {
    this.data.add(new EndQuestionData(this));
  }

  void addNewQuestion(QuestionsData question) {
    this.data.add(question);
  }

}

class QuestionCatalogGameWidget extends StatelessWidget {


  /*_QuestionsCatalogGameState state;
  QuestionCatalog _catalog;

  QuestionCatalogGameWidget(QuestionCatalog catalog) {
    this._catalog = catalog;
    this.state = new _QuestionsCatalogGameState(catalog);
  }

  void refreshUi() {
    this.state.setState(() {

    });
  }

  @override
  _QuestionsCatalogGameState createState() => state;

}

class _QuestionsCatalogGameState extends State<QuestionCatalogGameWidget> {

  QuestionCatalog _catalog;

  _QuestionsCatalogGameState(QuestionCatalog catalog) {
    this._catalog = catalog;
  }*/

  QuestionCatalog _catalog;

  QuestionCatalogGameWidget(QuestionCatalog catalog) {
    this._catalog = catalog;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[

        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //SizedBox(height: 20,),
            SafeArea(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      constraints: BoxConstraints(maxWidth: 200),
                      child: Text(this._catalog.catalogTitle, style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),),
                    ),
                    SizedBox(width: 20,),
                    Container(
                      padding: EdgeInsets.all(10),
                      /*decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.black12, width: 2)
                      ),*/
                      child: Column(
                        children: [
                          /*Text("Punktestand", style: TextStyle(
                            color: primaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          )),
                          SizedBox(height: 10,),*/
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    child: Icon(Icons.smartphone),
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(QuestionnaireApp.questionsDataStore.phonePlayerScore.toString(), style: TextStyle(
                                    fontSize: 18,
                                    color: textColor,
                                  ),),
                                ],
                              ),
                              SizedBox(width: 10,),
                              Column(
                                children: [
                                  Container(
                                    child: Icon(Icons.bluetooth),
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: primaryColor,
                                    ),
                                  ),
                                  Text(QuestionnaireApp.questionsDataStore.bluetoothPlayerScore.toString(), style: TextStyle(
                                    fontSize: 18,
                                    color: textColor,
                                  ),),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
            ),
          ],
        ),
        QuestionnaireApp.questionsDataStore.currentQuestionData.questionsDataGameWidget,
        //SizedBox(height: 80,),
      ],
    );
  }
}

class QuestionsCatalogCardWidget extends StatelessWidget {

  QuestionCatalog _catalog;

  QuestionsCatalogCardWidget(QuestionCatalog catalog) {
    this._catalog = catalog;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(this._catalog.catalogTitle),
        onTap: () => {
          QuestionnaireApp.questionsDataStore.changeToCatalog(this._catalog),
        },
      ),
    );
  }

}

/* QUESTIONS SECTION */
class QuestionsData {

  int questionID;
  String question;
  String answerDescription;
  bool answer;
  QuestionsDataGameWidget questionsDataGameWidget;
  QuestionCatalog catalog;

  QuestionsData(QuestionCatalog catalog, String question, bool positiveAnswer, String answerDescription) {
    this.answer = positiveAnswer;
    this.answerDescription = answerDescription;
    this.catalog = catalog;
    this.question = question;
    questionID = answer.hashCode + question.hashCode;
    this.questionsDataGameWidget = new QuestionsDataGameWidget(this, question, answer, answerDescription);
  }

}

class QuestionsDataGameWidget extends StatelessWidget {

  QuestionsData _question;
  String _text;
  String _answerDescription;
  bool _answer;

  bool _bluetoothPlayerHasGivenAnswer = false;
  bool _bluetoothPlayerAnswer;

  bool _playerHasGivenAnswer = false;
  bool _playerAnswer;

  bool _dialogOpen = false;

  QuestionsDataGameWidget(QuestionsData question, String text, bool answer, String answerDescription) {
    this._question = question;
    this._text = text;
    this._answer = answer;
    this._answerDescription = answerDescription;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.only(bottom: 30, left: 30, right: 30),
        //color: primaryColor.withOpacity(0.8),
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(this._text, style: TextStyle(
                fontSize: 18,
              ),),
              SizedBox(height: 20,),
              Text("Handy Spieler Eingabe"),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RaisedButton(
                    color: _playerHasGivenAnswer && _playerAnswer ? positiveColor : Colors.grey,
                    child: Text("Ja"),
                    onPressed: () => {questionInput(true)},
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  RaisedButton(
                    color: _playerHasGivenAnswer && !_playerAnswer ? negativeColor : Colors.grey,
                    child: Text("Nein"),
                    onPressed: () => {questionInput(false)},
                  )
                ],
              ),
              SizedBox(height: 20,),
              Text("Bluetooth Spieler Eingabe"),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RaisedButton(
                    color: _bluetoothPlayerHasGivenAnswer && _bluetoothPlayerAnswer ? positiveColor : Colors.grey,
                    child: Text("Ja"),
                    onPressed: () => { },
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  RaisedButton(
                    color: _bluetoothPlayerHasGivenAnswer && !_bluetoothPlayerAnswer ? negativeColor : Colors.grey,
                    child: Text("Nein"),
                    onPressed: () => {},
                  )
                ],
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    children: [
                      Text("Richtige Antwort:", style: TextStyle(fontWeight: FontWeight.bold),),
                      Text(
                        this._playerHasGivenAnswer && this._bluetoothPlayerHasGivenAnswer ? '' + ( this._answerDescription == null || this._answerDescription == ""
                            ? (this._answer ? "Ja" : "Nein") : this._answerDescription) : '',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  RaisedButton(
                      color: primaryColor,
                      child: Text("Nächste Frage", style: TextStyle(color: secondaryTextColor),),
                      onPressed: () => this.nextQuestion(),
                  ),
                ]
              )
            ],
          ),
        )
    );
  }

  void questionInput(bool answer) {
    this._playerHasGivenAnswer = true;
    this._playerAnswer = answer;
    if(answer == this._answer) {
      QuestionnaireApp.questionsDataStore.phonePlayerScore++;
    }
    if(!MainPage.manager.sampling) {

      this.showWaitingDialog();

      MainPage.manager.startListeningToGesture((gesture)
      {

        print('Stop Sensor Listening');
        MainPage.manager.pauseListenToSensorEvents();

        bool answerFlag = false;
        if(gesture.type == GestureType.Shaking) {
          print('Gesture Detected: Shaking Gesture');
          this._bluetoothPlayerHasGivenAnswer = true;
          this._bluetoothPlayerAnswer = false;
          answerFlag = this._answer == this._bluetoothPlayerAnswer;
        }

        if(gesture.type == GestureType.Nodding) {
          print('Gesture Detected: Nodding Gesture');
          this._bluetoothPlayerHasGivenAnswer = true;
          this._bluetoothPlayerAnswer = true;
          answerFlag = this._answer == this._bluetoothPlayerAnswer;
        }

        // Give bluetooth player a point if flag is true
        if(answerFlag) {
          QuestionnaireApp.questionsDataStore.bluetoothPlayerScore++;

        }

        QuestionnaireApp.mainPage.refreshUI();
        this.hideOpenDialog();

      });
    }
    else {
      MainPage.manager.pauseListenToSensorEvents();
      this.hideOpenDialog();
    }

    //QuestionnaireApp.questionsDataStore.nextQuestion();
  }

  void nextQuestion() {
    this._bluetoothPlayerHasGivenAnswer = false;
    this._playerHasGivenAnswer = false;
    QuestionnaireApp.questionsDataStore.nextQuestion();
  }

  void showWaitingDialog() {
    if(!this._dialogOpen) {
      showDialog(
          context: navigatorKey.currentContext,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0))
              ),
              backgroundColor: Colors.black87,
              content: LoadingIndicator(
                  text: "Warte auf Gestenerkennung"
              ),
            );
          }
      );
      this._dialogOpen = true;
    }
  }

  void showTextDialog(String text) {
    showDialog(
        context: navigatorKey.currentContext,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0))
            ),
            backgroundColor: Colors.black87,
            content:
                Text(text),
          );
        }
    );
  }

  void hideOpenDialog() {
    if(this._dialogOpen) {
      print('Close open dialog');
      Navigator.of(navigatorKey.currentContext).pop();
      this._dialogOpen = false;
    }
  }

}

/* END QUESTION FOR EACH CATALOG */
class EndQuestionData extends QuestionsData {

  EndQuestionData(QuestionCatalog catalog) : super(catalog, "", false, "") {
    this.questionsDataGameWidget = new EndQuestionWidget(this);
  }

}

class EndQuestionWidget extends QuestionsDataGameWidget {
  EndQuestionWidget(QuestionsData question) : super(question, "", false, "");

  @override
  Widget build(BuildContext context) {
    return Card (
      margin: EdgeInsets.all(30),
      child: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("Das Spiel ist fertig! 🎉", style: TextStyle(
              fontSize: 23,
              color: primaryColor,
            ),),
            SizedBox(height: 20,),
            Text("Es wurden alle Fragen beantwortet. Möchtest du nochmal spielen?"),
            SizedBox(height: 20,),
            Container(
              margin: EdgeInsets.only(left:50, right: 50),
              child: RaisedButton(
                color: primaryColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.play_arrow),
                    Text("Erneut spielen")
                  ],
                ),
                onPressed: () => { QuestionnaireApp.questionsDataStore.startGame() },
              ),
            ),
          ],
        ),
      ),
    );
  }

}

