import 'package:flutter/material.dart';
import 'bottom_navigation.dart';
import 'my_jobs_screen.dart';
import 'offers_screen.dart';

class JobsScreen extends StatefulWidget {
  const JobsScreen({super.key});

  @override
  State<JobsScreen> createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {
  int mainTab = 0; // 0: View Jobs, 1: My Jobs, 2: Offers
  int subTab = 0; // 0: In Progress, 1: Applied, 2: In Past, 3: Saved

  final Color bg = const Color(0xFF0B1220);
  final Color card = const Color(0xFF111827);
  final Color primary = const Color(0xFF6366F1);

  final List<Map<String, dynamic>> viewJobs = [
    {
      'id': '1',
      'title': 'Senior Financial Analyst',
      'company': 'JPMorgan Chase',
      'initial': 'J',
      'salary': r'$125k - $155k',
      'location': 'New York, NY',
      'type': 'Full-time',
      'time': '2 days ago',
      'applicants': '25 applicants applied',
      'match': '82%',
      'response': 'Recruiter usually responds in 2 days',
      'isHiring': false,
    },
    {
      'id': '2',
      'title': 'Business Analyst',
      'company': 'McKinsey & Company',
      'initial': 'M',
      'salary': r'$110k - $140k',
      'location': 'Boston, MA',
      'type': 'Full-time',
      'time': '3 days ago',
      'applicants': '18 applicants applied',
      'match': '87%',
      'response': 'Recruiter usually responds in 4 days',
      'isHiring': true,
    },
  ];

  final List<Map<String, dynamic>> myJobsInProgress = [
    {
      'id': 'p1',
      'title': 'Product Designer',
      'company': 'Adobe',
      'initial': 'A',
      'salary': r'$120k - $140k',
      'location': 'Remote',
      'type': 'Full-time',
      'time': 'Interview scheduled',
      'applicants': '8 applicants applied',
      'match': '87%',
      'response': 'Recruiter usually responds in 2 days',
      'status': 'In Progress',
      'statusColor': Colors.orangeAccent,
      'timelineStep': 2, // 0: Applied, 1: Under Review, 2: Interview, 3: Offer
    },
  ];

  final List<Map<String, dynamic>> myJobsApplied = [
    {
      'id': 'a1',
      'title': 'Senior Product Analyst',
      'company': 'Netflix',
      'initial': 'N',
      'salary': r'$130k - $150k',
      'location': 'New York, NY',
      'type': 'Full-time',
      'time': 'Applied 2 days ago',
      'applicants': '12 applicants applied',
      'match': '84%',
      'response': 'Recruiter usually responds in 1 day',
      'status': 'Applied',
      'statusColor': Colors.blueAccent,
      'isHiring': true,
      'timelineStep': 0,
    },
  ];

  final List<Map<String, dynamic>> myJobsInPast = [
    {
      'id': 'pa1',
      'title': 'UX Researcher',
      'company': 'Spotify',
      'initial': 'S',
      'salary': r'$100k - $130k',
      'location': 'Remote',
      'type': 'Full-time',
      'time': 'Closed 1 week ago',
      'applicants': '60 applicants applied',
      'match': '93%',
      'response': 'Recruiter usually responds in 4 days',
      'status': 'Closed',
      'statusColor': Colors.grey,
      'isHiring': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      bottomNavigationBar: const AppBottomNavigation(currentIndex: 1),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _header(),
            _searchSection(),
            _tabs(),
            _metaRow(),
            Expanded(child: _contentArea()),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
      child: Text(
        "Jobs",
        style: TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _searchSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 52,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B).withOpacity(0.5),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Row(
                children: [
                  Icon(Icons.search, color: Colors.white38, size: 24),
                  SizedBox(width: 12),
                  Text("Search jobs...", style: TextStyle(color: Colors.white38, fontSize: 16)),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            height: 52, width: 52,
            decoration: BoxDecoration(color: primary, borderRadius: BorderRadius.circular(16)),
            child: const Icon(Icons.add, color: Colors.white, size: 28),
          ),
        ],
      ),
    );
  }

