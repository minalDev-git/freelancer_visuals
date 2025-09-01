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
        hintStyle: TextStyle(fontSize: 20),
      ),
      style: TextStyle(fontSize: 20),
      autocorrect: true,
      obscureText: isObsecureText,
      validator: (value) {
        if (value!.isEmpty) {
          return "$hintText is missing!";
        }
        return null;
      },
    );
  }
}
