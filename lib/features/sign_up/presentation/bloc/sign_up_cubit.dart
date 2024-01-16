import 'package:bloc_login/features/sign_up/presentation/bloc/sign_up_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final SignUpState? initialState;

  SignUpCubit({
    this.initialState,
  }) : super(initialState ?? SignUpState());

  setName(String value) {
    emit(state.copyWith(name: value));
  }

  setEmail(String value) {
    emit(state.copyWith(email: value));
  }

  setPassword(String value) {
    emit(state.copyWith(password: value));
  }
}
