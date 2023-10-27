import 'package:activity_tracker/core/constants/colors.dart';
import 'package:activity_tracker/core/utils/validation_functions.dart';
import 'package:flutter/material.dart';

class PasswordTextField extends StatelessWidget {

  final TextEditingController _passwordController;
  const PasswordTextField(this._passwordController, {super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _passwordController,
      decoration: InputDecoration(
        filled: true,
        hintText: "Password",
        prefixIcon: const Icon(Icons.password),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
        )
      ),
      obscureText: true,
      validator: (password) => password.isValid(),
    );
  }
}