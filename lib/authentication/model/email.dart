import 'package:formz/formz.dart';

enum EmailValidationError { invalid }

class Email extends FormzInput<String, EmailValidationError> {
  const Email.pure() : super.pure('');
  const Email.dirty([String value = '']) : super.dirty(value);

  EmailValidationError validator(String value) {
    return value.isEmpty ? EmailValidationError.invalid : null;
  }
}
