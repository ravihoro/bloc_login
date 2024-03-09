import 'package:bloc_login/core/widgets/custom_text_form_field.dart';
import 'package:bloc_login/features/sign_up/presentation/bloc/sign_up_cubit.dart';
import 'package:bloc_login/features/sign_up/presentation/bloc/sign_up_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpNameInput extends StatelessWidget {
  const SignUpNameInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return CustomTextFormField(
          fieldKey: 'signUpForm_nameInput_textField',
          onChanged: (name) => context.read<SignUpCubit>().setName(name),
          labelText: 'Name',
        );
      },
    );
  }
}
