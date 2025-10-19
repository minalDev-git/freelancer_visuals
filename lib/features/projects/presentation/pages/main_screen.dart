import 'package:flutter/material.dart';
import 'package:freelancer_visuals/features/projects/presentation/pages/all_clients.dart';
import 'package:freelancer_visuals/features/projects/presentation/pages/all_invoices.dart';
import 'package:freelancer_visuals/features/projects/presentation/pages/all_projects.dart';

import 'package:freelancer_visuals/features/projects/presentation/pages/home_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentPage = 0;

  List<Widget> pages = const [
    HomePage(),
    AllClients(),
    AllProjects(),
    // DashboardPage(monthlySummary: [100, 200, 300, 400], startMonth: 0),
    AllInvoices(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: currentPage, children: pages),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        child: BottomNavigationBar(
          selectedItemColor: Theme.of(context).colorScheme.primary,
          unselectedItemColor: Colors.grey,
          elevation: 5,
          iconSize: 30,
          currentIndex: currentPage,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Clients'),
            BottomNavigationBarItem(icon: Icon(Icons.work), label: 'Projects'),
            BottomNavigationBarItem(
              icon: Icon(Icons.edit_document),
              label: 'Invoices',
            ),
          ],
          onTap: (value) {
            setState(() {
              currentPage = value;
            });
          },
        ),
      ),
    );
  }
}
