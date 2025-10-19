import 'package:flutter/material.dart';

class TextEditor extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final ValueChanged<String>? onChanged;
  const TextEditor({
    super.key,
    required this.controller,
    required this.hintText,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hint: Row(children: [Text(hintText, style: TextStyle(fontSize: 16))]),
        // hintText: hintText,
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "$hintText is missing!";
        }
        // Check for email
        if (hintText.toLowerCase().contains("Amount \$")) {
          if (double.tryParse(value) == null) {
            return "Enter a valid number";
          }
        }
        return null;
      },
    );
  }
}
