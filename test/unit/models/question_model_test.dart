import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_app/models/question_model.dart';

void main() {
  group('ProductQuestion Model Tests', () {
    late ProductQuestion testQuestion;
    late Answer testAnswer1;
    late Answer testAnswer2;
    late DateTime testAskedAt;
    late DateTime testAnsweredAt1;
    late DateTime testAnsweredAt2;

    setUp(() {
      testAskedAt = DateTime(2024, 1, 15, 10, 30);
      testAnsweredAt1 = DateTime(2024, 1, 16, 14, 20);
      testAnsweredAt2 = DateTime(2024, 1, 17, 9, 45);

      testAnswer1 = Answer(
        id: 'ans1',
        userId: 'user2',
        userName: 'Jane Smith',
        answer: 'Yes, this product is waterproof up to 50 meters.',
        answeredAt: testAnsweredAt1,
        isVerifiedPurchase: true,
        isOfficial: false,
        helpfulCount: 15,
      );

      testAnswer2 = Answer(
        id: 'ans2',
        userId: 'seller1',
        userName: 'Official Support',
        answer: 'Our product is IPX7 rated for water resistance.',
        answeredAt: testAnsweredAt2,
        isVerifiedPurchase: false,
        isOfficial: true,
        helpfulCount: 25,
      );

      testQuestion = ProductQuestion(
        id: 'q1',
        productId: 'prod1',
        userId: 'user1',
        userName: 'John Doe',
        question: 'Is this product waterproof?',
        askedAt: testAskedAt,
        answers: [testAnswer1, testAnswer2],
        helpfulCount: 10,
      );
    });

    test('should create ProductQuestion instance with all fields', () {
      expect(testQuestion.id, 'q1');
      expect(testQuestion.productId, 'prod1');
      expect(testQuestion.userId, 'user1');
      expect(testQuestion.userName, 'John Doe');
      expect(testQuestion.question, 'Is this product waterproof?');
      expect(testQuestion.askedAt, testAskedAt);
      expect(testQuestion.answers.length, 2);
      expect(testQuestion.helpfulCount, 10);
    });

    test('should have default values for optional fields', () {
      final question = ProductQuestion(
        id: 'q2',
        productId: 'prod2',
        userId: 'user2',
        userName: 'Test User',
        question: 'Test question?',
        askedAt: DateTime.now(),
      );

      expect(question.answers, isEmpty);
      expect(question.helpfulCount, 0);
    });

    test('should return true for hasAnswers when answers exist', () {
      expect(testQuestion.hasAnswers, true);
    });

    test('should return false for hasAnswers when no answers', () {
      final question = ProductQuestion(
        id: 'q3',
        productId: 'prod3',
        userId: 'user3',
        userName: 'User',
        question: 'Unanswered question?',
        askedAt: DateTime.now(),
      );

      expect(question.hasAnswers, false);
    });

    test('should serialize to JSON correctly', () {
      final json = testQuestion.toJson();

      expect(json['id'], 'q1');
      expect(json['productId'], 'prod1');
      expect(json['userId'], 'user1');
      expect(json['userName'], 'John Doe');
      expect(json['question'], 'Is this product waterproof?');
      expect(json['askedAt'], testAskedAt.toIso8601String());
      expect(json['answers'], isA<List>());
      expect(json['answers'].length, 2);
      expect(json['helpfulCount'], 10);
    });

    test('should deserialize from JSON correctly', () {
      final json = {
        'id': 'q4',
        'productId': 'prod4',
        'userId': 'user4',
        'userName': 'Alice Brown',
        'question': 'What is the warranty period?',
        'askedAt': '2024-02-20T14:30:00.000',
        'answers': [
          {
            'id': 'ans3',
            'userId': 'user5',
            'userName': 'Bob Wilson',
            'answer': '2 year warranty',
            'answeredAt': '2024-02-21T10:00:00.000',
            'isVerifiedPurchase': true,
            'isOfficial': false,
            'helpfulCount': 5,
          }
        ],
        'helpfulCount': 8,
      };

      final question = ProductQuestion.fromJson(json);

      expect(question.id, 'q4');
      expect(question.productId, 'prod4');
      expect(question.userId, 'user4');
      expect(question.userName, 'Alice Brown');
      expect(question.question, 'What is the warranty period?');
      expect(question.answers.length, 1);
      expect(question.answers[0].id, 'ans3');
      expect(question.helpfulCount, 8);
    });

    test('should handle missing optional fields in JSON', () {
      final json = {
        'id': 'q5',
        'productId': 'prod5',
        'userId': 'user5',
        'userName': 'Test',
        'question': 'Test question?',
        'askedAt': '2024-01-10T12:00:00.000',
      };

      final question = ProductQuestion.fromJson(json);

      expect(question.answers, isEmpty);
      expect(question.helpfulCount, 0);
    });

    test('should handle null answers array in JSON', () {
      final json = {
        'id': 'q6',
        'productId': 'prod6',
        'userId': 'user6',
        'userName': 'Test',
        'question': 'Test?',
        'askedAt': '2024-01-10T12:00:00.000',
        'answers': null,
      };

      final question = ProductQuestion.fromJson(json);

      expect(question.answers, isEmpty);
      expect(question.hasAnswers, false);
    });

    test('should handle null helpfulCount in JSON', () {
      final json = {
        'id': 'q7',
        'productId': 'prod7',
        'userId': 'user7',
        'userName': 'Test',
        'question': 'Test?',
        'askedAt': '2024-01-10T12:00:00.000',
        'helpfulCount': null,
      };

      final question = ProductQuestion.fromJson(json);

      expect(question.helpfulCount, 0);
    });

    test('should preserve data through JSON round-trip', () {
      final json = testQuestion.toJson();
      final recreated = ProductQuestion.fromJson(json);

      expect(recreated.id, testQuestion.id);
      expect(recreated.productId, testQuestion.productId);
      expect(recreated.userId, testQuestion.userId);
      expect(recreated.userName, testQuestion.userName);
      expect(recreated.question, testQuestion.question);
      expect(recreated.askedAt.toIso8601String(),
          testQuestion.askedAt.toIso8601String());
      expect(recreated.answers.length, testQuestion.answers.length);
      expect(recreated.helpfulCount, testQuestion.helpfulCount);
    });

    test('should handle empty answers array', () {
      final question = ProductQuestion(
        id: 'q8',
        productId: 'prod8',
        userId: 'user8',
        userName: 'User',
        question: 'Question?',
        askedAt: DateTime.now(),
        answers: [],
      );

      expect(question.answers, isEmpty);
      expect(question.hasAnswers, false);

      final json = question.toJson();
      final recreated = ProductQuestion.fromJson(json);

      expect(recreated.answers, isEmpty);
      expect(recreated.hasAnswers, false);
    });

    test('should handle many answers', () {
      final answers = List.generate(
        50,
        (index) => Answer(
          id: 'ans$index',
          userId: 'user$index',
          userName: 'User $index',
          answer: 'Answer $index',
          answeredAt: DateTime.now(),
        ),
      );

      final question = ProductQuestion(
        id: 'q9',
        productId: 'prod9',
        userId: 'user9',
        userName: 'User',
        question: 'Popular question?',
        askedAt: DateTime.now(),
        answers: answers,
      );

      expect(question.hasAnswers, true);
      expect(question.answers.length, 50);

      final json = question.toJson();
      final recreated = ProductQuestion.fromJson(json);

      expect(recreated.answers.length, 50);
    });

    test('should handle special characters in question text', () {
      final question = ProductQuestion(
        id: 'q10',
        productId: 'prod10',
        userId: 'user10',
        userName: 'User',
        question: 'Question with special chars: !@#\$%^&*() <>&"\' ?',
        askedAt: DateTime.now(),
      );

      final json = question.toJson();
      final recreated = ProductQuestion.fromJson(json);

      expect(recreated.question, question.question);
    });
  });

  group('Answer Model Tests', () {
    late Answer testAnswer;
    late DateTime testAnsweredAt;

    setUp(() {
      testAnsweredAt = DateTime(2024, 1, 16, 14, 20);

      testAnswer = Answer(
        id: 'ans1',
        userId: 'user1',
        userName: 'John Doe',
        answer: 'This is a helpful answer to the question.',
        answeredAt: testAnsweredAt,
        isVerifiedPurchase: true,
        isOfficial: false,
        helpfulCount: 20,
      );
    });

    test('should create Answer instance with all fields', () {
      expect(testAnswer.id, 'ans1');
      expect(testAnswer.userId, 'user1');
      expect(testAnswer.userName, 'John Doe');
      expect(testAnswer.answer, 'This is a helpful answer to the question.');
      expect(testAnswer.answeredAt, testAnsweredAt);
      expect(testAnswer.isVerifiedPurchase, true);
      expect(testAnswer.isOfficial, false);
      expect(testAnswer.helpfulCount, 20);
    });

    test('should have default values for optional fields', () {
      final answer = Answer(
        id: 'ans2',
        userId: 'user2',
        userName: 'Jane Smith',
        answer: 'Simple answer',
        answeredAt: DateTime.now(),
      );

      expect(answer.isVerifiedPurchase, false);
      expect(answer.isOfficial, false);
      expect(answer.helpfulCount, 0);
    });

    test('should serialize to JSON correctly', () {
      final json = testAnswer.toJson();

      expect(json['id'], 'ans1');
      expect(json['userId'], 'user1');
      expect(json['userName'], 'John Doe');
      expect(json['answer'], 'This is a helpful answer to the question.');
      expect(json['answeredAt'], testAnsweredAt.toIso8601String());
      expect(json['isVerifiedPurchase'], true);
      expect(json['isOfficial'], false);
      expect(json['helpfulCount'], 20);
    });

    test('should deserialize from JSON correctly', () {
      final json = {
        'id': 'ans3',
        'userId': 'user3',
        'userName': 'Support Team',
        'answer': 'Official answer from our support team.',
        'answeredAt': '2024-02-20T10:00:00.000',
        'isVerifiedPurchase': false,
        'isOfficial': true,
        'helpfulCount': 50,
      };

      final answer = Answer.fromJson(json);

      expect(answer.id, 'ans3');
      expect(answer.userId, 'user3');
      expect(answer.userName, 'Support Team');
      expect(answer.answer, 'Official answer from our support team.');
      expect(answer.isVerifiedPurchase, false);
      expect(answer.isOfficial, true);
      expect(answer.helpfulCount, 50);
    });

    test('should handle missing optional fields in JSON', () {
      final json = {
        'id': 'ans4',
        'userId': 'user4',
        'userName': 'User',
        'answer': 'Answer',
        'answeredAt': '2024-01-10T12:00:00.000',
      };

      final answer = Answer.fromJson(json);

      expect(answer.isVerifiedPurchase, false);
      expect(answer.isOfficial, false);
      expect(answer.helpfulCount, 0);
    });

    test('should handle null optional fields in JSON', () {
      final json = {
        'id': 'ans5',
        'userId': 'user5',
        'userName': 'User',
        'answer': 'Answer',
        'answeredAt': '2024-01-10T12:00:00.000',
        'isVerifiedPurchase': null,
        'isOfficial': null,
        'helpfulCount': null,
      };

      final answer = Answer.fromJson(json);

      expect(answer.isVerifiedPurchase, false);
      expect(answer.isOfficial, false);
      expect(answer.helpfulCount, 0);
    });

    test('should preserve data through JSON round-trip', () {
      final json = testAnswer.toJson();
      final recreated = Answer.fromJson(json);

      expect(recreated.id, testAnswer.id);
      expect(recreated.userId, testAnswer.userId);
      expect(recreated.userName, testAnswer.userName);
      expect(recreated.answer, testAnswer.answer);
      expect(recreated.answeredAt.toIso8601String(),
          testAnswer.answeredAt.toIso8601String());
      expect(recreated.isVerifiedPurchase, testAnswer.isVerifiedPurchase);
      expect(recreated.isOfficial, testAnswer.isOfficial);
      expect(recreated.helpfulCount, testAnswer.helpfulCount);
    });

    test('should handle verified purchase and official answer combinations', () {
      final answer1 = Answer(
        id: 'ans6',
        userId: 'user6',
        userName: 'User',
        answer: 'Answer',
        answeredAt: DateTime.now(),
        isVerifiedPurchase: true,
        isOfficial: true,
      );

      expect(answer1.isVerifiedPurchase, true);
      expect(answer1.isOfficial, true);

      final answer2 = Answer(
        id: 'ans7',
        userId: 'user7',
        userName: 'User',
        answer: 'Answer',
        answeredAt: DateTime.now(),
        isVerifiedPurchase: false,
        isOfficial: false,
      );

      expect(answer2.isVerifiedPurchase, false);
      expect(answer2.isOfficial, false);
    });

    test('should handle long answer text', () {
      final longAnswer = 'This is a very long and detailed answer. ' * 100;
      final answer = Answer(
        id: 'ans8',
        userId: 'user8',
        userName: 'Detailed User',
        answer: longAnswer,
        answeredAt: DateTime.now(),
      );

      expect(answer.answer.length, longAnswer.length);

      final json = answer.toJson();
      final recreated = Answer.fromJson(json);

      expect(recreated.answer, longAnswer);
    });

    test('should handle special characters in answer text', () {
      final answer = Answer(
        id: 'ans9',
        userId: 'user9',
        userName: 'User',
        answer: 'Answer with special chars: !@#\$%^&*() <>&"\' ',
        answeredAt: DateTime.now(),
      );

      final json = answer.toJson();
      final recreated = Answer.fromJson(json);

      expect(recreated.answer, answer.answer);
    });

    test('should handle zero helpfulCount', () {
      final answer = Answer(
        id: 'ans10',
        userId: 'user10',
        userName: 'User',
        answer: 'Not helpful answer',
        answeredAt: DateTime.now(),
        helpfulCount: 0,
      );

      expect(answer.helpfulCount, 0);

      final json = answer.toJson();
      final recreated = Answer.fromJson(json);

      expect(recreated.helpfulCount, 0);
    });

    test('should handle large helpfulCount', () {
      final answer = Answer(
        id: 'ans11',
        userId: 'user11',
        userName: 'User',
        answer: 'Very helpful answer',
        answeredAt: DateTime.now(),
        helpfulCount: 99999,
      );

      expect(answer.helpfulCount, 99999);

      final json = answer.toJson();
      final recreated = Answer.fromJson(json);

      expect(recreated.helpfulCount, 99999);
    });

    test('should handle different date formats', () {
      final json1 = {
        'id': 'ans12',
        'userId': 'user12',
        'userName': 'User',
        'answer': 'Answer',
        'answeredAt': '2024-01-15T10:30:00.000',
      };

      final json2 = {
        'id': 'ans13',
        'userId': 'user13',
        'userName': 'User',
        'answer': 'Answer',
        'answeredAt': '2024-01-15T10:30:00Z',
      };

      final answer1 = Answer.fromJson(json1);
      final answer2 = Answer.fromJson(json2);

      expect(answer1.answeredAt, isA<DateTime>());
      expect(answer2.answeredAt, isA<DateTime>());
    });
  });
}
