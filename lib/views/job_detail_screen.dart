
//this shows view jobs page job details
import 'package:flutter/material.dart';

class MyJobsScreen extends StatefulWidget {
  const MyJobsScreen({super.key});

  @override
  State<MyJobsScreen> createState() => _MyJobsScreenState();
}

class _MyJobsScreenState extends State<MyJobsScreen> {
  int tab = 0;

  /* ================= THEME ================= */
  final Color bg = const Color(0xFF0B1220);
  final Color card = const Color(0xFF111827);
  final Color border = const Color(0xFF1F2937);

  final tabs = ['In Progress', 'Applied', 'Past', 'Saved'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      appBar: _appBar(),
      body: Column(
        children: [
          _tabs(),
          Expanded(child: _content()),
        ],
      ),
    );
  }

  /* ================= APP BAR ================= */
  AppBar _appBar() {
    return AppBar(
      backgroundColor: bg,
      elevation: 0,
      leading: const BackButton(color: Colors.white),
      title: const Text(
        'My Jobs',
        style: TextStyle(color: Colors.white),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.tune, color: Colors.white),
          onPressed: _openFilters,
        ),
      ],
    );
  }

  /* ================= TABS ================= */
  Widget _tabs() {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            tabs.length,
                (i) => Padding(
              padding: const EdgeInsets.only(right: 8),
              child: GestureDetector(
                onTap: () => setState(() => tab = i),
                child: Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: tab == i ? Colors.indigo : card,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: border),
                  ),
                  child: Text(
                    tabs[i],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /* ================= JOB LIST ================= */
  Widget _content() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _jobCard('Product Designer', 'Adobe', 'Applied'),
        _jobCard('UX Researcher', 'Spotify', 'In Progress'),
        _jobCard('UI Engineer', 'Google', 'Saved'),
        _jobCard('Visual Designer', 'Netflix', 'Past'),
      ],
    );
  }

  Widget _jobCard(String title, String company, String status) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            company,
            style: const TextStyle(color: Colors.white54),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                status,
                style: TextStyle(
                  color: _statusColor(status),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Icon(Icons.arrow_forward_ios,
                  size: 14, color: Colors.white38),
            ],
          )
        ],
      ),
    );
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'Applied':
        return Colors.blueAccent;
      case 'In Progress':
        return Colors.orangeAccent;
      case 'Saved':
        return Colors.purpleAccent;
      case 'Past':
        return Colors.grey;
      default:
        return Colors.white;
    }
  }

  /* ================= FILTER PANEL ================= */
  void _openFilters() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => Align(
        alignment: Alignment.centerLeft,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: card,
            borderRadius:
            const BorderRadius.horizontal(right: Radius.circular(24)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Filter My Jobs',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              _dropdown('Job Role', 'All Roles'),
              _dropdown('Company', 'All Companies'),
              _dropdown('Status', 'Any'),
              _dropdown('Applied Date', 'Any'),
              const Spacer(),
              _applyButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _dropdown(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(color: Colors.white70)),
          const SizedBox(height: 6),
          Container(
            height: 44,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: bg,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: border),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Select',
                  style: TextStyle(color: Colors.white),
                ),
                Icon(Icons.keyboard_arrow_down,
                    color: Colors.white54),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _applyButton() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Center(
        child: Text(
          'Apply Filters',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
