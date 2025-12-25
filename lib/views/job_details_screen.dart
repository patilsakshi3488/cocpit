//this page shows details of  my jobs page


import 'package:flutter/material.dart';

class JobDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> job;

  const JobDetailsScreen({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1220),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B1220),
        elevation: 0,
        leading: const BackButton(color: Colors.white),
        title:
        const Text('Job Details', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(job['title'],
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(job['company'],
                style:
                const TextStyle(color: Colors.white54, fontSize: 16)),
            const SizedBox(height: 16),
            Text(job['description'],
                style: const TextStyle(
                    color: Colors.white70, fontSize: 15)),
          ],
        ),
      ),
    );
  }
}
