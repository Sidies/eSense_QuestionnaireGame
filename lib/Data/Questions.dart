class Question<Q, PA> {
  final Q question;
  final PA positiveAnswer;
  String description = "";
  Question(this.question, this.positiveAnswer, [String desc]) {
    description = desc;
  }
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

final List<Question> starWarsQuestions = [
  Question("Yodas kompletter Name lautet 'Minch Yoda'", true),
  Question("Während der Produktion hatte Star Wars den Arbeitstitel 'Jar-Jar's Big Adventure'", false, "Blue Harvest"),
  Question("Die Sprache die Ewoks sprechen ist Tibetisch", true),
  Question("Der Kommunikator von Qui-Gon Jinns wurde aus einem Damen Rasierer hergestellt", true),
  Question("Yoda teilte seine Stimme mit den Filmfiguren Shrek, Nemo und Aladin", false, "Miss Piggy, Fozzie Bär und Bert"),
  Question("Die Stimme von Chewbacca enstand aus einer Mischung eines Bären, Dachs und Löwen", true),
  Question("Der Lichtschwerter Sound ist aus einer Mikrofon-Lautsprecher Interferenz entstanden", false, "Filprojektor & Kopfhörer Interferenz"),
];

final List<Question> iHaveNever = [
  Question("Ich habe noch nie intime Details über einen meiner Ex-Partner ausgeplaudert.", true),
  Question("Ich habe noch nie jemanden geküsst und es danach bereut.", true),
  Question("Ich habe noch nie nach dem Sport nicht geduscht.", true),
  Question("Ich habe noch nie an einer Ferienfreizeit teilgenommen.", false),
  Question("Ich habe noch nie etwas zerstört nur um mich an jemandem zu rächen.", false),
];

final List<Question> iWouldLikeTo = [
  Question("Ich habe noch nie intime Details über einen meiner Ex-Partner ausgeplaudert.", true),
  Question("Ich würde gerne zum Mond fliegen", true),
];



final List<Question> lordOfTheRingQuestions = [
  Question("Ursprünglich gab es 3 der 'großen Ringe'", false, "20"),
  Question("Ursprünglich gab es 3 der 'großen Ringe'", false, "20"),
  Question("Der Herr der Ringe wurde in Australien gedreht", false, "Neuseeland"),
  Question("Nach seiner Verwandlung hat Gandalf nichtmehr den Beinamen der Graue sondern der Weiße", true),
];