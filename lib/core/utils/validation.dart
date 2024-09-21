//EMAIL VALIDATOR

String? emailValidator(String? value) {
  // Simple email regex pattern
  String pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  RegExp regex = RegExp(pattern);

  if (value == null || value.isEmpty) {
    return 'Email is required';
  } else if (!regex.hasMatch(value)) {
    return 'Enter a valid email address';
  }
  return null;
}

//PASSWORD VALIDATOR
String? passwordValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Password is required';
  }

  // Check for length
  if (value.length < 8) {
    return 'Password must be at least 8 characters long';
  }

  // Check for uppercase letter
  String uppercasePattern = r'^(?=.*[A-Z]).+$';
  RegExp uppercaseRegex = RegExp(uppercasePattern);
  if (!uppercaseRegex.hasMatch(value)) {
    return 'Password must contain at least one uppercase letter';
  }

  // Check for special character
  String specialCharPattern = r'^(?=.*[!@#$&*]).+$';
  RegExp specialCharRegex = RegExp(specialCharPattern);
  if (!specialCharRegex.hasMatch(value)) {
    return "Password must contain at least one special character (!@#\$&*)";
  }

  // If all conditions are met, return null (no validation errors)
  return null;
}

String? usernameValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Username is required';
  }

  // // Check length: Must be between 3 and 16 characters
  // if (value.length < 3 || value.length > 16) {
  //   return 'Username must be between 3 and 16 characters long';
  // }

  // // Check for valid characters: Only alphanumeric and underscores allowed
  // String pattern = r'^[a-zA-Z0-9_]+$';
  // RegExp regex = RegExp(pattern);
  // if (!regex.hasMatch(value)) {
  //   return 'Username can only contain letters, numbers, and underscores';
  // }

  return null; // Valid username
}
