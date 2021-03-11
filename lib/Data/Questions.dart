class Question<Q, PA> {
  final Q question;
  final PA positiveAnswer;
  Question(this.question, this.positiveAnswer);
}

// common questions
final List<Question> commonQuestions = [
  Question("Hast du schon mal einem Menschen in einer Notsituation geholfen?", true),
  Question("Hast du dir schon mal selbst die Haare geschnitten?", true),
  Question("Hast du schon mal eine ganze Woche zu Hause verbracht, ohne rauszugehen?", true),
  Question("Hast du heute schon gelogen?", true),
  Question("Hast du schon mal über jemanden gelästert, der im selben Raum war?",false),
  Question("Hast du schon mal die Schule geschwänzt?",false),
  Question("Hast du schon mal in einer Klausur gespickt?", false),
  Question("Hast du schon mal geklaut?",false),
  Question("Hast du schon mal unter freiem Himmel geschlafen?",true),
  Question("Hast du schon mal eine Straftat begangen?",false),
  Question("Hast du schon mal jemanden versetzt?",false),
  Question("Hast du schon mal versucht, dein Leben komplett neu zu gestalten?",true),
  Question("Hast du schon mal Nutella mit einem Löffel direkt aus dem Glas gegessen?", false),
  Question("Hast du schon mal etwas richtig Teures kaputt gemacht?", false),
  Question("Hast du schon mal einen kompletten Kuchen alleine gegessen?", false),
  Question("Hast du schon mal etwas gekauft und es dann nie benutzt?", false),
  Question("Hast du dir schon mal etwas gebrochen?",true),
  Question("Hast du schon mal so viel von etwas gegessen, dass dir davon richtig schlecht geworden ist?",true),
  Question("Hast du schon mal jemandem eine Ohrfeige gegeben?",true),
  Question("Hast du schon mal etwas gemacht, das deine Eltern niemals erfahren dürfen?", true),
];

final List<Question> iHaveNever = [
  Question("Ich habe noch nie intime Details über einen meiner Ex-Partner ausgeplaudert.", true),
  Question("Ich habe noch nie jemanden geküsst und es danach bereut.", true),
  Question("Ich habe noch nie nach dem Sport nicht geduscht.", true),
  Question("Ich habe noch nie an einer Ferienfreizeit teilgenommen.", false),
  Question("Ich habe noch nie etwas zerstört nur um mich an jemandem zu rächen.", false),
];