  Widget _tabs() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _tabPill("View Jobs", 0),
                _tabPill("My Jobs", 1),
                _tabPill("Offers", 2, badge: "2"),
              ],
            ),
          ),
          if (mainTab == 1) ...[
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _subTabPill("In Progress", 0),
                  _subTabPill("Applied", 1),
                  _subTabPill("In Past", 2),
                  _subTabPill("Saved", 3),
                ],
              ),
            ),
          ]
        ],
      ),
    );
  }

  Widget _tabPill(String text, int index, {String? badge}) {
    bool active = mainTab == index;
    return GestureDetector(
      onTap: () {
        if (index == 2) {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const OffersScreen()));
          return;
        }
        setState(() => mainTab = index);
      },
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: active ? null : const Color(0xFF1E293B).withOpacity(0.5),
          gradient: active ? const LinearGradient(colors: [Color(0xFF7C83FF), Color(0xFFEC4899)]) : null,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(text, style: TextStyle(color: active ? Colors.white : Colors.white54, fontWeight: FontWeight.bold, fontSize: 15)),
            if (badge != null) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(color: Color(0xFFEC4899), shape: BoxShape.circle),
                child: Text(badge, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
              ),
            ]
          ],
        ),
      ),
    );
  }

  Widget _subTabPill(String text, int index) {
    bool active = subTab == index;
    return GestureDetector(
      onTap: () => setState(() => subTab = index),
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: active ? null : const Color(0xFF1E293B).withOpacity(0.5),
          gradient: active ? const LinearGradient(colors: [Color(0xFF7C83FF), Color(0xFFEC4899)]) : null,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(text, style: TextStyle(color: active ? Colors.white : Colors.white54, fontSize: 14, fontWeight: FontWeight.w500)),
      ),
    );
  }

  Widget _metaRow() {
    int count = 0;
    if (mainTab == 0) count = viewJobs.length;
    else if (mainTab == 1) {
      if (subTab == 0) count = myJobsInProgress.length;
      else if (subTab == 1) count = myJobsApplied.length;
      else if (subTab == 2) count = myJobsInPast.length;
      else count = 0;
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("$count jobs found", style: const TextStyle(color: Colors.white70, fontSize: 18, fontWeight: FontWeight.w400)),
          GestureDetector(
            onTap: () => _showFilterModal(context),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B).withOpacity(0.3),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white.withOpacity(0.05)),
              ),
              child: const Row(
                children: [
                  Icon(Icons.filter_list, size: 20, color: Colors.white70),
                  SizedBox(width: 8),
                  Text("Filters", style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w500)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _contentArea() {
    if (mainTab == 0) return _jobList(viewJobs);
    if (mainTab == 1) {
      if (subTab == 0) return _jobList(myJobsInProgress);
      if (subTab == 1) return _jobList(myJobsApplied);
      if (subTab == 2) return _jobList(myJobsInPast);
      if (subTab == 3) return _emptyState();
    }
    return Container();
  }

  Widget _jobList(List<Map<String, dynamic>> list) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: list.length,
      itemBuilder: (context, index) => _jobCard(list[index]),
    );
  }

  Widget _emptyState() {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        width: double.infinity,
        decoration: BoxDecoration(
          color: card,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            const Text(
              "No jobs found matching your criteria.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white70, fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () {},
              child: const Text("Clear filters", style: TextStyle(color: Color(0xFF6366F1), fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _jobCard(Map<String, dynamic> job) {
    bool isMyJob = mainTab == 1;
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: card,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48, height: 48,
                alignment: Alignment.center,
                child: Text(job['initial'], style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(job['title'], style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    if (isMyJob && job.containsKey('status')) ...[
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(color: (job['statusColor'] as Color).withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                        child: Text(job['status'], style: TextStyle(color: job['statusColor'], fontSize: 13, fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(height: 12),
                    ],
                    Row(
                      children: [
                        Text(job['company'], style: const TextStyle(color: Colors.white70, fontSize: 16)),
                        const SizedBox(width: 8),
                        const Icon(Icons.circle, size: 4, color: Colors.white38),
                        const SizedBox(width: 8),
                        Text(job['location'], style: const TextStyle(color: Colors.white38, fontSize: 15)),
                        if (job['isHiring'] == true) ...[
                          const SizedBox(width: 10),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(color: Colors.green.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
                            child: const Text("Hiring", style: TextStyle(color: Colors.greenAccent, fontSize: 10, fontWeight: FontWeight.bold)),
                          )
                        ]
                      ],
                    ),
                  ],
                ),
              ),
              const Icon(Icons.bookmark_border, color: Colors.white70, size: 24),
            ],
          ),
          const SizedBox(height: 20),
          _infoRow(job),
          const SizedBox(height: 12),
          _matchPill(job['match']),
          const Padding(padding: EdgeInsets.symmetric(vertical: 20), child: Divider(color: Colors.white10, height: 1)),
          _footerInfo(job),
          const SizedBox(height: 24),
          _actionButtons(job),
          if (isMyJob && job.containsKey('timelineStep')) ...[
            const Padding(padding: EdgeInsets.only(top: 24, bottom: 16), child: Text("Application Timeline", style: TextStyle(color: Colors.white70, fontSize: 14))),
            _timeline(job['timelineStep']),
          ]
        ],
      ),
    );
  }

  Widget _infoRow(Map<String, dynamic> job) {
    return Wrap(
      spacing: 8, runSpacing: 8,
      children: [
        _pill(Icons.work_outline, job['type']),
        _pill(Icons.attach_money, job['salary']),
        _pill(Icons.access_time, job['time']),
      ],
    );
  }

  Widget _pill(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(color: const Color(0xFF1E293B).withOpacity(0.4), borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white38, size: 18),
          const SizedBox(width: 8),
          Text(text, style: const TextStyle(color: Colors.white70, fontSize: 14)),
        ],
      ),
    );
  }

  Widget _matchPill(String match) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(color: const Color(0xFF6366F1).withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.bolt, color: Color(0xFFA855F7), size: 18),
          const SizedBox(width: 6),
          Text("$match Match", style: const TextStyle(color: Color(0xFFA855F7), fontWeight: FontWeight.bold, fontSize: 14)),
        ],
      ),
    );
  }

  Widget _footerInfo(Map<String, dynamic> job) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.circle, color: Colors.greenAccent, size: 8),
            const SizedBox(width: 10),
            Text(job['response'], style: const TextStyle(color: Colors.white60, fontSize: 14)),
          ],
        ),
        const SizedBox(height: 8),
        Text(job['applicants'], style: const TextStyle(color: Colors.white38, fontSize: 14)),
      ],
    );
  }

  Widget _actionButtons(Map<String, dynamic> job) {
    if (mainTab == 1 && subTab == 1) {
      return Row(
        children: [
          Expanded(child: _detailsBtn()),
          const SizedBox(width: 16),
          _appliedStatusBtn(),
        ],
      );
    }
    if (mainTab == 1 && (subTab == 0 || subTab == 2)) {
      return _detailsBtn(fullWidth: true);
    }
    return Row(
      children: [
        Expanded(child: _detailsBtn()),
        const SizedBox(width: 16),
        Expanded(child: _quickApplyBtn(job['title'])),
      ],
    );
  }

  Widget _detailsBtn({bool fullWidth = false}) {
    var btn = OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        side: const BorderSide(color: Colors.white10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      child: const Text("Details", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
    );
    return fullWidth ? SizedBox(width: double.infinity, child: btn) : btn;
  }

  Widget _appliedStatusBtn() {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.check_circle_outline, color: Colors.greenAccent, size: 20),
          const SizedBox(width: 8),
          const Text("Applied", style: TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold, fontSize: 16)),
        ],
      ),
    );
  }

  Widget _quickApplyBtn(String title) {
    return ElevatedButton(
      onPressed: () => _showApplyModal(context, title),
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        elevation: 0,
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.bolt, color: Colors.white, size: 20),
          const SizedBox(width: 6),
          const Text("Quick Apply", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
        ],
      ),
    );
  }

  Widget _timeline(int step) {
    final stages = ["Applied", "Under Review", "Interview", "Offer"];
    return Column(
      children: [
        Row(
          children: List.generate(4, (i) {
            bool done = i <= step;
            return Expanded(
              child: Row(
                children: [
                  Container(
                    width: 12, height: 12,
                    decoration: BoxDecoration(color: done ? primary : Colors.white24, shape: BoxShape.circle),
                  ),
                  if (i < 3) Expanded(child: Container(height: 2, color: i < step ? primary : Colors.white24)),
                ],
              ),
            );
          }),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(4, (i) {
            bool active = i == step;
            return Text(stages[i], style: TextStyle(color: active ? primary : Colors.white38, fontSize: 11, fontWeight: active ? FontWeight.bold : FontWeight.normal));
          }),
        ),
      ],
    );
  }

  void _showFilterModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const _FilterModal(),
    );
  }

  void _showApplyModal(BuildContext context, String title) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _ApplyModal(jobTitle: title),
    );
  }
}

