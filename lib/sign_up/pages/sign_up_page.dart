import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/sign_up_cubit.dart';
import 'package:flutter/material.dart';
import 'sign_up_form.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'Sign Up',
      )),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocProvider<SignUpCubit>(
          create: (_) => SignUpCubit(),
          child: SignUpForm(),
        ),
      ),
    );
  }
}
