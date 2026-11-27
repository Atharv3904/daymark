/// Presentation-layer UI form validators matching `authethications/spec.md` §4.
class AuthFormValidators {
  AuthFormValidators._();

  static final RegExp _emailRegex = RegExp(
    r'^[A-Za-z0-9._%+\-]+@[A-Za-z0-9.\-]+\.[A-Za-z]{2,}$',
  );

  /// Trims surrounding whitespace before validating email format.
  static String? validateEmail(String? value) {
    final String trimmed = (value ?? '').trim();
    if (trimmed.isEmpty) {
      return 'Email required';
    }
    if (!_emailRegex.hasMatch(trimmed)) {
      return 'Enter a valid email';
    }
    return null;
  }

  /// Never trims or alters passwords; spaces are significant.
  static String? validatePassword(String? value) {
    final String raw = value ?? '';
    if (raw.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }

  /// Exact match confirmation without trimming either password.
  static String? validateConfirmPassword(String? value, String password) {
    if ((value ?? '') != password) {
      return 'Passwords do not match';
    }
    return null;
  }
}
