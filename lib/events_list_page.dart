import 'package:flutter/material.dart';

class EventsListPage extends StatefulWidget {
  const EventsListPage({super.key});

  @override
  State<EventsListPage> createState() => _EventsListPageState();
}

class _EventsListPageState extends State<EventsListPage> {
  final List<Map<String, dynamic>> _dummyEvents = [
    {
      'title': 'Team Meet',
      'date': DateTime(2025, 7, 12),
      'time': '10:00 AM',
      'description': 'Weekly team sync-up meeting',
    },
    {
      'title': 'Doctor Appointment',
      'date': DateTime(2025, 7, 15),
      'time': '3:30 PM',
      'description': 'Annual checkup',
    },
    {
      'title': 'Birthday Party',
      'date': DateTime(2025, 7, 20),
      'time': '7:00 PM',
      'description': 'Celebration at Dave\'s place',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(
          0xFF00695C,
        ), // Slightly lighter deep green for contrast
        foregroundColor: Colors.white, // White text
        title: const Text('Events List'),
      ),
      body: _dummyEvents.isEmpty
          ? const Center(
              child: Text(
                'No events yet',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: _dummyEvents.length,
              itemBuilder: (context, index) {
                final event = _dummyEvents[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ListTile(
                    title: Text(
                      event['title'],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Date: ${event['date'].toString().substring(0, 10)}',
                        ),
                        Text('Time: ${event['time']}'),
                      ],
                    ),
                    trailing: const Icon(Icons.event),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text(event['title']),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Date: ${event['date'].toString().substring(0, 10)}',
                              ),
                              Text('Time: ${event['time']}'),
                              const SizedBox(height: 8),
                              Text(event['description']),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Close'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
