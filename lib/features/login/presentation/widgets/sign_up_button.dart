import 'package:bloc_login/features/sign_up/presentation/pages/sign_up_page.dart';
import 'package:flutter/material.dart';

class SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text('Sign Up'),
      onPressed: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => SignUpPage(),
          ),
        );
      },
    );
  }
}
