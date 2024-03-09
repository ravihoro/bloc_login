import 'package:bloc_login/core/widgets/custom_text_form_field.dart';
import 'package:bloc_login/features/sign_up/presentation/bloc/sign_up_cubit.dart';
import 'package:bloc_login/features/sign_up/presentation/bloc/sign_up_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpEmailInput extends StatelessWidget {
  const SignUpEmailInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return CustomTextFormField(
          fieldKey: 'signUpForm_emailInput_textField',
          onChanged: (email) => context.read<SignUpCubit>().setEmail(email),
          labelText: 'Email',
        );
      },
    );
  }
}
