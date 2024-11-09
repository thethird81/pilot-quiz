class Question {
  late String question;
  List<String> option;
  int correctAnswer;
  String explanation;
  String difficultyLevel;
  bool isFlashCard;

  Question(
      {required this.question,
      required this.option,
      required this.correctAnswer,
      required this.explanation,
      required this.difficultyLevel,
      required this.isFlashCard});
}
