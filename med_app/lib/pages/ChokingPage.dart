import 'package:flutter/material.dart';

class ChokingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choking'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  'Instructions on how to help someone who is choking, including the Heimlich maneuver for different age groups')
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
