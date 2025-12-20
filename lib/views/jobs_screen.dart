import 'package:flutter/material.dart';
import 'chat_screen.dart';
import 'notification_screen.dart';
import 'bottom_navigation.dart';

class JobsScreen extends StatefulWidget {
  const JobsScreen({super.key});

  @override
  State<JobsScreen> createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {
  int mainTab = 0;
  int myJobTab = 0;

  // Filters state
  String role = "All Roles";
  String location = "All Locations";
  String experience = "All Levels";
  String jobType = "All Types";
  String company = "All Companies";

  final bg = const Color(0xFF0B1220);
  final card = const Color(0xFF1F2937);
  final sheetBg = const Color(0xFF111827);

  final gradient = const LinearGradient(
    colors: [Color(0xFF7C83FF), Color(0xFFEC4899)],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      floatingActionButton: _fab(),

      // ✅ ADDED (NO UI CHANGE)
      bottomNavigationBar: const AppBottomNavigation(currentIndex: 1),


      body: SafeArea(
        child: Column(
          children: [
            _topBar(),
            _mainTabs(),
            if (mainTab == 0) _jobsMeta(),
            Expanded(child: _body()),
          ],
        ),
      ),
    );
  }

  // ───────────────── TOP BAR ─────────────────

  Widget _topBar() {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 44,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: card,
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Row(
                children: [
                  Icon(Icons.search, color: Colors.white54),
                  SizedBox(width: 8),
                  Text("Search jobs...",
                      style: TextStyle(color: Colors.white54)),
                ],
              ),
            ),
          ),
          const SizedBox(width: 14),

          /// CHAT
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ChatScreen()),
              );
            },
            child: const Icon(Icons.chat_bubble_outline,
                color: Colors.white),
          ),

          const SizedBox(width: 14),

          /// NOTIFICATIONS
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const NotificationScreen()),
              );
            },
            child: Stack(
              children: [
                const Icon(Icons.notifications_none,
                    color: Colors.white),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                        color: Colors.red, shape: BoxShape.circle),
                    child: const Text("2",
                        style: TextStyle(
                            color: Colors.white, fontSize: 9)),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ───────────────── MAIN TABS ─────────────────

  Widget _mainTabs() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Row(
        children: [
          _tab("View Jobs", 0),
          _tab("My Jobs", 1),
          _tab("Offers", 2),
        ],
      ),
    );
  }

  Widget _tab(String text, int index) {
    final selected = mainTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => mainTab = index),
        child: Container(
          margin: const EdgeInsets.all(6),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            gradient: selected ? gradient : null,
            color: selected ? null : card,
            borderRadius: BorderRadius.circular(22),
          ),
          child: Center(
            child: Text(text,
                style: const TextStyle(color: Colors.white)),
          ),
        ),
      ),
    );
  }

  // ───────────────── JOB META ─────────────────

  Widget _jobsMeta() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("6 jobs found",
              style: TextStyle(color: Colors.white54)),
          GestureDetector(
            onTap: _openFilters,
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: card,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                children: [
                  Icon(Icons.tune, size: 16, color: Colors.white),
                  SizedBox(width: 6),
                  Text("Filters",
                      style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  // ───────────────── BODY ─────────────────

  Widget _body() {
    if (mainTab == 0) return _viewJobs();
    if (mainTab == 1) return _myJobs();
    return _offers();
  }

  // ───────────────── VIEW JOBS ─────────────────

  Widget _viewJobs() {
    return ListView(
      padding: const EdgeInsets.all(14),
      children: [
        _jobCard(
          title: "Senior Financial Analyst",
          company: "Goldman Sachs",
          location: "New York, NY • Full-time",
          salary: "\$120k - \$150k",
          meta: "Posted 2d ago • 45 applicants",
        ),
      ],
    );
  }

  // ───────────────── MY JOBS ─────────────────

  Widget _myJobs() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              _subTab("In Progress", 0),
              _subTab("Applied", 1),
              _subTab("In Past", 2),
              _subTab("Saved", 3),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(14),
            children: [
              _jobCard(
                title: "Data Analyst",
                company: "Meta",
                location: "Remote",
                salary: "Applied 5d ago",
                meta: "",
                buttonText: "View Details",
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _subTab(String text, int index) {
    final selected = myJobTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => myJobTab = index),
        child: Container(
          margin: const EdgeInsets.all(4),
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            gradient: selected ? gradient : null,
            color: selected ? null : card,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(text,
                style: const TextStyle(color: Colors.white)),
          ),
        ),
      ),
    );
  }

  // ───────────────── OFFERS ─────────────────

  Widget _offers() {
    return const Center(
      child: Text("No offers yet",
          style: TextStyle(color: Colors.white54)),
    );
  }

  // ───────────────── FILTERS ─────────────────

  void _openFilters() {
    showModalBottomSheet(
      context: context,
      backgroundColor: sheetBg,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Filters",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        role = location =
                            experience = jobType = company =
                        "All";
                      });
                      Navigator.pop(context);
                    },
                    child: const Text("Clear All",
                        style: TextStyle(
                            color: Color(0xFF7C83FF))),
                  )
                ],
              ),
              const SizedBox(height: 16),
              _filterItem("Job Role", role),
              _filterItem("Location", location),
              _filterItem("Experience", experience),
              _filterItem("Job Type", jobType),
              _filterItem("Company", company),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Widget _filterItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(color: Colors.white54)),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: card,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(value,
                    style:
                    const TextStyle(color: Colors.white)),
                const Icon(Icons.keyboard_arrow_down,
                    color: Colors.white54),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ───────────────── CARD ─────────────────

  Widget _jobCard({
    required String title,
    required String company,
    required String location,
    required String salary,
    required String meta,
    String buttonText = "Apply Now",
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: card,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
          Text(company,
              style: const TextStyle(color: Colors.white54)),
          Text(location,
              style: const TextStyle(color: Colors.white54)),
          Text(salary,
              style: const TextStyle(color: Colors.white54)),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding:
            const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(
              child: Text(buttonText,
                  style:
                  const TextStyle(color: Colors.white)),
            ),
          )
        ],
      ),
    );
  }

  // ───────────────── FAB ─────────────────

  Widget _fab() {
    return Container(
      width: 56,
      height: 56,
      decoration:
      BoxDecoration(shape: BoxShape.circle, gradient: gradient),
      child: const Icon(Icons.add, color: Colors.white),
    );
  }
}
