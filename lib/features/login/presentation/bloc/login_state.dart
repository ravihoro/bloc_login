import 'package:equatable/equatable.dart';

import '../../../../core/model/user_model.dart';

class LoginState extends Equatable {
  final bool isLoading;
  final User? user;
  final String errorString;

  const LoginState({
    this.isLoading = false,
    this.user,
    this.errorString = '',
  });

  LoginState copyWith({
    bool? isLoading,
    User? user,
    String? errorString,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      user: user,
      errorString: errorString ?? this.errorString,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        user,
        errorString,
      ];
}