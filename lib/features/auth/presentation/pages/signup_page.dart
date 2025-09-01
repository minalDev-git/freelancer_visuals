import 'package:flutter/material.dart';
import 'package:freelancer_visuals/core/theme/app_pallete.dart';
import 'package:freelancer_visuals/features/auth/presentation/widgets/auth_button.dart';
import 'package:freelancer_visuals/features/auth/presentation/widgets/auth_fields.dart';
import 'package:freelancer_visuals/features/auth/presentation/widgets/auth_google.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // formKey.currentState!.validate();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppPallete.transparentColor,
        leading: IconButton(
          onPressed: () {
            Navigator.of(
              context,
            ).pushNamedAndRemoveUntil('/login/', (route) => false);
          },
          icon: Icon(Icons.arrow_back_ios_rounded),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Getting Started with \nFreelancer Financial Dashboard!',
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 50),
                AuthField(hintText: 'Username', controller: _nameController),
                const SizedBox(height: 20),
                AuthField(hintText: 'Email', controller: _emailController),
                const SizedBox(height: 20),
                AuthField(
                  hintText: 'Password',
                  isObsecureText: true,
                  controller: _passwordController,
                ),
                const SizedBox(height: 30),
                Text(
                  'By continuing you agree to our',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                RichText(
                  text: TextSpan(
                    text: 'Terms and Conditions ',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                    children: [
                      TextSpan(
                        text: 'and ',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      TextSpan(
                        text: 'Privacy Policy',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const AuthButton(text: 'Sign Up'),
                const SizedBox(height: 20),
                const Text(
                  'or',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppPallete.greyColor,
                  ),
                ),
                const SizedBox(height: 10),
                const AuthGoogleButton(text: 'Continue with Google'),
                const SizedBox(height: 15),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(
                          context,
                        ).pushNamedAndRemoveUntil('/login/', (route) => false);
                      },
                      child: RichText(
                        text: TextSpan(
                          text: 'Already have an account? ',
                          style: Theme.of(context).textTheme.titleMedium,
                          children: [
                            TextSpan(
                              text: 'Sign In',
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(
                                    color: AppPallete.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
