import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'CprPage.dart';
import 'ChokingPage.dart';
import 'BurnsPage.dart';

void main() {
  runApp(MaterialApp(
    home: FirstAidPage(),
  ));
}

class FirstAidPage extends StatefulWidget {
  @override
  _FirstAidPageState createState() => _FirstAidPageState();
}

class _FirstAidPageState extends State<FirstAidPage> {
  String _searchQuery = '';
  stt.SpeechToText _speechToText = stt.SpeechToText();
  String ibra = 'search here';

  List<Map<String, dynamic>> _emergencies = [
    {'title': 'CPR Instructions', 'page': CprPage()},
    {'title': 'Choking', 'page': ChokingPage()},
    {'title': 'Burns', 'page': BurnsPage()},
  ];

  List<Map<String, dynamic>> _filteredEmergencies = [];

  @override
  void initState() {
    super.initState();
    _filteredEmergencies = _emergencies;
  }

  void _performSearch(String query) {
    setState(() {
      _searchQuery = query;
      _filteredEmergencies = _emergencies
          .where((emergency) =>
              emergency['title'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _startListening() async {
    bool available = await _speechToText.initialize(
      onStatus: (status) {
        print('Speech recognition status: $status');
      },
      onError: (error) {
        print('Speech recognition error: $error');
      },
    );

    if (available) {
      _speechToText.listen(
        onResult: (result) {
          if (result.finalResult) {
            setState(() {
              ibra = result.recognizedWords;
              _performSearch(result.recognizedWords);
            });
          }
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: _performSearch,
                    controller: TextEditingController(text: _searchQuery),
                    decoration: InputDecoration(
                      hintText: ibra,
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.mic),
                  onPressed: _startListening,
                ),
              ],
            ),
          ),
          Expanded(
            child: _filteredEmergencies.isNotEmpty
                ? ListView.builder(
                    itemCount: _filteredEmergencies.length,
                    itemBuilder: (context, index) {
                      return EmergencyCard(
                        title: _filteredEmergencies[index]['title'],
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                _filteredEmergencies[index]['page'],
                          ),
                        ),
                      );
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
}
