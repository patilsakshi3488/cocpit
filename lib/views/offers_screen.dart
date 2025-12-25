import 'package:flutter/material.dart';

class OffersScreen extends StatefulWidget {
  const OffersScreen({super.key});

  @override
  State<OffersScreen> createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  /* ================= THEME ================= */
  final Color bg = const Color(0xFF0B1220);
  final Color card = const Color(0xFF111827);
  final Color border = const Color(0xFF1F2937);

  final Gradient gradient = const LinearGradient(
    colors: [Color(0xFF6366F1), Color(0xFFEC4899)],
  );

  /* ================= SEARCH STATE (ADDED) ================= */
  bool expandedSearch = false;

  /* ================= FILTER STATE ================= */
  bool showFilter = false;

  bool fullTime = false;
  bool partTime = false;
  bool contract = false;
  bool remote = false;
  bool internship = false;

  String experience = 'All Levels';
  String salary = 'Any';
  String datePosted = 'Any Time';
  String location = '';

  /* ================= SEARCH UI (UPDATED) ================= */
  Widget _search() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: card,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: border),
        ),
        child: expandedSearch ? _expandedSearch() : _compactSearch(),
      ),
    );
  }

  Widget _compactSearch() {
    return Row(
      children: [
        const Icon(Icons.search, color: Colors.white54),
        const SizedBox(width: 12),
        const Expanded(
          child: Text(
            'Search by title, skill, or company...',
            style: TextStyle(color: Colors.white54),
          ),
        ),
        ElevatedButton(
          onPressed: () => setState(() => expandedSearch = true),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF6D7CFF),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          ),
          child: const Text('Search'),
        ),
      ],
    );
  }

  Widget _expandedSearch() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Keywords', style: TextStyle(color: Colors.white70)),
        const SizedBox(height: 6),
        _searchInput(Icons.search, 'Job title, keywords, or company'),
        const SizedBox(height: 14),
        const Text('Locations', style: TextStyle(color: Colors.white70)),
        const SizedBox(height: 6),
        _searchInput(Icons.location_on, 'Type city & hit Enter...'),
        const SizedBox(height: 18),
        Align(
          alignment: Alignment.centerRight,
          child: ElevatedButton(
            onPressed: () => setState(() => expandedSearch = false),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6D7CFF),
              padding:
              const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)),
            ),
            child: const Text('Search Jobs'),
          ),
        ),
      ],
    );
  }

  Widget _searchInput(IconData icon, String hint) {
    return Container(
      height: 46,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: border),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white54, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: const TextStyle(color: Colors.white54),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /* ================= JOB DATA ================= */
  final List<Map<String, dynamic>> jobs = [
    {
      'title': 'Senior Financial Analyst',
      'company': 'JPMorgan Chase',
      'location': 'New York, NY',
      'type': 'Full-time',
      'experience': 'Senior Level',
      'salary': '\$125k - \$155k',
      'time': '2d ago',
      'applicants': '18 applicants',
    },
    {
      'title': 'Business Analyst',
      'company': 'McKinsey & Company',
      'location': 'Boston, MA',
      'type': 'Full-time',
      'experience': 'Mid Level',
      'salary': '\$110k - \$140k',
      'time': '5d ago',
      'applicants': '42 applicants',
    },
  ];

  /* ================= FILTER LOGIC ================= */
  List<Map<String, dynamic>> _filteredJobs() {
    return jobs;
  }

  /* ================= UI ================= */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        elevation: 0,
        title: const Text('Offers', style: TextStyle(color: Colors.white)),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              _search(),
              _metaRow(),
              Expanded(child: _jobList()),
            ],
          ),
          if (showFilter) _filterOverlay(),
        ],
      ),
    );
  }

  Widget _metaRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${_filteredJobs().length} jobs found',
            style: const TextStyle(color: Colors.white70),
          ),
          GestureDetector(
            onTap: () => setState(() => showFilter = true),
            child: Container(
              padding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: card,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: border),
              ),
              child: const Row(
                children: [
                  Icon(Icons.tune, size: 16, color: Colors.white70),
                  SizedBox(width: 6),
                  Text('Filters',
                      style:
                      TextStyle(fontSize: 12, color: Colors.white70)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /* ================= JOB LIST ================= */
  Widget _jobList() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: _filteredJobs().map(_jobCard).toList(),
    );
  }

  /* ================= OFFER CARD (UPDATED) ================= */
  Widget _jobCard(Map<String, dynamic> job) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: card,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.pink.withOpacity(.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text('Direct Offer',
                style: TextStyle(color: Colors.pink, fontSize: 12)),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: Colors.greenAccent,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              const SizedBox(width: 14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(job['title'],
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600)),
                  const SizedBox(height: 4),
                  Text(job['company'],
                      style: const TextStyle(color: Colors.white70)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              _meta(job['location']),
              _dot(),
              _meta(job['type']),
            ],
          ),
          const SizedBox(height: 10),
          Text(job['salary'],
              style: const TextStyle(
                  color: Colors.indigoAccent, fontSize: 15)),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 46,
                  decoration: BoxDecoration(
                    gradient: gradient,
                    borderRadius: BorderRadius.circular(26),
                  ),
                  alignment: Alignment.center,
                  child: const Text('Accept Offer',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600)),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Container(
                  height: 46,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(26),
                    border: Border.all(color: Colors.redAccent),
                  ),
                  alignment: Alignment.center,
                  child: const Text('Reject',
                      style: TextStyle(color: Colors.redAccent)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /* ================= EXISTING SMALL WIDGETS (UNCHANGED) ================= */
  Widget _meta(String t) =>
      Text(t, style: const TextStyle(color: Colors.white54, fontSize: 12));

  Widget _dot() => const Padding(
    padding: EdgeInsets.symmetric(horizontal: 6),
    child: Icon(Icons.circle, size: 4, color: Colors.white38),
  );

  Widget _filterOverlay() => const SizedBox(); // unchanged placeholder
}
