import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:freelancer_visuals/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:freelancer_visuals/core/theme/theme.dart';
import 'package:freelancer_visuals/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:freelancer_visuals/features/auth/presentation/pages/login_page.dart';

import 'package:freelancer_visuals/features/auth/presentation/pages/signup_page.dart';

import 'package:freelancer_visuals/features/projects/presentation/bloc/client/client_bloc.dart';
import 'package:freelancer_visuals/features/projects/presentation/bloc/invoice/invoice_bloc.dart';
import 'package:freelancer_visuals/features/projects/presentation/bloc/project/project_bloc.dart';

import 'package:freelancer_visuals/features/projects/presentation/pages/add_new_client.dart';
import 'package:freelancer_visuals/features/projects/presentation/pages/all_clients.dart';
import 'package:freelancer_visuals/features/projects/presentation/pages/all_invoices.dart';
import 'package:freelancer_visuals/features/projects/presentation/pages/all_projects.dart';
import 'package:freelancer_visuals/features/projects/presentation/pages/home_page.dart';
import 'package:freelancer_visuals/features/projects/presentation/pages/main_screen.dart';

import 'package:freelancer_visuals/init_dependencies.dart';

// import 'package:freelancer_visuals/features/auth/presentation/pages/signup_page.dart';
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> initializeNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  await initializeNotifications();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => serviceLocator<AppUserCubit>()),
        BlocProvider(create: (_) => serviceLocator<AuthBloc>()),
        BlocProvider(create: (_) => serviceLocator<ProjectBloc>()),
        BlocProvider(create: (_) => serviceLocator<ClientBloc>()),
        BlocProvider(create: (_) => serviceLocator<InvoiceBloc>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    context.read<AuthBloc>().add(AuthIsUserLoggedIn());
    super.initState();
  }

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
        '/home/': (context) => const HomePage(),
        '/addclient/': (context) => const AddNewClientPage(),
        '/allprojs/': (context) => const AllProjects(),
        '/allclients/': (context) => const AllClients(),
        '/allinvoices/': (context) => const AllInvoices(),
      },
      // home: const OnboardingScreen(),
      home: BlocSelector<AppUserCubit, AppUserState, bool>(
        selector: (state) {
          return state is AppUserLoggedIn;
        },
        builder: (context, isLoggedIn) {
          if (isLoggedIn) {
            return const MainScreen();
          }
          return const LoginPage();
        },
      ),
    );
  }
}
