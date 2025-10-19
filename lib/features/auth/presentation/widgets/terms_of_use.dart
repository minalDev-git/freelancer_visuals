import 'package:animations/animations.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:freelancer_visuals/features/auth/presentation/widgets/policy_dialog.dart';

class TermsOfUse extends StatelessWidget {
  const TermsOfUse({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: 'By creating an account, you are agreeing to our\n',
          style: Theme.of(context).textTheme.bodyMedium,
          children: [
            TextSpan(
              text: 'Terms & Conditions ',
              style: const TextStyle(fontWeight: FontWeight.bold),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  // Open diaglog of Terms & conditions
                  showModal(
                    context: context,
                    configuration: const FadeScaleTransitionConfiguration(),
                    builder: (context) {
                      return PolicyDialog(mdFileName: 'terms_conditions.md');
                    },
                  );
                },
            ),
            const TextSpan(text: 'and '),
            TextSpan(
              text: 'Privacy Policy',
              style: const TextStyle(fontWeight: FontWeight.bold),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  // Open diaglog of Privacy policy
                  showModal(
                    context: context,
                    configuration: const FadeScaleTransitionConfiguration(),
                    builder: (context) {
                      return PolicyDialog(mdFileName: 'privacy_policy.md');
                    },
                  );
                },
            ),
          ],
        ),
      ),
    );
  }
}
