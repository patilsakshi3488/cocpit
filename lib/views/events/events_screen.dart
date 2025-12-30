import 'package:flutter/material.dart';
import '../bottom_navigation.dart';
import 'event_card.dart';
import 'create_event_screen.dart';
import 'event_details_screen.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  final Color bg = const Color(0xFF0B1220);
  final Color cardColor = const Color(0xFF111827);
  final Color primary = const Color(0xFF6366F1);

  final List<Map<String, dynamic>> _allEvents = [
    {
      'id': '1',
      'title': 'Tech Summit 2024',
      'organizer': 'Google Developers',
      'date': 'Oct 24, 2024 • 10:00 AM',
      'location': 'San Francisco, CA',
      'image': 'lib/images/event1.jpg',
      'attendees': 1200,
      'isRegistered': false,
      'category': 'Technology',
    },
    {
      'id': '2',
      'title': 'Product Design Workshop',
      'organizer': 'Adobe Design',
      'date': 'Nov 12, 2024 • 2:00 PM',
      'location': 'Online',
      'image': 'lib/images/event2.jpg',
      'attendees': 450,
      'isRegistered': true,
      'category': 'Design',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Events", style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CreateEventScreen())),
          ),
        ],
      ),
      bottomNavigationBar: const AppBottomNavigation(currentIndex: 3),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _allEvents.length,
        itemBuilder: (context, index) {
          final event = _allEvents[index];
          return EventCard(
            event: event,
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => EventDetailsScreen(event: event))),
          );
        },
      ),
    );
  }
}
