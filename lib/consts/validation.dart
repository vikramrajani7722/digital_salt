import 'package:form_field_validator/form_field_validator.dart';

class XValidator {
  XValidator._();
  static String? validateEmailWithValue(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required.';
    }

    // Regular expression for email validation
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegExp.hasMatch(value)) {
      return 'Invalid email address.';
    }

    return null;
  }

  static String? validatePasswordWithValue(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required.';
    }

    // Check for minimum password length
    if (value.length < 6) {
      return 'Password must be at least 6 characters long.';
    }

    // Check for uppercase letters
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter.';
    }

    // Check for numbers
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number.';
    }

    // Check for special characters
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character.';
    }

    return null;
  }

  static String? validatePhoneNumberWithValue(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required.';
    }

    // Regular expression for phone number validation (assuming a 10-digit US phone number format)
    final phoneRegExp = RegExp(r'^\d{10}$');

    if (!phoneRegExp.hasMatch(value)) {
      return 'Invalid phone number format (10 digits required).';
    }

    return null;
  }

  static final validatePassword = MultiValidator([
    RequiredValidator(errorText: 'Password is required'),
    MinLengthValidator(6,
        errorText: 'Password must have at least 6 characters.'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: 'Passwords must contain a special character.')
  ]);

  static final validateMobile = MultiValidator([
    RequiredValidator(errorText: 'Mobile Number is required'),
    MinLengthValidator(10, errorText: 'Mobile number must be 10 digits.'),
    //PatternValidator(r'[0-9]', errorText: 'Mobile number must be 10 digits.'),
  ]);

  static final validateRequired = MultiValidator([
    RequiredValidator(errorText: 'Required'),
  ]);

  static final validateEmail = MultiValidator([
    RequiredValidator(errorText: 'Email is required'),
    EmailValidator(errorText: 'Invalid email address..'),
  ]);
}
