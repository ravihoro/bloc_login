import 'package:authentication_repository/authentication_repository.dart';
import 'dart:async';
import 'package:bloc/bloc.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository authenticationRepository;

  late StreamSubscription<User> _userSubscription;

  AuthenticationBloc(
      {required AuthenticationRepository authenticationRepository})
      : assert(authenticationRepository != null),
        authenticationRepository = authenticationRepository,
        super(AuthenticationState.unknown()) {
    _userSubscription = authenticationRepository.user
        .listen((user) => add(AuthenticationUserChanged(user)));
  }

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AuthenticationUserChanged) {
      yield await _mapAuthenticatedUserChangedToState(event);
    } else if (event is AuthenticationLogoutRequested) {
      authenticationRepository.logOut();
    }
  }

  Future<AuthenticationState> _mapAuthenticatedUserChangedToState(
      AuthenticationUserChanged event) async {
    return event.user != User.empty
        ? AuthenticationState.authenticated(event.user)
        : const AuthenticationState.unauthenticated();
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    authenticationRepository.dispose();
    return super.close();
  }
}
