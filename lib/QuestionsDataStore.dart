import 'package:flutter/material.dart';
import 'package:mobilecomputing_app/Data/Questions.dart';
import 'package:mobilecomputing_app/Data/QuestionsData.dart';
import 'package:mobilecomputing_app/main.dart';
import 'package:mobilecomputing_app/mainPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Design/appColors.dart';
import 'QuestionsGame.dart';

class QuestionsDataStore {

  List<QuestionCatalog> catalogs = new List<QuestionCatalog>();
  QuestionCatalog _selectedCatalog = null;
  QuestionsData _currentQuestion = null;

  int currentQuestionIndex = 1;

  int bluetoothPlayerScore = 0;
  int phonePlayerScore = 0;

  QuestionsDataStore() {
    this.initInitialCatalogs();
  }

  // For storage of the data
  void storeQuestionsCatalog(QuestionCatalog catalog) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String catalogKey = catalog.catalogID.toString();
    String catalogTitle = catalog.catalogTitle;
    List<QuestionsData> questions = catalog.data;

    // Add title if not already added
    if(prefs.getString(catalogKey + ".title") ?? 0 != 0) {
      prefs.setString(catalogKey + ".title", catalogTitle);
    }

    // Add questions if not already added
    questions.forEach((element) {

      String questionKey = element.questionID.toString();
      if(prefs.getString(questionKey + ".question") ?? 0 != 0) {
        prefs.setString(questionKey + ".question", element.question);
        prefs.setBool(questionKey + ".answer", element.answer);
      }

    });
  }

  // Initialize all Catalogs
  void initInitialCatalogs() {
    this.catalogs.add(initCatalogWithQuestions("Allgemeine Fragen", commonQuestions));
    this.catalogs.add(initCatalogWithQuestions("Ich habe noch nie..", iHaveNever));
    this.catalogs.add(initCatalogWithQuestions("Star Wars Quiz", starWarsQuestions));
    this.catalogs.add(initCatalogWithQuestions("Herr der Ringe Quiz", lordOfTheRingQuestions));
    this.catalogs.add(initCatalogWithQuestions("In meinem Leben würde ich gerne..", iWouldLikeTo));
  }

  QuestionCatalog initCatalogWithQuestions(String catalogTitle, List<Question> questions) {

    QuestionCatalog newCatalog = new QuestionCatalog(catalogTitle);
    questions.forEach((element) {
      newCatalog.addNewQuestion(new QuestionsData(newCatalog, element.question, element.positiveAnswer, element.description));
    });

    return newCatalog;

  }

  void changeToCatalog(QuestionCatalog catalog) {
    this._selectedCatalog = catalog;
    startGame();
  }

  void startGame() {
    this.currentQuestionIndex = 1;
    this.bluetoothPlayerScore = 0;
    this.phonePlayerScore = 0;
    this.nextQuestion();
  }

  void nextQuestion() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      QuestionnaireApp.mainPage.state.setState(() {

        this.currentQuestionIndex++;
        if(this.currentQuestionIndex >= this.currentQuestionCatalog.data.length) {
          this.currentQuestionIndex = 0;
          this._currentQuestion = this.currentQuestionCatalog.data.first;
        }
        else {
          this._currentQuestion = this.currentQuestionCatalog.data[this.currentQuestionIndex];
        }

      });
    });
  }

  // Getter & Setter
  QuestionCatalog get currentQuestionCatalog {
    if(this._selectedCatalog == null) {
      return this.catalogs.first;
    }
    return this._selectedCatalog;
  }

  set currentQuestionCatalog(QuestionCatalog catalog) {
    this._selectedCatalog = catalog;
  }

  QuestionsData get currentQuestionData {
    if(this._currentQuestion == null) {
      if(this.currentQuestionCatalog.data.length >= 2) {
        this._currentQuestion = this.currentQuestionCatalog.data[1];
      }
      else {
        this._currentQuestion = this.currentQuestionCatalog.data[0];
      }
      return this._currentQuestion;

    }
    return this._currentQuestion;
  }

  set currentQuestionData(QuestionsData question) {
    this._currentQuestion = question;
  }

}

class QuestionsStoreList extends StatelessWidget {
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 38, left: 20, right: 20),
      child: Scrollbar(
        controller: _scrollController,
        isAlwaysShown: true,
        child: ListView(
          controller: _scrollController,
          children: <Widget>[
            for(var item in QuestionnaireApp.questionsDataStore.catalogs) item.cardWidget
          ],
        ),
      ),
    );
  }
}

/* The navigation menu
  MainPage _mainPage;

  QuestionsStoreList(MainPage mainPage) {
    this._mainPage = mainPage;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Card(
          color: _mainPage.isSelected(1) ? primaryColor.withOpacity(0.8) : primaryColor,
          child: ListTile(
            leading: Icon(Icons.gamepad),
            title: Text("Fragenspiel"),
            onTap: () =>
            {
              this._currentPanelIndex = 1,
              changeMainPanel(context, QuestionsGame())
            },
            subtitle: Text(
                'Starte das Fragespiel.'
            ),
          ),
        ),
        Card(
          color: isSelected(2) ? primaryColor.withOpacity(0.8) : primaryColor,
          child: ListTile(
            leading: Icon(Icons.library_books),
            title: Text("Katalog"),
            onTap: () =>
            {
              this._currentPanelIndex = 2,
              changeMainPanel(context, QuestionsStorePage())
            },
            subtitle: Text(
                'Verwalte dein Fragenkatalog'
            ),
          ),
        ),
        Card(
          color: isSelected(3) ? primaryColor.withOpacity(0.8) : primaryColor,
          child: ListTile(
            leading: Icon(Icons.settings),
            title: Text("Einstellungen"),
            onTap: () =>
            {
              this._currentPanelIndex = 3,
              changeMainPanel(context, QuestionsStorePage())
            },
            subtitle: Text(
                'Verwalte die Einstellungen der App'
            ),
          ),
        ),
      ],
    );
  }
  */