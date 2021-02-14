import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import '../../model/model.dart';
import 'package:authentication_repository/authentication_repository.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this.authenticationRepository)
      : assert(authenticationRepository != null),
        super(SignUpState());

  AuthenticationRepository authenticationRepository;

  void nameChanged(String value) {
    final name = Name.dirty(value);
    emit(state.copyWith(
      name: name,
      status: Formz.validate([
        name,
        state.email,
        state.password,
        state.confirmedPassword,
      ]),
    ));
  }

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([
        state.name,
        email,
        state.password,
        state.confirmedPassword,
      ]),
    ));
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(state.copyWith(
      password: password,
      status: Formz.validate([
        state.name,
        state.email,
        password,
        state.confirmedPassword,
      ]),
    ));
  }

  void confirmedPasswordChanged(String value) {
    final confirmedPassword =
        ConfirmedPassword.dirty(password: state.password.value, value: value);
    emit(state.copyWith(
      confirmedPassword: confirmedPassword,
      status: Formz.validate([
        state.name,
        state.email,
        state.password,
        confirmedPassword,
      ]),
    ));
  }

  void signUpFormSubmitted() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      bool val = await authenticationRepository.signUp(
          name: state.name.value,
          email: state.email.value,
          password: state.password.value);
      print(val);
      if (val) {
        emit(state.copyWith(
          // name: Name.pure(),
          // email: Email.pure(),
          // password: Password.pure(),
          // confirmedPassword: ConfirmedPassword.pure(),
          status: FormzStatus.submissionSuccess,
        ));
      } else {
        emit(state.copyWith(
            userPresent: true, status: FormzStatus.submissionFailure));
      }
    } on Exception {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
