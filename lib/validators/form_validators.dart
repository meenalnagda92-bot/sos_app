class FormValidators {
  FormValidators._();

  static final RegExp _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  static final RegExp _phoneRegex = RegExp(r'^\+?[0-9]{10,15}$');

  static String? required(String? value, {String field = 'This field'}) {
    if (value == null || value.trim().isEmpty) {
      return '$field is required';
    }
    return null;
  }

  static String? email(String? value) {
    final requiredError = required(value, field: 'Email');
    if (requiredError != null) return requiredError;

    if (!_emailRegex.hasMatch(value!.trim())) {
      return 'Enter a valid email address';
    }
    return null;
  }

  static String? loginPassword(String? value) {
    return required(value, field: 'Password');
  }

  static String? password(String? value) {
    final requiredError = required(value, field: 'Password');
    if (requiredError != null) return requiredError;

    final password = value!.trim();
    if (password.length < 8) {
      return 'Password must be at least 8 characters';
    }
    if (!password.contains(RegExp(r'[A-Z]'))) {
      return 'Include at least one uppercase letter';
    }
    if (!password.contains(RegExp(r'[a-z]'))) {
      return 'Include at least one lowercase letter';
    }
    if (!password.contains(RegExp(r'[0-9]'))) {
      return 'Include at least one number';
    }
    return null;
  }

  static String? confirmPassword(String? value, String? original) {
    final requiredError = required(value, field: 'Confirm password');
    if (requiredError != null) return requiredError;

    if (value!.trim() != (original ?? '').trim()) {
      return 'Passwords do not match';
    }
    return null;
  }

  static String? fullName(String? value) {
    final requiredError = required(value, field: 'Full name');
    if (requiredError != null) return requiredError;

    final name = value!.trim();
    if (name.length < 2) {
      return 'Name must be at least 2 characters';
    }
    if (!RegExp(r"^[a-zA-Z\s'-]+$").hasMatch(name)) {
      return 'Name can only contain letters, spaces, hyphens';
    }
    return null;
  }

  static String? phone(String? value) {
    if (value == null || value.trim().isEmpty) return null;

    final digits = value.replaceAll(RegExp(r'[\s\-()]'), '');
    if (!_phoneRegex.hasMatch(digits)) {
      return 'Enter a valid phone number (10–15 digits)';
    }
    return null;
  }
}