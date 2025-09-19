import 'package:flutter/material.dart';
import 'package:freelancer_visuals/core/theme/app_pallete.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.lightBackgroundColor,
      body: Stack(
        children: [
          PageView(
            children: [
              // OnBoardingPage(
              //   imagePath: 'assets/images/clients.png',
              //   title: 'Manage Clients Easily',
              //   subTitle: '"Add and track all you clients in one place"',
              // ),
              // OnBoardingPage(
              //   imagePath: 'assets/images/graph.png',
              //   title: 'Track your income',
              //   subTitle: '"View earnings, pending payments, and trends"',
              // ),
              OnBoardingPage(
                imagePath: 'assets/images/invoice.png',
                title: 'Manage Invoices with ease',
                subTitle: '"Create, View, and Export invoices easily"',
              ),
              // OnBoardingPage(
              //   imagePath: 'assets/images/FFD_logo.png',
              //   title: '',
              //   subTitle: '',
              // ),
            ],
          ),
        ],
      ),
    );
  }
}

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subTitle,
  });

  final String imagePath;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.6,
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: AppPallete.lightTextSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          // const SizedBox(height: 20),
          Text(
            subTitle,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppPallete.lightTextSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
