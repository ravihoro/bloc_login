import 'package:bloc_login/core/error/failure.dart';
import 'package:bloc_login/core/model/user_model.dart';
import 'package:bloc_login/features/sign_up/domain/repository/sign_up_repository.dart';
import 'package:dartz/dartz.dart';

class SignUpUsecase {
  final SignUpRepository signUpRepository;

  const SignUpUsecase({required this.signUpRepository});

  Future<Either<Failure, User>> signUp({
    required String username,
    required String email,
    required String password,
  }) async {
    return signUpRepository.signUp(
      username: username,
      email: email,
      password: password,
    );
  }
}
