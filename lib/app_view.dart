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
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    checkIfUserIsLoggedIn();
  }

  void checkIfUserIsLoggedIn() async {
    await SharedPreferences.getInstance().then(
      (prefs) {
        var value = prefs.getString('user');
        var user =
            value == null ? User.empty : UserModel.fromJson(jsonDecode(value));
        context.read<AuthenticationCubit>().emitUser(user);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        log("User is: ${state.user != User.empty}");
        if (state.user == User.empty) {
          Navigator.of(context).push(LoginPage.route());
        } else {
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
