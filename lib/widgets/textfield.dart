import 'package:flutter/material.dart';

class MyAppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final TextInputType? keyboardType;
  final bool obscure;
  final String? Function(String? value)? validator;

  const MyAppTextField(
      {super.key,
      this.controller,
      this.label,
      this.keyboardType,
      this.obscure = false,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      keyboardType: keyboardType,
      obscureText: obscure,
      controller: controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: label,
      ),
    );
  }
}
