part of 'authentication_cubit.dart';

class AuthenticationState extends Equatable {
  final User user;
  final bool isLoading;
  final String error;

  const AuthenticationState({
    this.user = User.empty,
    this.error = "",
    this.isLoading = false,
  });

  AuthenticationState copyWith({
    User? user,
    String error = "",
    bool isLoading = false,
  }) =>
      AuthenticationState(
        user: user ?? this.user,
        error: error,
        isLoading: isLoading,
      );

  @override
  List<Object?> get props => [
        user,
        error,
        isLoading,
      ];
}
