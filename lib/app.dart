import 'dart:developer';

import 'package:bloc_login/features/authentication/domain/entity/user.dart';
import 'package:bloc_login/features/authentication/domain/repository/authentication_repository.dart';
import 'package:bloc_login/features/authentication/domain/usecase/login.dart';
import 'package:bloc_login/features/authentication/domain/usecase/sign_up.dart';
import 'package:bloc_login/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:bloc_login/home_page.dart';
import 'package:bloc_login/login/pages/login_page.dart';
import 'package:bloc_login/splash.dart';
//import 'package:bloc_login/sign_up/pages/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  final AuthenticationRepository authenticationRepository;

  App({
    Key? key,
    required this.authenticationRepository,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
    // return RepositoryProvider.value(
    //   value: authenticationRepository,
    //   child: BlocProvider<AuthenticationCubit>(
    //     create: (_) => AuthenticationCubit(
    //       login: Login(),
    //       signUp: SignUp(),
    //     ),
    //     child: AppView(),
    //   ),
    // );
  }
}

class AppView extends StatefulWidget {
  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState as NavigatorState;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<AuthenticationCubit, AuthenticationState>(
          listener: (context, state) {
            log("User is: ${state.user == User.empty}");
            if (state.user == User.empty) {
              _navigator.pushAndRemoveUntil<void>(
                  LoginPage.route(), (route) => false);
            } else {
              _navigator.pushAndRemoveUntil<void>(
                  HomePage.route(), (route) => false);
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => SplashPage.route(),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     home: BlocListener<AuthenticationBloc, AuthenticationState>(
  //       listener: (context, state) {
  //         if (state.user == User.empty) {
  //           Navigator.of(context).pushAndRemoveUntil(
  //               MaterialPageRoute(builder: (context) => LoginPage()),
  //               (route) => false);
  //         } else {
  //           Navigator.of(context).pushAndRemoveUntil(
  //               MaterialPageRoute(builder: (context) => HomePage()),
  //               (route) => false);
  //         }
  //       },
  //     ),
  //   );
  // }
}
