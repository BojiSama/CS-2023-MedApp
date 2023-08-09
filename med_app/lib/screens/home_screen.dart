import 'package:flutter/material.dart';
import 'package:med_app/pages/call_help.dart';
import 'package:med_app/pages/first_aid.dart';
import 'package:med_app/pages/hospital.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const String id = 'home_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medical Emergency App'),
      ),
      body: const Pages(),
    );
  }
}

class Pages extends StatefulWidget {
  const Pages({super.key});

  @override
  State<Pages> createState() => _PagesState();
}

class _PagesState extends State<Pages> {
  int currentPage = 0;
  final screens = [
     CallHelp(),
    const FirstAid(),
    const Hospital(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentPage,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentPage,
          onTap: (index) {
            setState(() {
              currentPage = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: currentPage == 0
                  ? const Icon(Icons.phone)
                  : const Icon(Icons.phone_outlined),
              label: 'Call',
            ),
            BottomNavigationBarItem(
              icon: currentPage == 1
                  ? const Icon(Icons.book)
                  : const Icon(Icons.book_online),
              label: 'First Aid Instructions',
            ),
            BottomNavigationBarItem(
              icon: currentPage == 2
                  ? const Icon(Icons.local_hospital)
                  : const Icon(Icons.local_hospital_outlined),
              label: 'Nearby hospital',
            ),
          ]),
    );
  }
}
