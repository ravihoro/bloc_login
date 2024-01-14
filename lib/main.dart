import 'package:bloc_login/app.dart';
import 'package:bloc_login/core/utils/injection_container.dart';
import 'package:bloc_login/features/authentication/data/data_source/authentication_data_source.dart';
import 'package:bloc_login/features/authentication/data/repository/authentication_repository_impl.dart';
import 'package:bloc_login/features/authentication/domain/repository/authentication_repository.dart';
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
      // home: App(
      //   authenticationRepository: AuthenticationRepositoryImpl(
      //     AuthenticationDataSourceImpl(),
      //   ),
      // ),
    );
  }
}
