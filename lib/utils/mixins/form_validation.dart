mixin FormValidationMixin {
  final nameRegEx = RegExp(r'^(?=.*\b[a-zA-Z]{3,}\b)[a-zA-Z]+( [a-zA-Z]+)*$');
  final emailRegEx =
      RegExp(r'^[A-Za-z0-9\._%+\-]+@[A-Za-z0-9\.\-]+\.[A-Za-z]{2,}$');

  final passwordRegEx = RegExp(
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
  );

  String? validateUserName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    if (!nameRegEx.hasMatch(value.trim())) {
      return 'Please enter a valid name';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email address';
    }
    if (!emailRegEx.hasMatch(value.trim())) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? validateEmpty(
    String? value,
  ) {
    if (value == null || value.isEmpty || value.trim().isEmpty) {
      return 'Please enter a task';
    }
    return null;
  }

  String? validateTask(String? value, String? hintText) {
    if (value == null || value.isEmpty || value.trim().isEmpty) {
      return 'Please enter ${hintText?.toLowerCase() ?? 'value'}';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (!passwordRegEx.hasMatch(value.trim())) {
      return 'Please enter a valid password';
    }
    return null;
  }

  String? validateMobile(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your mobile number';
    }
    if (value.length < 10) {
      return 'Please enter a valid mobile number';
    }
    return null;
  }
}
