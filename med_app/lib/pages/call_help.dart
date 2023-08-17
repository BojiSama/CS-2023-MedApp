import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:contacts_service/contacts_service.dart';

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
  // final List<Contact> _contacts = [
  //   Contact(name: 'Nearest Hospital', phone: '111'),
  //   Contact(name: 'General Emergency Hotline', phone: '911'),
  // ];

  @override
  Widget build(BuildContext context) {
    List<Contact>? _contacts;

    Future<void> refreshContacts() async {
      var contacts = await ContactsService.getContacts(
        withThumbnails: false,
        // iOSLocalizedLabels: iOSLocalizedLabels,
      );

      setState(() {
        _contacts = contacts;
      });

      for (final contact in contacts) {
        ContactsService.getAvatar(contact).then((avatar) {
          if (avatar == null) return; // Don't redraw if no change.
          setState(() => contact.avatar = avatar);
        });
      }
    }

    @override
    void initState() {
      super.initState();
      refreshContacts();
    }

    _openContactForm() async {
      try {
        var _ = await ContactsService.openContactForm();
        refreshContacts();
      } on FormOperationException catch (e) {
        switch (e.errorCode) {
          case FormOperationErrorCode.FORM_OPERATION_CANCELED:
          case FormOperationErrorCode.FORM_COULD_NOT_BE_OPEN:
          case FormOperationErrorCode.FORM_OPERATION_UNKNOWN_ERROR:
          default:
            print(e.errorCode);
        }
      }
    }

    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Call for Help'),
      // ),
      body: Center(
        // child: buildButton(),
        child: SafeArea(
            child: _contacts != null
                ? ListView.builder(
                    itemCount: _contacts?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      Contact? c = _contacts?.elementAt(index);
                      return ListTile(
                        onTap: () {},
                        leading: (c?.avatar != null && c?.avatar?.isNotEmpty != null)
                            ? CircleAvatar(
                                backgroundImage: MemoryImage(c?.avatar ?? Uint8List(0)))
                            : CircleAvatar(child: Text(c?.initials() ?? '')),
                      );
                    })
                : Center(child: const CircularProgressIndicator(),)),
      ),
    );
  }

  Future<List<Contact>> _getContacts() async {
    List<Contact> contacts = await ContactsService.getContacts();

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
