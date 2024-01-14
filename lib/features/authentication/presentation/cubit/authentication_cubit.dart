import 'package:bloc/bloc.dart';
import 'package:bloc_login/features/authentication/domain/entity/user.dart';
import 'package:equatable/equatable.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final AuthenticationState? initialState;

  AuthenticationCubit({
    this.initialState,
  }) : super(initialState ?? AuthenticationState(user: User.empty));

  setUser(User user) {
    emit(state.copyWith(user));
  }
}
