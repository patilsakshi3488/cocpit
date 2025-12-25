import 'package:flutter/material.dart';
import '../models/event_model.dart';

class MyEventAnalyticsScreen extends StatelessWidget {
  final EventModel event;

  const MyEventAnalyticsScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1220),
      appBar: AppBar(title: const Text('Event Analytics')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _tile('Total Registrations', event.totalRegistrations),
            _tile('Attended', event.attendedCount),
            _tile('Status', event.status),
          ],
        ),
      ),
    );
  }

  Widget _tile(String label, Object value) => Card(
    child: ListTile(
      title: Text(label),
      trailing: Text(value.toString()),
    ),
  );
}
