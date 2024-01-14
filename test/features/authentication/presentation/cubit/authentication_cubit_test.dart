import 'package:bloc_login/features/authentication/domain/entity/user.dart';
import 'package:bloc_login/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:bloc_test/bloc_test.dart';

void main() {
  var user = User(
    id: "1",
    name: "ravi",
    email: "ravi@gmail.com",
    password: "",
  );

  blocTest<AuthenticationCubit, AuthenticationState>(
    'should be a successful user set',
    build: () => AuthenticationCubit(),
    act: (cubit) {
      cubit.setUser(user);
    },
    expect: () => [
      AuthenticationState(user: user),
    ],
  );
}
