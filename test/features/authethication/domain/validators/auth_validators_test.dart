import 'package:flutter_test/flutter_test.dart';

import 'package:daymark_tracking/features/authethication/domain/validators/auth_validators.dart';

void main() {
  group('AuthValidators', () {
    test('rejects empty or whitespace-only email', () {
      expect(AuthValidators.validateEmail(''), 'Email required');
      expect(AuthValidators.validateEmail('   '), 'Email required');
    });

    test('trims email and validates format', () {
      expect(AuthValidators.validateEmail('  user@daymark.app  '), isNull);
      expect(
        AuthValidators.validateEmail('invalid-email'),
        'Enter a valid email',
      );
    });

    test('never trims password and enforces 8-character minimum', () {
      expect(
        AuthValidators.validatePassword('short'),
        'Password must be at least 8 characters',
      );
      expect(AuthValidators.validatePassword('        '), isNull);
      expect(AuthValidators.validatePassword('pass1234'), isNull);
    });

    test('confirm password requires exact match', () {
      expect(
        AuthValidators.validateConfirmPassword('pass1234 ', 'pass1234'),
        'Passwords do not match',
      );
      expect(
        AuthValidators.validateConfirmPassword('pass1234', 'pass1234'),
        isNull,
      );
    });
  });
}
