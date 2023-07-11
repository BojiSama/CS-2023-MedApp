import 'package:flutter/material.dart';
import 'package:med_app/pages/account_page.dart';
import 'package:med_app/pages/calendar_page.dart';
import 'package:med_app/pages/home_page.dart';
import 'package:med_app/pages/message_page.dart';
import 'package:med_app/pages/search_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Med App',
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentPage = 0;
  final screens = [
    HomePage(), CalendarPage(), SearchPage(), AccountPage(), MessagePage(),
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
          // showSelectedLabels: false,
          // showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
                icon: currentPage == 0
                    ? Icon(
                        Icons.home,
                        color: Colors.black,
                      )
                    : Icon(
                        Icons.home_outlined,
                        color: Colors.grey.shade700,
                      ),
                label: "Home"),
            BottomNavigationBarItem(
                icon: currentPage == 1
                    ? Icon(
                        Icons.calendar_month,
                        color: Colors.black,
                      )
                    : Icon(
                        Icons.calendar_month_outlined,
                        color: Colors.grey.shade700,
                      ),
                label: "Calendar"),
            BottomNavigationBarItem(
                icon: currentPage == 2
                    ? Icon(
                        Icons.search,
                        color: Colors.black,
                      )
                    : Icon(
                        Icons.search_outlined,
                        color: Colors.grey.shade700,
                      ),
                label: "Search"),
            BottomNavigationBarItem(
                icon: currentPage == 3
                    ? Icon(
                        Icons.person,
                        color: Colors.black,
                      )
                    : Icon(
                        Icons.person_outlined,
                        color: Colors.grey.shade700,
                      ),
                label: "Account"),
            BottomNavigationBarItem(
                icon: currentPage == 4
                    ? Icon(
                        Icons.notifications,
                        color: Colors.black,
                      )
                    : Icon(
                        Icons.notifications_outlined,
                        color: Colors.grey.shade700,
                      ),
                label: "Messages")
          ]),
    );
  }
}
