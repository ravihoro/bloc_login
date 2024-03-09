import 'package:bloc_login/core/utils/injection_container.dart';
import 'package:bloc_login/core/widgets/authentication_scaffold.dart';
import 'package:bloc_login/features/sign_up/presentation/bloc/sign_up_cubit.dart';
import 'package:bloc_login/features/sign_up/presentation/pages/sign_up_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => SignUpPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpCubit>(
      create: (_) => sl<SignUpCubit>(),
      child: AuthenticationScaffold(
        text: 'Sign Up',
        child: SignUpForm(),
      ),
    );
  }
}
