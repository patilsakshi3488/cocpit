/*import 'package:flutter/material.dart';
import 'create_career_moment_screen.dart';
import 'career_moment_viewer.dart';

class CareerMomentsBar extends StatelessWidget {
  const CareerMomentsBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        children: [
          _yourMoment(context),
          _moment(context, "John Smith"),
          _moment(context, "Sarah Johnson"),
        ],
      ),
    );
  }

  Widget _yourMoment(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const CreateCareerMomentScreen(),
          ),
        );
      },
      child: Container(
        width: 90,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF7C83FF), Color(0xFFEC4899)],
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Center(
          child: Text(
            "+\nYour Update",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _moment(BuildContext context, String name) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CareerMomentViewer(name: name),
          ),
        );
      },
      child: Container(
        width: 90,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage('lib/images/LP1.jpg'),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        alignment: Alignment.bottomLeft,
        padding: const EdgeInsets.all(8),
        child: Text(
          name,
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
      ),
    );
  }
}*/
