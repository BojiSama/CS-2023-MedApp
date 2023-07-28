import 'package:flutter/material.dart';
class CallHelp extends StatefulWidget {
  @override
  _CallHelpState createState() => _CallHelpState();
}

class _CallHelpState extends State<CallHelp> {

  List<Contact> _contacts = [
    Contact(name: 'Nearest Hospital', phone: '111'),
    Contact(name: 'General Emergency Hotline', phone: '911'),
  ];

  void _callForHelp() {
    setState(() {
    });

    // Simulate a delay (e.g., network request)
    Future.delayed(Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
        });
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Help is on the way!'),
              content: Text('Your call for help has been sent.'),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Call for Help'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: _callForHelp,
          child: Container(
            width: 200,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                'Call for Help',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showContacts();
        },
        child: Icon(Icons.contact_phone),
      ),
    );
  }

  void _showContacts() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Emergency Contacts'),
          content: ListView.builder(
            itemCount: _contacts.length,
            itemBuilder: (context, index) {
              Contact contact = _contacts[index];
              return ListTile(
                title: Text(contact.name),
                subtitle: Text(contact.phone),
                onTap: () {
                  // TODO: Call the contact
                },
              );
            },
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class Contact {
  String name;
  String phone;

  Contact({required this.name, required this.phone});
}// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

// _makePhoneCall() async {
//   var url = Uri.parse("tel:+256782852579");
//   if (await (canLaunchUrl(url))) {
//     await launchUrl(url);
//   } else {
//     throw 'cannot call $url';
//   }
// }

// class CallHelp extends StatelessWidget {
//   const CallHelp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Call'),
//       ),
//       backgroundColor: Colors.grey,
//       body: const Center(
//         child: Column(
//           children: [
//             ElevatedButton(
//               onPressed: _makePhoneCall,
//               child: Text('call barry'),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
