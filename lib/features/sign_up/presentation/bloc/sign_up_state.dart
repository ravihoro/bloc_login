import 'package:equatable/equatable.dart';

class SignUpState extends Equatable {
  final bool isLoading;
  final bool isSignUpSuccessful;
  final String error;

  const SignUpState(
      {this.isLoading = false,
      this.isSignUpSuccessful = false,
      this.error = ''});

  SignUpState copyWith(
      {bool? isLoading, bool? isSignUpSuccessful, String? error}) {
    return SignUpState(
      isLoading: isLoading ?? this.isLoading,
      isSignUpSuccessful: isSignUpSuccessful ?? this.isSignUpSuccessful,
      error: error ?? '',
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        isSignUpSuccessful,
        error,
      ];
}
