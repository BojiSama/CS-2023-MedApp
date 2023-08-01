import 'package:flutter/material.dart';
import 'CprPage.dart';
import 'ChokingPage.dart';
import 'BurnsPage.dart';

class FirstAidPage extends StatefulWidget {
  @override
  _FirstAidPageState createState() => _FirstAidPageState();
}

class _FirstAidPageState extends State<FirstAidPage> {
  String _searchQuery = '';

  List<Map<String, dynamic>> _emergencies = [
    // List all the emergencies with a unique 'title' identifier
    {'title': 'CPR Instructions', 'page': CprPage()},
    {'title': 'Choking', 'page': ChokingPage()},
    {'title': 'Burns', 'page': BurnsPage()},
    // Add other emergencies similarly
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('First Aid'),
      // ),
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
