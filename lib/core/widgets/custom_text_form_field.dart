import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final String fieldKey;
  final Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final bool obscureText;

  const CustomTextFormField({
    required this.labelText,
    required this.fieldKey,
    this.onChanged,
    this.validator,
    this.obscureText = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: ValueKey(fieldKey),
      onChanged: onChanged,
      validator: validator,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        //errorText: isValidEmail(state.email),
      ),
    );
  }
}
