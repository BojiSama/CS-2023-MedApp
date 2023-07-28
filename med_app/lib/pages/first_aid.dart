import 'package:flutter/material.dart';
import 'CprPage.dart';
import 'ChokingPage.dart';
import 'BurnsPage.dart';

class FirstAid extends StatelessWidget {
  const FirstAid({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AppBar(
        title: Text('Select The First Aid'),
      ),
      body: ListView(
        children: [
          EmergencyCard(
            title: 'CPR Instructions',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CprPage()),
            ),
          ),
          EmergencyCard(
            title: 'Choking',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChokingPage()),
            ),
          ),
          EmergencyCard(
            title: 'Burns',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BurnsPage()),
            ),
          ),
          // Add other emergency cards here
          // For example:
          // EmergencyCard(title: 'Burns', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => BurnsPage()),),),
          // Add cards for other emergencies similarly
        ],
      ),
    );
  }
}

class EmergencyCard extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  EmergencyCard({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title),
        onTap: onTap,
      ),
    );
  }
}
