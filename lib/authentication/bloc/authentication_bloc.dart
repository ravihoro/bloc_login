import 'package:authentication_repository/authentication_repository.dart';
import 'dart:async';
import 'package:bloc/bloc.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository authenticationRepository;

  //late StreamSubscription<User> _userSubscription;

  AuthenticationBloc({
    required this.authenticationRepository,
  }) : super(AuthenticationState.unknown()) {
    // _userSubscription = authenticationRepository.user
    //     .listen((user) => add(AuthenticationUserChanged(user)));
    on((event, emit) async* {
      if (event is AuthenticationUserChanged) {
        emit(AuthenticationState.authenticated(event.user));
      } else if (event is AuthenticationLogoutRequested) {
        authenticationRepository.logOut();
      }
    });
  }

  @override
  Future<void> close() {
    //_userSubscription.cancel();
    authenticationRepository.dispose();
    return super.close();
  }
}
