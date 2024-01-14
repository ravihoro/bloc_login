part of 'authentication_cubit.dart';

class AuthenticationState extends Equatable {
  final User user;

  const AuthenticationState({required this.user});

  AuthenticationState copyWith(User user) => AuthenticationState(user: user);

  @override
  List<Object?> get props => [
        user,
      ];
}
