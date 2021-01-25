part of 'authentication_bloc.dart';

class AuthenticationState {
  final User user;

  const AuthenticationState._({this.user = User.empty});

  const AuthenticationState.unknown() : this._();

  const AuthenticationState.authenticated(User user) : this._(user: user);

  const AuthenticationState.unauthenticated() : this._(user: User.empty);
}
