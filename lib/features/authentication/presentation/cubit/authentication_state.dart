part of 'authentication_cubit.dart';

class AuthenticationState extends Equatable {
  final User user;
  final String error;

  const AuthenticationState({this.user = User.empty, this.error = ""});

  AuthenticationState copyWith({User user = User.empty, String error = ""}) =>
      AuthenticationState(
        user: user,
        error: error,
      );

  @override
  List<Object?> get props => [
        user,
        error,
      ];
}
