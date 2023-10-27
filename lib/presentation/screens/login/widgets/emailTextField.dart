import 'package:activity_tracker/core/constants/colors.dart';
import 'package:activity_tracker/core/utils/validation_functions.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class EmailTextField extends StatelessWidget {

  final TextEditingController _emailController;
  const EmailTextField(this._emailController, {super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _emailController,
      decoration: InputDecoration(
        filled: true,
        hintText:"Email",
        prefixIcon: const Icon(Icons.person),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      keyboardType: TextInputType.emailAddress,
      autofillHints: const [AutofillHints.email],
      validator: (email) => email.isValid() ?? (EmailValidator.validate(email!) ? null : "Please Enter Valid Email"),
    );
  }
}