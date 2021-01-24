import 'package:formz/formz.dart';
import 'package:bloc/bloc.dart';
import '../../model/model.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState());

  emailChanged(String value) {
    Email email = Email.dirty(value);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([
        email,
        state.password,
      ]),
    ));
  }

  passwordChanged(String value) {
    Password password = Password.dirty(value);
    emit(state.copyWith(
      password: password,
      status: Formz.validate([
        state.email,
        password,
      ]),
    ));
  }

  loginFormSubmitted() {}
}
