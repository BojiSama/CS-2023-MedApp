import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'CprPage.dart';
import 'ChokingPage.dart';
import 'BurnsPage.dart';

class FirstAidPage extends StatefulWidget {
  @override
  _FirstAidPageState createState() => _FirstAidPageState();
}

class _FirstAidPageState extends State<FirstAidPage> {
  late stt.SpeechToText _speech;
  List<Map<String, dynamic>> _emergencies = [
    {'title': 'CPR Instructions', 'page': CprPage()},
    {'title': 'Choking', 'page': ChokingPage()},
    {'title': 'Burns', 'page': BurnsPage()},
  ];

  List<Map<String, dynamic>> _filteredEmergencies = [];

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _filteredEmergencies = _emergencies;
  }

  void _startListening() async {
    bool available = await _speech.initialize(
      onStatus: (val) => print('onStatus: $val'),
      onError: (val) => print('onError: $val'),
    );
    if (available) {
      _speech.listen(
        onResult: (val) => _performSearch(val.recognizedWords),
      );
    } else {
      print("The user has denied the use of speech recognition.");
    }
  }

  void _performSearch(String query) {
    setState(() {
      _filteredEmergencies = _emergencies
          .where((emergency) =>
              emergency['title'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Aid'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              onChanged: _performSearch,
              decoration: const InputDecoration(
                hintText: 'Search for emergencies...',
              ),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: _filteredEmergencies.isNotEmpty
                ? ListView.builder(
                    itemCount: _filteredEmergencies.length,
                    itemBuilder: (context, index) {
                      EmergencyCard(
                        title: _filteredEmergencies[index]['title'],
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                _filteredEmergencies[index]['page'],
                          ),
                        ),
                      );
                      return null;
                    },
                  )
                : const Center(
                    child: Text(
                      'No matching emergencies found.',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.mic),
        onPressed: _startListening,
      ),
    );
  }
}

class EmergencyCard extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  EmergencyCard({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title),
        onTap: onTap,
      ),
    );
  }
}// import 'package:flutter/material.dart';
// import 'CprPage.dart';
// import 'ChokingPage.dart';
// import 'BurnsPage.dart';

// class FirstAidPage extends StatefulWidget {
//   @override
//   _FirstAidPageState createState() => _FirstAidPageState();
// }

// class _FirstAidPageState extends State<FirstAidPage> {

//   List<Map<String, dynamic>> _emergencies = [
//     // List all the emergencies with a unique 'title' identifier
//     {'title': 'CPR Instructions', 'page': CprPage()},
//     {'title': 'Choking', 'page': ChokingPage()},
//     {'title': 'Burns', 'page': BurnsPage()},
//     // Add other emergencies similarly
//   ];

//   List<Map<String, dynamic>> _filteredEmergencies = [];

//   @override
//   void initState() {
//     super.initState();
//     _filteredEmergencies = _emergencies;
//   }

//   void _performSearch(String query) {
//     setState(() {
//       _filteredEmergencies = _emergencies
//           .where((emergency) =>
//               emergency['title'].toLowerCase().contains(query.toLowerCase()))
//           .toList();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('First Aid'),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: EdgeInsets.all(16.0),
//             child: TextField(
//               onChanged: _performSearch,
//               decoration: const InputDecoration(
//                 hintText: 'Search for emergencies...',
//               ),
//               style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//           ),
//           Expanded(
//             child: _filteredEmergencies.isNotEmpty
//                 ? ListView.builder(
//                     itemCount: _filteredEmergencies.length,
//                     itemBuilder: (context, index) {
//                       return EmergencyCard(
//                         title: _filteredEmergencies[index]['title'],
//                         onTap: () => Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) =>
//                                 _filteredEmergencies[index]['page'],
//                           ),
//                         ),
//                       );
//                     },
//                   )
//                 : const Center(
//                     child: Text(
//                       'No matching emergencies found.',
//                       style: TextStyle(fontSize: 16),
//                     ),
//                   ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class EmergencyCard extends StatelessWidget {
//   final String title;
//   final VoidCallback onTap;

//   EmergencyCard({required this.title, required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: ListTile(
//         title: Text(title),
//         onTap: onTap,
//       ),
//     );
//   }
// }
