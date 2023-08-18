import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:fast_contacts/fast_contacts.dart';
import 'package:permission_handler/permission_handler.dart';

class CallHelp extends StatefulWidget {
  const CallHelp({super.key});

  static const String id = 'call_help';

  @override
  State<CallHelp> createState() => _CallHelpState();
}

class _CallHelpState extends State<CallHelp> {
  String? _status;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Call for Help'),
      ),
      body: SafeArea(
        // height: double.infinity,
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
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      // tileColor: Colors.red[100],
                      leading: const CircleAvatar(
                        radius: 20.0,
                        child: Icon(Icons.person),
                      ),
                      title: Text(contact.displayName),
                      subtitle: Text(contact.phones[0].number),
                      trailing: TextButton(
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 12,
                          ),
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
                          await FlutterPhoneDirectCaller.callNumber(
                            contact.phones[0].number,
                          );
                        },
                      ),
                    ),
                    const Divider(
                      height: 1.0,
                      color: Colors.red,
                      indent: 20.0,
                      endIndent: 20.0,
                    ),
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
}
