class ProductQuestion {
  final String id;
  final String productId;
  final String userId;
  final String userName;
  final String question;
  final DateTime askedAt;
  final List<Answer> answers;
  final int helpfulCount;

  ProductQuestion({
    required this.id,
    required this.productId,
    required this.userId,
    required this.userName,
    required this.question,
    required this.askedAt,
    this.answers = const [],
    this.helpfulCount = 0,
  });

  bool get hasAnswers => answers.isNotEmpty;

  factory ProductQuestion.fromJson(Map<String, dynamic> json) {
    return ProductQuestion(
      id: json['id'] as String,
      productId: json['productId'] as String,
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      question: json['question'] as String,
      askedAt: DateTime.parse(json['askedAt'] as String),
      answers:
          (json['answers'] as List?)?.map((a) => Answer.fromJson(a)).toList() ?? [],
      helpfulCount: json['helpfulCount'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productId': productId,
      'userId': userId,
      'userName': userName,
      'question': question,
      'askedAt': askedAt.toIso8601String(),
      'answers': answers.map((a) => a.toJson()).toList(),
      'helpfulCount': helpfulCount,
    };
  }
}

class Answer {
  final String id;
  final String userId;
  final String userName;
  final String answer;
  final DateTime answeredAt;
  final bool isVerifiedPurchase;
  final bool isOfficial;
  final int helpfulCount;

  Answer({
    required this.id,
    required this.userId,
    required this.userName,
    required this.answer,
    required this.answeredAt,
    this.isVerifiedPurchase = false,
    this.isOfficial = false,
    this.helpfulCount = 0,
  });

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      id: json['id'] as String,
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      answer: json['answer'] as String,
      answeredAt: DateTime.parse(json['answeredAt'] as String),
      isVerifiedPurchase: json['isVerifiedPurchase'] as bool? ?? false,
      isOfficial: json['isOfficial'] as bool? ?? false,
      helpfulCount: json['helpfulCount'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'userName': userName,
      'answer': answer,
      'answeredAt': answeredAt.toIso8601String(),
      'isVerifiedPurchase': isVerifiedPurchase,
      'isOfficial': isOfficial,
      'helpfulCount': helpfulCount,
    };
  }
}
