import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

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
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Call for Help'),
      // ),
      body: Center(
        child: buildButton(),
      ),
    );
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
