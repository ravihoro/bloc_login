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

    var signUpTextButtonFinder = find.byKey(ValueKey("sign_up_navigation_key"));

    await tester.tap(signUpTextButtonFinder);

    await tester.pumpAndSettle();

    var nameTextFieldFinder =
        find.byKey(ValueKey("signUpForm_nameInput_textField"));

    await tester.enterText(nameTextFieldFinder, name);

    await tester.pumpAndSettle();

    var emailTextFieldFinder =
        find.byKey(ValueKey("signUpForm_emailInput_textField"));

    await tester.enterText(emailTextFieldFinder, "ravi@gmail.com");

    await tester.pumpAndSettle();

    var passwordTextFieldFinder =
        find.byKey(ValueKey("signUpForm_passwordInput_textField"));

    await tester.enterText(passwordTextFieldFinder, "123456");

    await tester.pumpAndSettle();

    var buttonFinder = find.byKey(ValueKey("signUpForm_signUp_elevatedButton"));

    await tester.tap(buttonFinder);

    await tester.pumpAndSettle();
  }

  testWidgets(
    'should be a successful signUp flow',
    (tester) async {
      when(() => signUp(name: name, email: email, password: password))
          .thenAnswer((_) async => Right(user));

      await initialise(tester);

      var homePageFinder = find.byType(HomePage);

      expect(homePageFinder, findsOneWidget);
    },
  );

  testWidgets(
    'should be a failed sign up flow due to user already existing',
    (tester) async {
      when(() => signUp(name: name, email: email, password: password))
          .thenAnswer(
              (_) async => Left(SignUpFailure(error: "User already exists")));

      await initialise(tester);

      var textFinder = find.text('User already exists');

      expect(textFinder, findsOneWidget);
    },
  );

  testWidgets(
    'should be a failed sign up flow due to server exception',
    (tester) async {
      when(() => signUp(name: name, email: email, password: password))
          .thenAnswer((_) async => Left(ServerFailure(error: "Server issue")));

      await initialise(tester);

      var textFinder = find.text('Server issue');

      expect(textFinder, findsOneWidget);
    },
  );

  testWidgets(
    'should be a failed sign up flow due to other issues',
    (tester) async {
      when(() => signUp(name: name, email: email, password: password))
          .thenAnswer(
              (_) async => Left(GenericFailure(error: "Some error occured")));

      await initialise(tester);

      var textFinder = find.text('Some error occured');

      expect(textFinder, findsOneWidget);
    },
  );
}
