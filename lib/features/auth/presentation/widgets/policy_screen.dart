import 'package:flutter/material.dart';

class PolicyScreen extends StatelessWidget {
  final String title;
  final String assetPath;
  const PolicyScreen({super.key, required this.title, required this.assetPath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: IconButton(
          onPressed: () {
            Navigator.of(
              context,
            ).pushNamedAndRemoveUntil('/signup/', (route) => false);
          },
          icon: Icon(Icons.arrow_back_ios_rounded),
        ),
      ),
      body: Center(child: Text('Privacy Policy')),
    );
  }
}
