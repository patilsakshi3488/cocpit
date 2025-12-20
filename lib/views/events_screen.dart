import 'package:flutter/material.dart';
import 'bottom_navigation.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1220),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _topBar(),
            const SizedBox(height: 16),
            _header(),
            const SizedBox(height: 16),
            Expanded(child: _eventsList()),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNavigation(currentIndex: 3),
    );
  }

  // 🔝 TOP BAR
  Widget _topBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 42,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: const Color(0xFF1F2937),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                children: [
                  Icon(Icons.search, color: Colors.white54),
                  SizedBox(width: 10),
                  Text(
                    "Search events...",
                    style: TextStyle(color: Colors.white54),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 14),
          const Icon(Icons.chat_bubble_outline, color: Colors.white),
          const SizedBox(width: 14),
          const Icon(Icons.notifications_none, color: Colors.white),
        ],
      ),
    );
  }

  // 📌 HEADER
  Widget _header() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Upcoming Events",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 6),
          Text(
            "Discover events for your professional growth",
            style: TextStyle(
              color: Color(0xFF94A3B8),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  // 📅 EVENTS LIST
  Widget _eventsList() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        EventCard(
          image: 'lib/images/event1.jpg',
          title: 'Tech Summit 2024: AI & Innovation',
          organizer: 'Tech Leaders Network',
          date: 'Dec 20, 2024',
          time: '9:00 AM - 5:00 PM',
          location: 'San Francisco Convention Center',
          attendees: '1250 attendees',
        ),
        SizedBox(height: 16),
        EventCard(
          image: 'lib/images/event2.jpg',
          title: 'Startup Growth Meetup',
          organizer: 'Product Founders Hub',
          date: 'Jan 05, 2025',
          time: '6:00 PM - 9:00 PM',
          location: 'New York City',
          attendees: '540 attendees',
        ),
      ],
    );
  }
}

// ================= EVENT CARD =================

class EventCard extends StatelessWidget {
  final String image;
  final String title;
  final String organizer;
  final String date;
  final String time;
  final String location;
  final String attendees;

  const EventCard({
    super.key,
    required this.image,
    required this.title,
    required this.organizer,
    required this.date,
    required this.time,
    required this.location,
    required this.attendees,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1F2937),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🖼 IMAGE
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.asset(
              image,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  organizer,
                  style: const TextStyle(color: Colors.white54),
                ),
                const SizedBox(height: 12),

                _infoRow(Icons.calendar_today, date),
                _infoRow(Icons.access_time, time),
                _infoRow(Icons.location_on, location),
                _infoRow(Icons.people, attendees),

                const SizedBox(height: 14),

                // 🔘 BUTTON
                SizedBox(
                  width: double.infinity,
                  height: 42,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF111827),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text("Attending"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.white54),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: Colors.white70, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}
