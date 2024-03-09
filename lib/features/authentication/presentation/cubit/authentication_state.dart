part of 'authentication_cubit.dart';

class AuthenticationState extends Equatable {
  final User user;
  final bool isLoading;
  final bool isLoginPage;
  final String error;

  const AuthenticationState({
    this.user = User.empty,
    this.error = "",
    this.isLoginPage = true,
    this.isLoading = false,
  });

  AuthenticationState copyWith({
    User? user,
    String error = "",
    bool isLoading = false,
    bool? isLoginPage,
  }) =>
      AuthenticationState(
        user: user ?? this.user,
        error: error,
        isLoading: isLoading,
        isLoginPage: isLoginPage ?? this.isLoginPage,
      );

  @override
  List<Object?> get props => [
        user,
        error,
        isLoading,
        isLoginPage,
      ];
}
