import 'package:formz/formz.dart';
import 'package:bloc/bloc.dart';
import '../../model/model.dart';
import 'package:authentication_repository/authentication_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.authenticationRepository)
      : assert(authenticationRepository != null),
        super(LoginState());

  AuthenticationRepository authenticationRepository;

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([
        email,
        state.password,
      ]),
    ));
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(state.copyWith(
      password: password,
      status: Formz.validate([
        state.email,
        password,
      ]),
    ));
  }

  loginFormSubmitted() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      //emit(state.copyWith(status: FormzStatus.submissionSuccess));
      bool val = await authenticationRepository.login(
          email: state.email.value, password: state.password.value);
      //print("Value of val is $val");
      if (!val) {
        emit(state.copyWith(
            userPresent: false, status: FormzStatus.submissionSuccess));
      }
    } on Exception {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
