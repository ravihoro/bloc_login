import 'package:bloc_login/sign_up/pages/sign_up_page.dart';
import 'package:formz/formz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/login_cubit.dart';

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<LoginCubit, LoginState>(
          listener: (context, state) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            if (state.status.isSubmissionFailure) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  'Login Failed',
                ),
              ));
            }
            if (state.userPresent == false &&
                state.status.isSubmissionSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  'User not found. Please sign up to create account.',
                ),
              ));
            }
          },
        ),
        // BlocListener<AuthenticationBloc, AuthenticationState>(
        //   listener: (context, state) {
        //     print("State of user is: ${state.user == User.empty}");
        //     if (state.user == User.empty) {
        //       ScaffoldMessenger.of(context).hideCurrentSnackBar();
        //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //         content: Text(
        //           'User not found. Please sign up.',
        //         ),
        //       ));
        //     }
        //   },
        // ),
      ],
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _EmailInput(),
          const SizedBox(
            height: 8.0,
          ),
          _PasswordInput(),
          const SizedBox(
            height: 8.0,
          ),
          _LoginButton(),
          const SizedBox(
            height: 8.0,
          ),
          _SignUpButton(),
        ],
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return BlocListener<LoginCubit, LoginState>(
  //     listener: (context, state) {
  //       if (state.status.isSubmissionFailure) {
  //         ScaffoldMessenger.of(context).hideCurrentSnackBar();
  //         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //           content: Text(
  //             'Login Failed',
  //           ),
  //         ));
  //       }

  //       // if (state.status.isSubmissionSuccess) {
  //       //   ScaffoldMessenger.of(context).hideCurrentSnackBar();
  //       //   String message = "";
  //       //   if (state.userPresent) {
  //       //     message = "Login successful";
  //       //   } else {
  //       //     message = "User not found";
  //       //   }
  //       //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       //     content: Text(
  //       //       message,
  //       //     ),
  //       //   ));
  //       // }
  //     },
  //     child: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       children: [
  //         _EmailInput(),
  //         const SizedBox(
  //           height: 8.0,
  //         ),
  //         _PasswordInput(),
  //         const SizedBox(
  //           height: 8.0,
  //         ),
  //         _LoginButton(),
  //         const SizedBox(
  //           height: 8.0,
  //         ),
  //         _SignUpButton(),
  //       ],
  //     ),
  //   );
  // }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_emailInput_textField'),
          onChanged: (email) => context.read<LoginCubit>().emailChanged(email),
          decoration: InputDecoration(
            labelText: 'Email',
            errorText: state.email.invalid ? 'Invalid email' : null,
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_passwordInput_textField'),
          onChanged: (password) =>
              context.read<LoginCubit>().passwordChanged(password),
          decoration: InputDecoration(
            labelText: 'Password',
            errorText: state.password.invalid ? 'Invalid password' : null,
          ),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? CircularProgressIndicator()
            : RaisedButton(
                key: const Key('loginForm_login_raisedButton'),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Text('Login'),
                onPressed: state.status.isValidated
                    ? () {
                        context.read<LoginCubit>().loginFormSubmitted();
                      }
                    : null,
              );
      },
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text('Sign Up'),
      onPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => SignUpPage()));
      },
    );
  }
}
