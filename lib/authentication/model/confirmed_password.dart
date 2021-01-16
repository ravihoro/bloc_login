import 'package:formz/formz.dart';
import 'package:meta/meta.dart';

enum ConfirmedPasswordValidationError { invalid }

class ConfirmedPassword
    extends FormzInput<String, ConfirmedPasswordValidationError> {
  final String password;

  const ConfirmedPassword.pure({this.password}) : super.pure('');
  const ConfirmedPassword.dirty({@required this.password, String value = ''})
      : super.dirty(value);

  ConfirmedPasswordValidationError validator(String value) {
    return value == password ? null : ConfirmedPasswordValidationError.invalid;
  }
}
