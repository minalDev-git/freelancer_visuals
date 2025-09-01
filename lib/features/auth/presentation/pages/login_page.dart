import 'package:flutter/material.dart';
import 'package:freelancer_visuals/core/theme/app_pallete.dart';
import 'package:freelancer_visuals/features/auth/presentation/widgets/auth_button.dart';
import 'package:freelancer_visuals/features/auth/presentation/widgets/auth_fields.dart';
import 'package:freelancer_visuals/features/auth/presentation/widgets/auth_google.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
            ).pushNamedAndRemoveUntil('/signup/', (route) => false);
          },
          icon: Icon(Icons.arrow_back_ios_rounded),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Welcome Back!',
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 50),
                const Text(
                  'Please enter your details',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                AuthField(hintText: 'Email', controller: _emailController),
                const SizedBox(height: 20),
                AuthField(
                  hintText: 'Password',
                  isObsecureText: true,
                  controller: _passwordController,
                ),
                const SizedBox(height: 30),
                const AuthButton(text: 'Sign In'),
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
                const AuthGoogleButton(text: 'Log In with Google'),
                const SizedBox(height: 15),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(
                          context,
                        ).pushNamedAndRemoveUntil('/signup/', (route) => false);
                      },
                      child: RichText(
                        text: TextSpan(
                          text: 'Don\'t have an account? ',
                          style: Theme.of(context).textTheme.titleMedium,
                          children: [
                            TextSpan(
                              text: 'Sign Up',
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
