import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:fast_contacts/fast_contacts.dart';
import 'package:permission_handler/permission_handler.dart';
// class CallHelp extends StatefulWidget {
//   const CallHelp({super.key});

//   @override
//   State<CallHelp> createState() => _CallHelpState();
// }

// class _CallHelpState extends State<CallHelp> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: ElevatedButton(
//           onPressed: _callNumber,
//           child: Text('Call Number'),
//         ),
//       ),
//     );
//   }

//   _callNumber() async {
//     // const number = '08592119XXXX'; //set the number here
//     const number = '0789882274';
//     bool? res = await FlutterPhoneDirectCaller.callNumber(number);
//   }
// }

class CallHelp extends StatefulWidget {
  const CallHelp({super.key});

  @override
  State<CallHelp> createState() => _CallHelpState();
}

class _CallHelpState extends State<CallHelp> {
  String? _status;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Call for Help'),
      // ),
      body: Container(
        height: double.infinity,
        child: FutureBuilder(
          future: getContacts(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                Contact contact = snapshot.data[index];
                return Column(
                  children: [
                    ListTile(
                      leading: const CircleAvatar(
                        radius: 20.0,
                        child: Icon(Icons.person),
                      ),
                      title: Text(contact.displayName),
                      subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(contact.phones[0].number),
                        ],
                      ),
                      trailing: TextButton(
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 12),
                          shape: const RoundedRectangleBorder(
                            side: BorderSide(
                              color: Colors.redAccent,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.0)),
                          ),
                        ),
                        child: const Text('call'),
                        onPressed: () async {
                          await FlutterPhoneDirectCaller.callNumber(contact.phones[0].number);
                        },
                      ),
                    ),
                    const Divider(),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  Future<List<Contact>> getContacts() async {
    // bool isGranted = await Permission.contacts.status.isGranted;
    // if (!isGranted) {
    //   isGranted = await Permission.contacts.request().isGranted;
    // }
    // if (isGranted) {
    //   return await FastContacts.getAllContacts();
    // }
    // return [];
    List<Contact> contacts = const [];
    try {
      await Permission.contacts.request();
      contacts = await FastContacts.getAllContacts();
      _status = 'Contacts: ${contacts.length}';
    } on PlatformException catch (e) {
      _status = 'Failed to get contacts:\n${e.details}';
    }
    return contacts;
  }

  Widget buildButton() {
    const number = '0789882274';

    return ListTile(
      title: const Text('Francis'),
      subtitle: const Text(number),
      trailing: TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
          shape: const RoundedRectangleBorder(
            side: BorderSide(
              color: Colors.redAccent,
            ),
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
          ),
        ),
        child: const Text('call'),
        onPressed: () async {
          await FlutterPhoneDirectCaller.callNumber(number);
        },
      ),
    );
  }
}
