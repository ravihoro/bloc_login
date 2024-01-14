import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc_login/app.dart';
import 'package:bloc_login/core/utils/injection_container.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await init();

  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'bloc login',
      home: App(
        authenticationRepository: AuthenticationRepository(),
      ),
    );
  }
}
