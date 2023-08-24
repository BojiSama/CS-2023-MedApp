import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:fast_contacts/fast_contacts.dart';
import 'package:med_app/screens/panic_page.dart';
import 'package:permission_handler/permission_handler.dart';

class NextOfKin {
  final Contact contact;

  const NextOfKin(this.contact);
}

class CallHelp extends StatefulWidget {
  const CallHelp({super.key});

  static const String id = 'call_help';

  @override
  State<CallHelp> createState() => _CallHelpState();
}

class _CallHelpState extends State<CallHelp> {
  String? _status;

  List<Contact> contactsFiltered = [];

  final searchController = TextEditingController();

  @override
  void initState(){
    super.initState();
    searchController.addListener(() { 
      filterContacts();
    });
  }

  filterContacts() async {
    List<Contact> _contacts = [];
    _contacts.addAll(await getContacts());
    if(searchController.text.isNotEmpty){
      _contacts.retainWhere((contact){
        String searchTerm = searchController.text.toLowerCase();
        String contactName = searchController.text.toLowerCase();
        return contactName.contains(searchTerm);
      });
    }

    setState(() {
      contactsFiltered = _contacts;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isSearching = searchController.text.isNotEmpty;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Call for Help'),
      ),
      body: Column(
        children: [
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: TextField(
          //     controller: searchController,
          //     decoration: InputDecoration(
          //       labelText: 'Search',
          //       border: OutlineInputBorder(
          //         borderSide: BorderSide(
          //           color: Theme.of(context).primaryColor,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          Expanded(
            child: FutureBuilder(
              future: getContacts(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                  itemCount: isSearching == true ? contactsFiltered.length : snapshot.data.length,
                  itemBuilder: (context, index) {
                    Contact contact = isSearching == true ? contactsFiltered[index] : snapshot.data[index];
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
                          onTap: () {
                            Navigator.pop(context);
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (_) => ReceiveContact(contact: contact),
                            //   ),
                            // );
                          },
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
        ],
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
