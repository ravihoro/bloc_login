import 'dart:convert';
import 'dart:developer';
import 'package:bloc_login/features/authentication/data/model/user_model.dart';
import 'package:bloc_login/features/authentication/domain/entity/user.dart';
import 'package:bloc_login/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:bloc_login/features/login/presentation/pages/login_page.dart';
import 'package:bloc_login/home_page.dart';
import 'package:bloc_login/splash.dart';
//import 'package:bloc_login/sign_up/pages/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppView extends StatefulWidget {
  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    checkIfUserIsLoggedIn();
  }

  void checkIfUserIsLoggedIn() async {
    await SharedPreferences.getInstance().then(
      (prefs) {
        var value = prefs.getString('user');
        log("prefs value: $value");
        var user = value == null || value.isEmpty
            ? User.empty
            : UserModel.fromJson(jsonDecode(value));
        context.read<AuthenticationCubit>().emitUser(user);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) async {
        log("User is: ${state.user != User.empty}");
        if (state.user == User.empty) {
          Navigator.of(context).push(LoginPage.route());
        } else {
          await SharedPreferences.getInstance().then(
            (prefs) => prefs.setString(
              'user',
              jsonEncode((state.user as UserModel).toJson()),
            ),
          );
          Navigator.of(context).push(
            HomePage.route(),
          );
        }
      },
      child: Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
