import 'package:formz/formz.dart';

enum PasswordValidationError { invalid }

class Password extends FormzInput<String, PasswordValidationError> {
  const Password.pure() : super.pure('');
  const Password.dirty([String value = '']) : super.dirty(value);

  PasswordValidationError validator(String value) {
    return value.isEmpty ? PasswordValidationError.invalid : null;
  }
}
