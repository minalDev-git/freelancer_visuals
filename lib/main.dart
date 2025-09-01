import 'package:flutter/material.dart';
import 'package:freelancer_visuals/core/theme/theme.dart';
import 'package:freelancer_visuals/features/auth/presentation/pages/login_page.dart';
import 'package:freelancer_visuals/features/auth/presentation/pages/signup_page.dart';
// import 'package:freelancer_visuals/features/auth/presentation/pages/signup_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Freelancer Financial Dashboard',
      theme: AppTheme.lightThemeMode,
      darkTheme: AppTheme.darkThemeMode,
      themeMode: ThemeMode.system,
      // darkTheme: AppTheme.darkThemeMode,
      routes: {
        '/login/': (context) => const LoginPage(),
        '/signup/': (context) => const SignupPage(),
      },
      home: const LoginPage(),
    );
  }
}
