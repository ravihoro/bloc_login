part of 'authentication_bloc.dart';

abstract class AuthenticationEvent {
  const AuthenticationEvent();
}

class AuthenticationUserChanged extends AuthenticationEvent {
  final User user;

  const AuthenticationUserChanged(this.user);
}

class AuthenticationLogoutRequested extends AuthenticationEvent {}
