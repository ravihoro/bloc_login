import 'package:bloc_login/core/widgets/custom_text_form_field.dart';
import 'package:bloc_login/features/sign_up/presentation/bloc/sign_up_cubit.dart';
import 'package:bloc_login/features/sign_up/presentation/bloc/sign_up_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPasswordInput extends StatelessWidget {
  const SignUpPasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return CustomTextFormField(
          fieldKey: 'signUpForm_passwordInput_textField',
          onChanged: (password) =>
              context.read<SignUpCubit>().setPassword(password),
          labelText: 'Password',
        );
      },
    );
  }
}
