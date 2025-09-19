import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelancer_visuals/core/theme/theme.dart';
import 'package:freelancer_visuals/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:freelancer_visuals/features/auth/presentation/pages/login_page.dart';
// import 'package:freelancer_visuals/features/auth/presentation/pages/onboarding.dart';
import 'package:freelancer_visuals/features/auth/presentation/pages/signup_page.dart';
import 'package:freelancer_visuals/features/auth/presentation/widgets/policy_screen.dart';
import 'package:freelancer_visuals/features/auth/presentation/widgets/terms_screen.dart';
import 'package:freelancer_visuals/init_dependencies.dart';
// import 'package:freelancer_visuals/features/auth/presentation/pages/signup_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(
    MultiBlocProvider(
      providers: [BlocProvider(create: (_) => serviceLocator<AuthBloc>())],
      child: const MyApp(),
    ),
  );
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
        '/terms/': (context) => const TermsScreen(
          title: 'Terms & Conditions',
          assetPath: 'assets/app_policy/terms_conditions.md',
        ),
        '/policy/': (context) => const PolicyScreen(
          title: 'Privacy Ploicy',
          assetPath: 'assets/app_policy/privacy_policy.md',
        ),
      },
      // home: const OnboardingScreen(),
      home: const LoginPage(),
    );
  }
}
