/*import 'package:flutter/material.dart';
import '../models/event_model.dart';

class EventRegisterSheet extends StatelessWidget {
  final EventModel event;

  const EventRegisterSheet({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Register for ${event.title}',
              style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 12),
          TextField(decoration: const InputDecoration(labelText: 'Name')),
          TextField(decoration: const InputDecoration(labelText: 'Email')),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Confirm Registration'),
          ),
        ],
      ),
    );
  }
}*/

































import 'package:flutter/material.dart';
import '../models/event_model.dart';

class EventRegisterSheet extends StatelessWidget {
  final EventModel event;

  const EventRegisterSheet({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFF111827),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Register for ${event.title}',
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            _input('Name'),
            _input('Email'),
            _input('Mobile'),
            _input('Company'),
            _input('Job Title'),

            const SizedBox(height: 12),
            Text(
              event.isFree ? 'This is a free event.' : 'Paid Event',
              style: const TextStyle(color: Colors.white54),
            ),

            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6366F1),
                    ),
                    child: const Text('Register'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _input(String hint) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white38),
          filled: true,
          fillColor: const Color(0xFF1F2937),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
