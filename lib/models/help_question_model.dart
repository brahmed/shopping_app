/// A Question/Help Model Class
class HelpQuestionModel {
  final String question;
  final String answer;

  const HelpQuestionModel({
    required this.question,
    required this.answer,
  });
}

/// Dummy data
class QuestionBank {
  static const List<HelpQuestionModel> questions = [
    HelpQuestionModel(
      question: "How can i cancel my order?",
      answer:
          "Go to your orders and select the order you want to cancel. Select the checkbox next to each item you want to remove from the order.",
    ),
  ];
}
