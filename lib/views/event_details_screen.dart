import 'package:flutter/material.dart';
import '../models/event_model.dart';
import 'event_register_sheet.dart';
import 'my_event_analytics_screen.dart';

class EventDetailsScreen extends StatelessWidget {
  final EventModel event;

  const EventDetailsScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1220),
      body: Stack(
        children: [
          _heroImage(context),
          _content(context),
          _topBar(context),
        ],
      ),
    );
  }

  // ================= HERO IMAGE =================
  Widget _heroImage(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.42,
      width: double.infinity,
      child: Image.asset(
        event.image,
        fit: BoxFit.cover,
      ),
    );
  }

  // ================= TOP BAR =================
  Widget _topBar(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _iconButton(
              icon: Icons.arrow_back,
              label: 'Back',
              onTap: () => Navigator.pop(context),
            ),
            _iconButton(
              icon: Icons.bookmark_border,
              label: 'Save Event',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _iconButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.45),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.white12),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 18),
            const SizedBox(width: 6),
            Text(label,
                style: const TextStyle(color: Colors.white, fontSize: 14)),
          ],
        ),
      ),
    );
  }

  // ================= CONTENT =================
  Widget _content(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.64,
      minChildSize: 0.64,
      maxChildSize: 0.95,
      builder: (_, controller) {
        return Container(
          decoration: const BoxDecoration(
            color: Color(0xFF0B1220),
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: SingleChildScrollView(
            controller: controller,
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 18),

                _sectionTitle('About this event'),
                Text(
                  event.description,
                  style: const TextStyle(
                    color: Colors.white70,
                    height: 1.6,
                  ),
                ),

                const SizedBox(height: 22),
                _infoRow(
                  Icons.calendar_today,
                  'Date and Time',
                  '${event.startDate} · ${event.startTime}',
                ),
                _infoRow(
                  Icons.location_on,
                  'Location',
                  event.location,
                ),
                _infoRow(
                  Icons.people,
                  'Attendees',
                  '${event.totalRegistrations} going',
                ),

                const SizedBox(height: 24),
                _organizerCard(),

                const SizedBox(height: 28),
                _actionButton(context),
              ],
            ),
          ),
        );
      },
    );
  }

  // ================= SECTIONS =================
  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF6366F1), size: 22),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600)),
              const SizedBox(height: 2),
              Text(value,
                  style: const TextStyle(color: Colors.white70)),
            ],
          ),
        ],
      ),
    );
  }

  // ================= ORGANIZER =================
  Widget _organizerCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF111827),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white10),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Organizers',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 14),
          _OrganizerRow(Icons.person, 'The Company Inc.'),
          _OrganizerRow(Icons.email, 'contact@thecompany.com'),
          _OrganizerRow(Icons.phone, '+1 234 567 890'),
        ],
      ),
    );
  }

  // ================= BUTTON =================
  Widget _actionButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (event.createdByMe) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => MyEventAnalyticsScreen(event: event),
              ),
            );
          } else {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (_) => EventRegisterSheet(event: event),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF6366F1),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
          event.createdByMe ? 'View Analytics' : 'Register for this event',
          style: const TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}

// ================= ORGANIZER ROW =================
class _OrganizerRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _OrganizerRow(this.icon, this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Icon(icon, color: Colors.white54, size: 20),
          const SizedBox(width: 12),
          Text(text, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}






















/*import 'package:flutter/material.dart';
import '../models/event_model.dart';
import 'event_register_sheet.dart';

class EventDetailsScreen extends StatelessWidget {
  final EventModel event;

  const EventDetailsScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1220),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                event.image,
                height: 260,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(event.title,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    Text(event.description,
                        style:
                        const TextStyle(color: Colors.white70, height: 1.6)),
                    const SizedBox(height: 20),

                    _info(Icons.calendar_today, event.date),
                    _info(Icons.location_on, event.location),
                    _info(Icons.people, event.attendees),

                    const SizedBox(height: 30),

                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6366F1),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14)),
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            barrierColor: Colors.black87,
                            builder: (_) =>
                                EventRegisterSheet(event: event),
                          );
                        },
                        child: const Text(
                          'Register for this event',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _info(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Icon(icon, color: Colors.white54, size: 18),
          const SizedBox(width: 10),
          Text(text,
              style: const TextStyle(color: Colors.white70, fontSize: 14)),
        ],
      ),
    );
  }
}*/
