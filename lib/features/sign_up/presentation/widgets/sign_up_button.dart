import 'package:bloc_login/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:bloc_login/features/sign_up/presentation/bloc/sign_up_cubit.dart';
import 'package:bloc_login/features/sign_up/presentation/bloc/sign_up_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: ((previous, current) => previous.isValid != current.isValid),
      builder: (context, state) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          onPressed: state.isValid
              ? () {
                  context.read<AuthenticationCubit>().signUp(
                        name: state.name,
                        email: state.email,
                        password: state.password,
                      );
                }
              : null,
          child: Text('Sign Up'),
        );
      },
    );
  }
}
