class AppValidations {
  /// user name validation
  String? nameValidation(String? value) {
    if (value!.isEmpty) {
      return 'username required';
    }
    return null;
  }

  /// email validation
  String? emailValidation(String? value) {
    final RegExp emailValid = RegExp(
        r'^[a-zA-Z0-9.!#$%&+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*\.com$');

    if (value == null || value.isEmpty) {
      return 'Please enter your email.';
    }

    if (!emailValid.hasMatch(value)) {
      return 'Please enter a valid should ends with @gmail.com';
    }
    return null;
  }

  /// password validation
  String? passwordValidation(String? value) {
    if (value!.isEmpty) {
      return 'Please enter your password';
    } else if (value.length < 6) {
      return 'Password should be greater then 6 characters';
    }
    return null;
  }

  /// required field
  String? requiredField(String? value, {String? msgText}) {
    if (value!.isEmpty) {
      return msgText ?? 'Please enter data';
    }
    return null;
  }
}
