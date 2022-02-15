import 'package:flutter/material.dart';

class AuthTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String? errorText;
  final String? Function(String?)? validator;
  final bool obscureText;

  const AuthTextFormField({
    Key? key,
    this.controller,
    this.labelText,
    this.errorText,
    this.validator,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 35,
        vertical: 5,
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          errorText: errorText,
        ),
        validator: validator,
        obscureText: obscureText,
      ),
    );
  }
}
