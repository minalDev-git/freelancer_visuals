import 'package:flutter/material.dart';

import 'package:freelancer_visuals/features/projects/presentation/pages/add_invoice_page.dart';
import 'package:freelancer_visuals/features/projects/presentation/pages/all_clients.dart';
import 'package:freelancer_visuals/features/projects/presentation/pages/all_projects.dart';
import 'package:freelancer_visuals/features/projects/presentation/pages/home_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const ClientsPage(),
    const AllProjects(),
    const InvoicePage(client: null),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex], // <- this keeps bottom nav visible
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          selectedItemColor: Theme.of(context).colorScheme.primary,
          unselectedItemColor: Colors.grey,
          elevation: 5,
          iconSize: 30,
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
        ),
      ),
    );
  }
}
