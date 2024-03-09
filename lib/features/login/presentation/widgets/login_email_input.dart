import 'package:bloc_login/core/utils/validators.dart';
import 'package:bloc_login/core/widgets/custom_text_form_field.dart';
import 'package:bloc_login/features/login/presentation/bloc/login_cubit.dart';
import 'package:bloc_login/features/login/presentation/bloc/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginEmailInput extends StatelessWidget {
  const LoginEmailInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return CustomTextFormField(
          fieldKey: 'loginForm_emailInput_textField',
          onChanged: (email) => context.read<LoginCubit>().setEmail(email),
          labelText: 'Email',
        );
      },
    );
  }
}
