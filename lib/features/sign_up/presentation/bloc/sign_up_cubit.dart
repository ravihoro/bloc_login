import 'package:bloc_login/core/utils/validators.dart';
import 'package:bloc_login/features/sign_up/presentation/bloc/sign_up_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final SignUpState? initialState;

  SignUpCubit({this.initialState}) : super(initialState ?? SignUpState());

  bool isValid({
    String? name,
    String? email,
    String? password,
  }) {
    name = name ?? state.name;
    email = email ?? state.email;
    password = password ?? state.password;
    return isValidName(name) == null &&
        isValidEmail(email) == null &&
        isValidPassword(password) == null;
  }

  setName(String? name) {
    emit(
      state.copyWith(
        name: name,
        isValid: isValid(
          name: name,
        ),
      ),
    );
  }

  setEmail(String? email) {
    emit(
      state.copyWith(
        email: email,
        isValid: isValid(
          email: email,
        ),
      ),
    );
  }

  setPassword(String? password) {
    emit(
      state.copyWith(
        password: password,
        isValid: isValid(
          password: password,
        ),
      ),
    );
  }
}
