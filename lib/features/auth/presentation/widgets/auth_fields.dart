import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isObsecureText;
  const AuthField({
    super.key,
    required this.hintText,
    required this.controller,
    this.isObsecureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 18),
      ),
      style: TextStyle(fontSize: 20),
      autocorrect: true,
      obscureText: isObsecureText,
      validator: (value) {
        if (value!.isEmpty) {
          return "$hintText is missing!";
        }
        // Check for email
        if (hintText.toLowerCase().contains("email")) {
          final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
          if (!emailRegex.hasMatch(value)) {
            return "Please enter a valid email";
          }
        }

        // Check for password
        if (hintText.toLowerCase().contains("password")) {
          if (value.length < 6) {
            return "Password should contain at least 6 characters";
          }
        }
        return null;
      },
    );
  }
}
