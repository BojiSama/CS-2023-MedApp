import 'package:fast_contacts/fast_contacts.dart';
import 'package:flutter/material.dart';
import '../pages/call_help.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

// import 'package:settings_button'

class PanicPage extends StatefulWidget {
  const PanicPage({super.key});

  static const String id = 'panic_page';
  @override
  State<PanicPage> createState() => _PanicPageState();
}

class _PanicPageState extends State<PanicPage> {
  @override
  Widget build(BuildContext context) {
    // final nextofkin = ModalRoute.of(context)!.settings.arguments as Contact;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          PopupMenuButton<int>(
            itemBuilder: (context) => [
              PopupMenuItem(
                height: 20.0,
                child: Row(
                  children: [
                    const Icon(
                      Icons.phone_callback,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    // Text('set panic contact'),
                    SizedBox(
                      height: 30.0,
                      child: TextButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const CallHelp(),
                          ),
                        ),
                        child: const Text('set panic contact'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
        title: const Text('call for help'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: SizedBox(
                width: 200,
                height: 200,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                  ),
                  onPressed: () async {
                    await FlutterPhoneDirectCaller.callNumber(
                      // ReceiveContact(contact: Contact.fromMap({})).contact.phones[0].number,
                      // contact!.phones[0].number,
                      '0789882274'
                    );
                  },
                  // onPressed: () => Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (_) => const CallHelp(),
                  //   ),
                  // ),
                  child: const Text(
                    'HELP',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ReceiveContact extends StatelessWidget {
  const ReceiveContact({super.key, required this.contact});

  final Contact contact;

  @override
  Widget build(BuildContext context) {

    return const PanicPage();
  }
}
class DialogExample extends StatelessWidget {
  const DialogExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextButton(
          onPressed: () => showDialog<String>(
            context: context,
            builder: (BuildContext context) => Dialog(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('This is a typical dialog.'),
                    const SizedBox(height: 15),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Close'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          child: const Text('Show Dialog'),
        ),
        const SizedBox(height: 10),
        TextButton(
          onPressed: () => showDialog<String>(
            context: context,
            builder: (BuildContext context) => Dialog.fullscreen(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text('This is a fullscreen dialog.'),
                  const SizedBox(height: 15),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Close'),
                  ),
                ],
              ),
            ),
          ),
          child: const Text('Show Fullscreen Dialog'),
        ),
      ],
    );
  }
}
