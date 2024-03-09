import 'package:bloc_login/app_view.dart';
import 'package:bloc_login/core/error/failure.dart';
import 'package:bloc_login/core/utils/injection_container.dart';
import 'package:bloc_login/features/authentication/domain/entity/user.dart';
import 'package:bloc_login/features/authentication/domain/usecase/login.dart';
import 'package:bloc_login/features/authentication/domain/usecase/sign_up.dart';
import 'package:bloc_login/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:bloc_login/home_page.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mocktail/mocktail.dart';

class MockLogin extends Mock implements Login {}

class MockSignUp extends Mock implements SignUp {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  var login = MockLogin();
  var signUp = MockSignUp();

  var email = "ravi@gmail.com";
  var password = "123456";
  const id = "1";
  const name = "Ravi";

  var user = User(id: id, name: name, email: email);

  Future<void> initialise(WidgetTester tester) async {
    await init(isMock: true);
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(builder: (context) {
          return BlocProvider<AuthenticationCubit>(
            create: (_) => AuthenticationCubit(
              login: login,
              signUp: signUp,
            ),
            child: AppView(),
          );
        }),
      ),
    );

    await tester.pumpAndSettle();

    var emailTextFieldFinder =
        find.byKey(ValueKey("loginForm_emailInput_textField"));

    await tester.enterText(emailTextFieldFinder, "ravi@gmail.com");

    await tester.pumpAndSettle();

    var passwordTextFieldFinder =
        find.byKey(ValueKey("loginForm_passwordInput_textField"));

    await tester.enterText(passwordTextFieldFinder, "123456");

    await tester.pumpAndSettle();

    var buttonFinder = find.byKey(ValueKey("loginForm_login_elevatedButton"));

    await tester.tap(buttonFinder);

    await tester.pumpAndSettle();
  }

  testWidgets(
    'should be a successful login flow',
    (tester) async {
      when(() => login(email: email, password: password))
          .thenAnswer((_) async => Right(user));

      await initialise(tester);

      var homePageFinder = find.byType(HomePage);

      expect(homePageFinder, findsOneWidget);
    },
  );

  testWidgets(
    'should be a failed login flow due to user not existing',
    (tester) async {
      when(() => login(email: email, password: password)).thenAnswer(
          (_) async => Left(LoginFailure(error: "User does not exist")));

      await initialise(tester);

      var textFinder = find.text('User does not exist');

      expect(textFinder, findsOneWidget);
    },
  );

  testWidgets(
    'should be a failed login flow due to server exception',
    (tester) async {
      when(() => login(email: email, password: password))
          .thenAnswer((_) async => Left(ServerFailure(error: "Server issue")));

      await initialise(tester);

      var textFinder = find.text('Server issue');

      expect(textFinder, findsOneWidget);
    },
  );

  testWidgets(
    'should be a failed login flow due to other issues',
    (tester) async {
      when(() => login(email: email, password: password)).thenAnswer(
          (_) async => Left(GenericFailure(error: "Some error occured")));

      await initialise(tester);

      var textFinder = find.text('Some error occured');

      expect(textFinder, findsOneWidget);
    },
  );
}
