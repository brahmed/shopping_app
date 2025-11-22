import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_app/models/help_question_model.dart';

void main() {
  group('HelpQuestionModel Tests', () {
    test('should create HelpQuestionModel instance with required fields', () {
      const helpQuestion = HelpQuestionModel(
        question: 'How can I track my order?',
        answer: 'You can track your order in the Orders section of your account.',
      );

      expect(helpQuestion.question, 'How can I track my order?');
      expect(helpQuestion.answer,
          'You can track your order in the Orders section of your account.');
    });

    test('should create HelpQuestionModel with empty strings', () {
      const helpQuestion = HelpQuestionModel(
        question: '',
        answer: '',
      );

      expect(helpQuestion.question, '');
      expect(helpQuestion.answer, '');
    });

    test('should be a const constructor', () {
      const helpQuestion1 = HelpQuestionModel(
        question: 'Test',
        answer: 'Test Answer',
      );

      const helpQuestion2 = HelpQuestionModel(
        question: 'Test',
        answer: 'Test Answer',
      );

      expect(identical(helpQuestion1, helpQuestion2), true);
    });

    test('should handle long question text', () {
      final longQuestion = 'How can I ' * 100;
      final helpQuestion = HelpQuestionModel(
        question: longQuestion,
        answer: 'Answer',
      );

      expect(helpQuestion.question.length, longQuestion.length);
    });

    test('should handle long answer text', () {
      final longAnswer = 'You can do this by ' * 100;
      const question = 'How?';
      final helpQuestion = HelpQuestionModel(
        question: question,
        answer: longAnswer,
      );

      expect(helpQuestion.answer.length, longAnswer.length);
    });

    test('should handle special characters in question', () {
      const helpQuestion = HelpQuestionModel(
        question: 'How can I cancel my order? !@#\$%^&*() <>&"\'',
        answer: 'Follow these steps...',
      );

      expect(helpQuestion.question, contains('!@#\$%^&*()'));
    });

    test('should handle special characters in answer', () {
      const helpQuestion = HelpQuestionModel(
        question: 'How to use discount codes?',
        answer: 'Use code: SAVE20! & get 20% off. Don\'t miss out!',
      );

      expect(helpQuestion.answer, contains('SAVE20!'));
      expect(helpQuestion.answer, contains('&'));
      expect(helpQuestion.answer, contains('Don\'t'));
    });

    test('should handle multiline question text', () {
      const helpQuestion = HelpQuestionModel(
        question: 'How can I:\n1. Track my order\n2. Cancel my order\n3. Return my order',
        answer: 'Answer to all questions',
      );

      expect(helpQuestion.question, contains('\n'));
      expect(helpQuestion.question, contains('1. Track my order'));
    });

    test('should handle multiline answer text', () {
      const helpQuestion = HelpQuestionModel(
        question: 'How can I cancel my order?',
        answer: 'To cancel your order:\n1. Go to Orders\n2. Select the order\n3. Click Cancel',
      );

      expect(helpQuestion.answer, contains('\n'));
      expect(helpQuestion.answer, contains('1. Go to Orders'));
    });

    test('should handle Unicode characters', () {
      const helpQuestion = HelpQuestionModel(
        question: 'Can I ship internationally? 🌍',
        answer: 'Yes! We ship worldwide 🚀✈️',
      );

      expect(helpQuestion.question, contains('🌍'));
      expect(helpQuestion.answer, contains('🚀'));
      expect(helpQuestion.answer, contains('✈️'));
    });

    test('should handle different languages', () {
      const helpQuestion = HelpQuestionModel(
        question: '¿Cómo puedo cancelar mi pedido?',
        answer: 'Puede cancelar su pedido en la sección de pedidos.',
      );

      expect(helpQuestion.question, '¿Cómo puedo cancelar mi pedido?');
      expect(helpQuestion.answer, 'Puede cancelar su pedido en la sección de pedidos.');
    });

    test('should compare instances correctly', () {
      const helpQuestion1 = HelpQuestionModel(
        question: 'Question',
        answer: 'Answer',
      );

      const helpQuestion2 = HelpQuestionModel(
        question: 'Question',
        answer: 'Answer',
      );

      const helpQuestion3 = HelpQuestionModel(
        question: 'Different Question',
        answer: 'Answer',
      );

      expect(helpQuestion1.question, helpQuestion2.question);
      expect(helpQuestion1.answer, helpQuestion2.answer);
      expect(helpQuestion1.question, isNot(helpQuestion3.question));
    });
  });

  group('QuestionBank Tests', () {
    test('should have a non-empty list of questions', () {
      expect(QuestionBank.questions, isNotEmpty);
    });

    test('should contain the predefined question', () {
      final hasExpectedQuestion = QuestionBank.questions.any(
        (q) => q.question == 'How can i cancel my order?',
      );

      expect(hasExpectedQuestion, true);
    });

    test('should contain the predefined answer', () {
      final question = QuestionBank.questions.firstWhere(
        (q) => q.question == 'How can i cancel my order?',
      );

      expect(
        question.answer,
        contains('Go to your orders and select the order you want to cancel'),
      );
    });

    test('should be a const list', () {
      expect(QuestionBank.questions, isA<List<HelpQuestionModel>>());
    });

    test('all questions should be valid HelpQuestionModel instances', () {
      for (final question in QuestionBank.questions) {
        expect(question, isA<HelpQuestionModel>());
        expect(question.question, isNotEmpty);
        expect(question.answer, isNotEmpty);
      }
    });

    test('should have questions with non-empty strings', () {
      for (final question in QuestionBank.questions) {
        expect(question.question.trim(), isNotEmpty);
        expect(question.answer.trim(), isNotEmpty);
      }
    });

    test('should be accessible as a static member', () {
      final questions = QuestionBank.questions;
      expect(questions, isNotNull);
      expect(questions, isA<List<HelpQuestionModel>>());
    });

    test('should maintain question count', () {
      final count = QuestionBank.questions.length;
      expect(count, greaterThanOrEqualTo(1));
    });

    test('questions should have reasonable length', () {
      for (final question in QuestionBank.questions) {
        expect(question.question.length, greaterThan(0));
        expect(question.answer.length, greaterThan(0));
      }
    });

    test('should be immutable', () {
      expect(() {
        QuestionBank.questions.clear();
      }, throwsUnsupportedError);
    });
  });

  group('HelpQuestionModel Edge Cases', () {
    test('should handle question with only whitespace', () {
      const helpQuestion = HelpQuestionModel(
        question: '   ',
        answer: 'Answer',
      );

      expect(helpQuestion.question, '   ');
    });

    test('should handle answer with only whitespace', () {
      const helpQuestion = HelpQuestionModel(
        question: 'Question',
        answer: '   ',
      );

      expect(helpQuestion.answer, '   ');
    });

    test('should handle very long strings', () {
      final longString = 'a' * 10000;
      final helpQuestion = HelpQuestionModel(
        question: longString,
        answer: longString,
      );

      expect(helpQuestion.question.length, 10000);
      expect(helpQuestion.answer.length, 10000);
    });

    test('should handle HTML-like content', () {
      const helpQuestion = HelpQuestionModel(
        question: 'How do I <tag> something?',
        answer: 'You can use <tag>content</tag> format.',
      );

      expect(helpQuestion.question, contains('<tag>'));
      expect(helpQuestion.answer, contains('<tag>'));
      expect(helpQuestion.answer, contains('</tag>'));
    });

    test('should handle URLs in text', () {
      const helpQuestion = HelpQuestionModel(
        question: 'Where can I find more info?',
        answer: 'Visit https://example.com/help for more information.',
      );

      expect(helpQuestion.answer, contains('https://example.com/help'));
    });

    test('should handle escaped characters', () {
      const helpQuestion = HelpQuestionModel(
        question: 'What about \\n and \\t?',
        answer: 'Use \\n for newline and \\t for tab.',
      );

      expect(helpQuestion.question, contains('\\n'));
      expect(helpQuestion.answer, contains('\\t'));
    });

    test('should handle null character edge cases', () {
      const helpQuestion = HelpQuestionModel(
        question: 'Question',
        answer: 'Answer',
      );

      expect(helpQuestion.question, isNot(contains('\u0000')));
      expect(helpQuestion.answer, isNot(contains('\u0000')));
    });

    test('should maintain string integrity', () {
      const original = 'Original Question';
      const helpQuestion = HelpQuestionModel(
        question: original,
        answer: 'Answer',
      );

      expect(helpQuestion.question, original);
      expect(identical(helpQuestion.question, original), false);
    });
  });

  group('HelpQuestionModel Use Cases', () {
    test('should work as FAQ model', () {
      const faq = [
        HelpQuestionModel(
          question: 'How do I create an account?',
          answer: 'Click on Sign Up and fill in your details.',
        ),
        HelpQuestionModel(
          question: 'How do I reset my password?',
          answer: 'Click on Forgot Password on the login page.',
        ),
        HelpQuestionModel(
          question: 'How do I contact support?',
          answer: 'Email us at support@example.com or call 1-800-HELP.',
        ),
      ];

      expect(faq.length, 3);
      expect(faq[0].question, contains('create an account'));
      expect(faq[1].question, contains('reset my password'));
      expect(faq[2].question, contains('contact support'));
    });

    test('should work for search/filtering', () {
      const questions = [
        HelpQuestionModel(question: 'How to order?', answer: 'Click Buy Now'),
        HelpQuestionModel(question: 'How to cancel?', answer: 'Go to Orders'),
        HelpQuestionModel(question: 'How to track?', answer: 'Check tracking'),
      ];

      final orderRelated = questions.where(
        (q) => q.question.toLowerCase().contains('order'),
      ).toList();

      expect(orderRelated.length, 1);
      expect(orderRelated[0].question, 'How to order?');
    });

    test('should support categorization', () {
      const accountQuestions = [
        HelpQuestionModel(question: 'How to login?', answer: 'Use email'),
        HelpQuestionModel(question: 'How to logout?', answer: 'Click logout'),
      ];

      const orderQuestions = [
        HelpQuestionModel(question: 'How to order?', answer: 'Click buy'),
        HelpQuestionModel(question: 'How to cancel?', answer: 'Go to orders'),
      ];

      expect(accountQuestions.length, 2);
      expect(orderQuestions.length, 2);
    });
  });
}
