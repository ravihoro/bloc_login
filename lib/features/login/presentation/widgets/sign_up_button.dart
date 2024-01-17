import 'package:flutter/material.dart';

class SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text('Sign Up'),
      onPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Container()));
      },
    );
  }
}
