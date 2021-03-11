import 'package:flutter/material.dart';
import 'package:mobilecomputing_app/main.dart';



Color primaryColor = Color.fromRGBO(25, 194, 50, 1);

Color headerColor = Colors.lightGreen;
Color backgroundColor = Color.fromRGBO(25, 194, 132, 1);
Color secondaryBackgroundColor = Color(0xfafafafa);
Color textColor = Colors.black;
Color secondaryTextColor = Colors.black;
Color positiveColor = Colors.greenAccent;
Color negativeColor = Colors.redAccent;

void darkTheme() {
   primaryColor = Color.fromRGBO(255, 255, 255, 1);
   headerColor = Colors.lightGreen;
   backgroundColor = Color.fromRGBO(0, 0, 0, 1);
   secondaryBackgroundColor = Color.fromRGBO(38, 38, 38, 1);
   textColor = Colors.white;
   secondaryTextColor = Colors.white;
   positiveColor = Colors.greenAccent;
   negativeColor = Colors.redAccent;

  QuestionnaireApp.mainPage.refreshUI();
   QuestionnaireApp.storeThemeData(1);
}

void greenTheme() {
   primaryColor = Color.fromRGBO(25, 194, 50, 1);


   headerColor = Colors.lightGreen;

   backgroundColor = Color.fromRGBO(25, 194, 132, 1);
   secondaryBackgroundColor = Color(0xfafafafa);

    textColor = Colors.black;
    secondaryTextColor = Colors.black;
   positiveColor = Colors.greenAccent;
   negativeColor = Colors.redAccent;
   QuestionnaireApp.mainPage.refreshUI();
   QuestionnaireApp.storeThemeData(0);
}

void blueTheme() {

}