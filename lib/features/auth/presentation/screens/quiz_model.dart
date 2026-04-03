class Quiz {
  final String question;
  final List<Answer> answers;

  Quiz({required this.question, required this.answers});
}

class Answer {
  final String answer;
  final bool isCorrect;

  Answer({required this.answer, required this.isCorrect});
}