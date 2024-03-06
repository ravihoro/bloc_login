import 'package:flutter/material.dart';

class AuthenticationScaffold<T> extends StatelessWidget {
  final String text;
  final Widget child;

  const AuthenticationScaffold({
    required this.text,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Card(
            color: Colors.grey[00],
            elevation: 10.0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  child,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
