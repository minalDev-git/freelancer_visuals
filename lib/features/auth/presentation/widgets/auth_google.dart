import 'package:flutter/material.dart';
import 'package:freelancer_visuals/core/theme/app_pallete.dart';

class AuthGoogleButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const AuthGoogleButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppPallete.transparentColor,
          shadowColor: AppPallete.transparentColor,
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              color: AppPallete.lightEnabledBorder,
              width: 3,
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logos/google_logo.png', width: 20, height: 20),
            const SizedBox(width: 10),
            Text(
              text,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
