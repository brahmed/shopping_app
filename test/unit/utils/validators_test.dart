import 'package:flutter_test/flutter_test.dart';
import 'package:shopping_app/utils/validators.dart';

void main() {
  group('Validators Tests', () {
    group('validateEmail', () {
      test('should return error when email is null', () {
        final result = Validators.validateEmail(null);
        expect(result, 'Email is required');
      });

      test('should return error when email is empty', () {
        final result = Validators.validateEmail('');
        expect(result, 'Email is required');
      });

      test('should return error when email is whitespace', () {
        final result = Validators.validateEmail('   ');
        expect(result, 'Please enter a valid email');
      });

      test('should return error for invalid email format - missing @', () {
        final result = Validators.validateEmail('testexample.com');
        expect(result, 'Please enter a valid email');
      });

      test('should return error for invalid email format - missing domain', () {
        final result = Validators.validateEmail('test@');
        expect(result, 'Please enter a valid email');
      });

      test('should return error for invalid email format - missing TLD', () {
        final result = Validators.validateEmail('test@example');
        expect(result, 'Please enter a valid email');
      });

      test('should return error for invalid email format - invalid characters', () {
        final result = Validators.validateEmail('test@@example.com');
        expect(result, 'Please enter a valid email');
      });

      test('should return error for invalid email format - spaces', () {
        final result = Validators.validateEmail('test @example.com');
        expect(result, 'Please enter a valid email');
      });

      test('should return error for invalid email format - no username', () {
        final result = Validators.validateEmail('@example.com');
        expect(result, 'Please enter a valid email');
      });

      test('should return null for valid simple email', () {
        final result = Validators.validateEmail('test@example.com');
        expect(result, isNull);
      });

      test('should return null for valid email with dots', () {
        final result = Validators.validateEmail('test.user@example.com');
        expect(result, isNull);
      });

      test('should return null for valid email with plus', () {
        final result = Validators.validateEmail('test+tag@example.com');
        expect(result, isNull);
      });

      test('should return null for valid email with numbers', () {
        final result = Validators.validateEmail('test123@example456.com');
        expect(result, isNull);
      });

      test('should return null for valid email with underscore', () {
        final result = Validators.validateEmail('test_user@example.com');
        expect(result, isNull);
      });

      test('should return null for valid email with hyphen in domain', () {
        final result = Validators.validateEmail('test@my-example.com');
        expect(result, isNull);
      });

      test('should return null for valid email with subdomain', () {
        final result = Validators.validateEmail('test@mail.example.com');
        expect(result, isNull);
      });

      test('should return null for valid email with long TLD', () {
        final result = Validators.validateEmail('test@example.company');
        expect(result, isNull);
      });

      test('should return null for valid email with uppercase', () {
        final result = Validators.validateEmail('TEST@EXAMPLE.COM');
        expect(result, isNull);
      });

      test('should return null for valid email with mixed case', () {
        final result = Validators.validateEmail('TeSt@ExAmPlE.CoM');
        expect(result, isNull);
      });

      test('should return error for email with consecutive dots', () {
        final result = Validators.validateEmail('test..user@example.com');
        expect(result, 'Please enter a valid email');
      });

      test('should return error for email starting with dot', () {
        final result = Validators.validateEmail('.test@example.com');
        expect(result, 'Please enter a valid email');
      });

      test('should return error for email ending with dot before @', () {
        final result = Validators.validateEmail('test.@example.com');
        expect(result, 'Please enter a valid email');
      });
    });

    group('validatePassword', () {
      test('should return error when password is null', () {
        final result = Validators.validatePassword(null);
        expect(result, 'Password is required');
      });

      test('should return error when password is empty', () {
        final result = Validators.validatePassword('');
        expect(result, 'Password is required');
      });

      test('should return error when password is less than 8 characters', () {
        final result = Validators.validatePassword('Pass1!');
        expect(result, 'Password must be at least 8 characters');
      });

      test('should return error when password has no uppercase letter', () {
        final result = Validators.validatePassword('password1!');
        expect(result, 'Password must contain at least one uppercase letter');
      });

      test('should return error when password has no lowercase letter', () {
        final result = Validators.validatePassword('PASSWORD1!');
        expect(result, 'Password must contain at least one lowercase letter');
      });

      test('should return error when password has no number', () {
        final result = Validators.validatePassword('Password!');
        expect(result, 'Password must contain at least one number');
      });

      test('should return error when password has no special character', () {
        final result = Validators.validatePassword('Password1');
        expect(result, 'Password must contain at least one special character');
      });

      test('should return null for valid password with all requirements', () {
        final result = Validators.validatePassword('Password1!');
        expect(result, isNull);
      });

      test('should return null for valid password with @ symbol', () {
        final result = Validators.validatePassword('Password1@');
        expect(result, isNull);
      });

      test('should return null for valid password with # symbol', () {
        final result = Validators.validatePassword('Password1#');
        expect(result, isNull);
      });

      test('should return null for valid password with $ symbol', () {
        final result = Validators.validatePassword('Password1\$');
        expect(result, isNull);
      });

      test('should return null for valid password with % symbol', () {
        final result = Validators.validatePassword('Password1%');
        expect(result, isNull);
      });

      test('should return null for valid password with ^ symbol', () {
        final result = Validators.validatePassword('Password1^');
        expect(result, isNull);
      });

      test('should return null for valid password with & symbol', () {
        final result = Validators.validatePassword('Password1&');
        expect(result, isNull);
      });

      test('should return null for valid password with * symbol', () {
        final result = Validators.validatePassword('Password1*');
        expect(result, isNull);
      });

      test('should return null for valid password with - symbol', () {
        final result = Validators.validatePassword('Password1-');
        expect(result, isNull);
      });

      test('should return null for valid password with _ symbol', () {
        final result = Validators.validatePassword('Password1_');
        expect(result, isNull);
      });

      test('should return null for valid password with + symbol', () {
        final result = Validators.validatePassword('Password1+');
        expect(result, isNull);
      });

      test('should return null for valid password with = symbol', () {
        final result = Validators.validatePassword('Password1=');
        expect(result, isNull);
      });

      test('should return null for valid password with multiple special characters', () {
        final result = Validators.validatePassword('Pass@word1!#');
        expect(result, isNull);
      });

      test('should return null for valid password with multiple uppercase letters', () {
        final result = Validators.validatePassword('PaSsWoRd1!');
        expect(result, isNull);
      });

      test('should return null for valid password with multiple numbers', () {
        final result = Validators.validatePassword('Password123!');
        expect(result, isNull);
      });

      test('should return null for exactly 8 characters valid password', () {
        final result = Validators.validatePassword('Pass123!');
        expect(result, isNull);
      });

      test('should return null for long valid password', () {
        final result = Validators.validatePassword('VeryLongPassword123!@#');
        expect(result, isNull);
      });

      test('should validate all special characters individually', () {
        final specialChars = ['!', '@', '#', '\$', '%', '^', '&', '*', '(', ')',
                             ',', '.', '?', '"', ':', '{', '}', '|', '<', '>',
                             '-', '_', '+', '=', '[', ']', ';', '~', '`', '/', '\\'];

        for (final char in specialChars) {
          final result = Validators.validatePassword('Password1$char');
          expect(result, isNull,
              reason: 'Password with special character $char should be valid');
        }
      });

      test('should return error for password with only special characters', () {
        final result = Validators.validatePassword('!@#\$%^&*');
        expect(result, isNotNull);
      });

      test('should return error for password with only numbers', () {
        final result = Validators.validatePassword('12345678');
        expect(result, isNotNull);
      });

      test('should return error for password with only letters', () {
        final result = Validators.validatePassword('Password');
        expect(result, isNotNull);
      });
    });

    group('validateRequired', () {
      test('should return error when value is null', () {
        final result = Validators.validateRequired(null, 'Username');
        expect(result, 'Username is required');
      });

      test('should return error when value is empty', () {
        final result = Validators.validateRequired('', 'Username');
        expect(result, 'Username is required');
      });

      test('should return error when value is whitespace', () {
        final result = Validators.validateRequired('   ', 'Username');
        expect(result, 'Username is required');
      });

      test('should return null for non-empty value', () {
        final result = Validators.validateRequired('test', 'Username');
        expect(result, isNull);
      });

      test('should return null for value with spaces', () {
        final result = Validators.validateRequired('test user', 'Username');
        expect(result, isNull);
      });

      test('should use correct field name in error message', () {
        final result1 = Validators.validateRequired(null, 'Email');
        expect(result1, 'Email is required');

        final result2 = Validators.validateRequired(null, 'Phone Number');
        expect(result2, 'Phone Number is required');

        final result3 = Validators.validateRequired(null, 'Address');
        expect(result3, 'Address is required');
      });

      test('should return null for single character value', () {
        final result = Validators.validateRequired('a', 'Field');
        expect(result, isNull);
      });

      test('should return null for numeric string', () {
        final result = Validators.validateRequired('123', 'Field');
        expect(result, isNull);
      });

      test('should return null for special characters', () {
        final result = Validators.validateRequired('!@#', 'Field');
        expect(result, isNull);
      });
    });

    group('validateName', () {
      test('should return error when name is null', () {
        final result = Validators.validateName(null, 'First Name');
        expect(result, 'First Name is required');
      });

      test('should return error when name is empty', () {
        final result = Validators.validateName('', 'First Name');
        expect(result, 'First Name is required');
      });

      test('should return error when name is whitespace', () {
        final result = Validators.validateName('   ', 'First Name');
        expect(result, 'First Name is required');
      });

      test('should return error when name is less than 2 characters', () {
        final result = Validators.validateName('J', 'First Name');
        expect(result, 'First Name must be at least 2 characters');
      });

      test('should return null for exactly 2 characters', () {
        final result = Validators.validateName('Jo', 'First Name');
        expect(result, isNull);
      });

      test('should return null for valid name', () {
        final result = Validators.validateName('John', 'First Name');
        expect(result, isNull);
      });

      test('should return null for name with spaces', () {
        final result = Validators.validateName('John Doe', 'Full Name');
        expect(result, isNull);
      });

      test('should return null for long name', () {
        final result = Validators.validateName('Alexander', 'First Name');
        expect(result, isNull);
      });

      test('should return null for name with special characters', () {
        final result = Validators.validateName("O'Brien", 'Last Name');
        expect(result, isNull);
      });

      test('should return null for name with hyphen', () {
        final result = Validators.validateName('Mary-Jane', 'First Name');
        expect(result, isNull);
      });

      test('should use correct field name in error message', () {
        final result1 = Validators.validateName(null, 'Last Name');
        expect(result1, 'Last Name is required');

        final result2 = Validators.validateName('A', 'First Name');
        expect(result2, 'First Name must be at least 2 characters');

        final result3 = Validators.validateName(null, 'Company Name');
        expect(result3, 'Company Name is required');
      });

      test('should return null for name with numbers', () {
        final result = Validators.validateName('John123', 'Username');
        expect(result, isNull);
      });

      test('should return null for name with dots', () {
        final result = Validators.validateName('Dr. Smith', 'Name');
        expect(result, isNull);
      });

      test('should return null for Unicode characters', () {
        final result = Validators.validateName('José', 'First Name');
        expect(result, isNull);
      });

      test('should return null for name with accents', () {
        final result = Validators.validateName('François', 'First Name');
        expect(result, isNull);
      });

      test('should return null for name with multiple words', () {
        final result = Validators.validateName('Jean Paul Pierre', 'Full Name');
        expect(result, isNull);
      });
    });

    group('Edge Cases', () {
      test('should handle very long input strings', () {
        final longString = 'a' * 1000;

        final emailResult = Validators.validateEmail(longString);
        expect(emailResult, isNotNull); // Should be invalid email

        final nameResult = Validators.validateName(longString, 'Name');
        expect(nameResult, isNull); // Should be valid (length >= 2)

        final requiredResult = Validators.validateRequired(longString, 'Field');
        expect(requiredResult, isNull); // Should be valid (not empty)
      });

      test('should handle strings with only whitespace', () {
        final whitespace = '     ';

        expect(Validators.validateEmail(whitespace), isNotNull);
        expect(Validators.validatePassword(whitespace), isNotNull);
        expect(Validators.validateRequired(whitespace, 'Field'), isNotNull);
        expect(Validators.validateName(whitespace, 'Name'), isNotNull);
      });

      test('should handle strings with newlines and tabs', () {
        final stringWithNewlines = 'test\n\tvalue';

        expect(Validators.validateRequired(stringWithNewlines, 'Field'), isNull);
        expect(Validators.validateName(stringWithNewlines, 'Name'), isNull);
      });

      test('should handle empty after trim check', () {
        // Note: Current validators don't trim, testing actual behavior
        expect(Validators.validateRequired('   ', 'Field'), isNotNull);
        expect(Validators.validateName('   ', 'Name'), isNotNull);
      });
    });
  });
}
