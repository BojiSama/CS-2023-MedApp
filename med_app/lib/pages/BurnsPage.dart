import 'package:flutter/material.dart';

class BurnsPage extends StatelessWidget {
  const BurnsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Burns'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Instructions on how to help someone who has a burn',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              const Text(
                '1.Cool the burn with cold running water for at least 10 minutes.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(),
              Image.asset(
                'images/Burnsaid.png',
                width: 200,
                height: 500,
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                '2.Cover the burn with a clean, non-stick bandage or cloth.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(
                height: 16,
              ),
              Image.asset('images/hand-burns.jpg'),
              SizedBox(
                height: 16,
              ),
              Text(
                '3.Seek medical attention for severe burns.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(
                height: 16,
              ),
              // Image.asset('assets/images/chok cyle.png')
            ],
          ),
        ),
      ),
    );
  }
}
