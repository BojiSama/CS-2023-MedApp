import 'package:flutter/material.dart';

class ChokingPage extends StatelessWidget {
  const ChokingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choking'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text(
              'Instructions on how to help someone who is choking',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            const Text(
              '1. Encourage the choking person to cough',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              '2.Bend them forwad and give them upto five(5) back blows(fists) to try and dislodge the blockage',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(
              height: 16,
            ),
            Image.asset('images/fist.png'),
            SizedBox(
              height: 16,
            ),
            Text(
              '3.If they are still choking, give them upto abdominal thrusts'
              '-Hold around the waist and pull inwards and upwards above their belly',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(
              height: 16,
            ),
            Image.asset('images/thrust.png'),
            SizedBox(
              height: 12,
            ),
            Image.asset('image/chok cyle.png')
          ]),
        ),
      ),
    );
  }
}
