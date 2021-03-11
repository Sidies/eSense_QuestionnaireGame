import 'package:flutter/material.dart';
import 'package:mobilecomputing_app/Data/QuestionsData.dart';
import 'package:mobilecomputing_app/QuestionsDataStore.dart';
import 'package:mobilecomputing_app/main.dart';
import 'package:mobilecomputing_app/mainPage.dart';

class QuestionsGame extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        child: getCurrentCatalogWidget(),
      ),
    );
  }

  QuestionCatalogGameWidget getCurrentCatalogWidget() {
    QuestionCatalog catalog = QuestionnaireApp.questionsDataStore.currentQuestionCatalog;
    return catalog.gameWidget;
  }

}