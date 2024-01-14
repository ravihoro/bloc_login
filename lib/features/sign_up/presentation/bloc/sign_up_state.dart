import 'package:bloc_login/features/authentication/domain/entity/user.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/model/user_model.dart';

class SignUpState extends Equatable {
  final bool isLoading;
  final User? user;
  final String errorString;

  const SignUpState({this.isLoading = false, this.user, this.errorString = ''});

  SignUpState copyWith({
    bool? isLoading,
    User? user,
    String? errorString,
  }) {
    return SignUpState(
      isLoading: isLoading ?? this.isLoading,
      user: user,
      errorString: errorString ?? '',
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        user,
        errorString,
      ];
}
