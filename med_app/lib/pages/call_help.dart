import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

_makePhoneCall() async {
  var url = Uri.parse("tel:+256782852579");
  if (await (canLaunchUrl(url))) {
    await launchUrl(url);
  } else {
    throw 'cannot call $url';
  }
}

class CallHelp extends StatelessWidget {
  const CallHelp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Call'),
      ),
      backgroundColor: Colors.grey,
      body: const Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _makePhoneCall,
              child: Text('call barry'),
            )
          ],
        ),
      ),
    );
  }
}
