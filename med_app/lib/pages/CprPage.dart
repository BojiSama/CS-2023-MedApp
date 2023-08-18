import 'package:flutter/material.dart';

class CprPage extends StatelessWidget {
  const CprPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CPR Instructions'),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Add detailed CPR instructions here

              // You can include images or videos to enhance the instructions.

              // Make sure to provide clear and helpful information.
            ],
          ),
        ),
      ),
    );
  }
}