class _FilterModal extends StatefulWidget {
  const _FilterModal();
  @override
  State<_FilterModal> createState() => _FilterModalState();
}

class _FilterModalState extends State<_FilterModal> {
  bool easyApply = false;
  bool activelyHiring = false;
  String experienceLevel = "All Levels";

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: const BoxDecoration(color: Color(0xFF0F172A), borderRadius: BorderRadius.vertical(top: Radius.circular(32))),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(2)))),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Filters", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
              TextButton(onPressed: () {}, child: const Text("Clear all", style: TextStyle(color: Color(0xFF7C83FF)))),
            ],
          ),
          const SizedBox(height: 24),
          _switchOption("Easy Apply", easyApply, (v) => setState(() => easyApply = v)),
          _switchOption("Actively Hiring", activelyHiring, (v) => setState(() => activelyHiring = v)),
          const Divider(color: Colors.white10, height: 40),
          const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text("Location", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)), Icon(Icons.keyboard_arrow_up, color: Colors.white70)]),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(color: const Color(0xFF1E293B), borderRadius: BorderRadius.circular(12)),
            child: const TextField(style: TextStyle(color: Colors.white), decoration: InputDecoration(hintText: "Add city...", hintStyle: TextStyle(color: Colors.white38), border: InputBorder.none)),
          ),
          const SizedBox(height: 32),
          const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text("Experience Level", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)), Icon(Icons.keyboard_arrow_up, color: Colors.white70)]),
          const SizedBox(height: 16),
          _radioOption("All Levels"), _radioOption("Entry Level"), _radioOption("Mid Level"),
          const Spacer(),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6366F1), minimumSize: const Size(double.infinity, 56), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), elevation: 0),
            child: const Text("Show Results", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _switchOption(String title, bool val, Function(bool) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(color: Colors.white70, fontSize: 16)),
          Switch(value: val, onChanged: onChanged, activeColor: const Color(0xFF6366F1), inactiveThumbColor: Colors.white, inactiveTrackColor: Colors.white10),
        ],
      ),
    );
  }

  Widget _radioOption(String value) {
    bool active = experienceLevel == value;
    return GestureDetector(
      onTap: () => setState(() => experienceLevel = value),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Container(
              width: 22, height: 22,
              decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: active ? const Color(0xFF6366F1) : Colors.white24, width: 2), color: active ? const Color(0xFF6366F1) : Colors.transparent),
              child: active ? const Icon(Icons.check, color: Colors.white, size: 14) : null,
            ),
            const SizedBox(width: 16),
            Text(value, style: TextStyle(color: active ? Colors.white : Colors.white70, fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

class _ApplyModal extends StatelessWidget {
  final String jobTitle;
  const _ApplyModal({required this.jobTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Color(0xFF0B1220), borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Apply to $jobTitle", style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          const Text("Full Name", style: TextStyle(color: Colors.white70, fontSize: 14)),
          const SizedBox(height: 8),
          _field("Your Name"),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text("Email", style: TextStyle(color: Colors.white70, fontSize: 14)), const SizedBox(height: 8), _field("Email")])),
              const SizedBox(width: 16),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text("Phone", style: TextStyle(color: Colors.white70, fontSize: 14)), const SizedBox(height: 8), _field("Phone")])),
            ],
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6366F1), minimumSize: const Size(double.infinity, 50), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
            child: const Text("Submit Application", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _field(String hint) {
    return TextField(style: const TextStyle(color: Colors.white), decoration: InputDecoration(hintText: hint, hintStyle: const TextStyle(color: Colors.white24), filled: true, fillColor: const Color(0xFF1F2937), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none), contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14)));
  }
}
