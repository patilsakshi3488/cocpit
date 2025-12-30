import 'package:flutter/material.dart';
import '../bottom_navigation.dart';
import '../offers_screen.dart';

class JobsScreen extends StatefulWidget {
  const JobsScreen({super.key});

  @override
  State<JobsScreen> createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {
  int mainTab = 0; // 0: View Jobs, 1: My Jobs, 2: Offers
  int subTab = 0; // 0: In Progress, 1: Applied, 2: In Past, 3: Saved, 4: Hiring

  final Color bg = const Color(0xFF0B1220);
  final Color cardColor = const Color(0xFF111827);
  final Color primary = const Color(0xFF6366F1);

  final List<Map<String, dynamic>> _allViewJobs = [
    {
      'id': '1',
      'title': 'Senior Financial Analyst',
      'company': 'JPMorgan Chase',
      'initial': 'J',
      'salary': r'$125k - $155k',
      'salaryVal': 140,
      'location': 'New York, NY',
      'type': 'Full-time',
      'workMode': 'Hybrid',
      'expLevel': 'Mid Level',
      'time': '2 days ago',
      'applicants': '25 applicants applied',
      'match': '82%',
      'response': 'Recruiter usually responds in 2 days',
      'isHiring': false,
      'isSaved': false,
    },
    {
      'id': '2',
      'title': 'Business Analyst',
      'company': 'McKinsey & Company',
      'initial': 'M',
      'salary': r'$110k - $140k',
      'salaryVal': 125,
      'location': 'Boston, MA',
      'type': 'Full-time',
      'workMode': 'Onsite',
      'expLevel': 'Entry Level',
      'time': '3 days ago',
      'applicants': '18 applicants applied',
      'match': '87%',
      'response': 'Recruiter usually responds in 4 days',
      'isHiring': true,
      'isSaved': false,
    },
  ];

  late List<Map<String, dynamic>> viewJobs;

  @override
  void initState() {
    super.initState();
    viewJobs = List.from(_allViewJobs);
  }

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
      'timelineStep': 2,
      'isSaved': false,
    },
  ];

  final List<Map<String, dynamic>> myJobsApplied = [
    {
      'id': 'a1',
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
      'status': 'Applied',
      'statusColor': Colors.blueAccent,
      'isHiring': false,
      'timelineStep': 0,
      'isSaved': false,
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
      'isSaved': false,
    },
  ];

  final List<Map<String, dynamic>> offers = [
    {
      'id': 'o1',
      'title': 'Senior Financial Analyst',
      'company': 'JPMorgan Chase',
      'initial': 'J',
      'salary': r'$125k - $155k',
      'location': 'New York, NY',
      'type': 'Full-time',
      'time': 'Today',
      'applicants': '0 applicants applied',
      'match': '69%',
      'response': 'Recruiter usually responds in 5 days',
      'isSaved': false,
    },
    {
      'id': 'o2',
      'title': 'Business Analyst',
      'company': 'McKinsey & Company',
      'initial': 'M',
      'salary': r'$110k - $140k',
      'location': 'Boston, MA',
      'type': 'Full-time',
      'time': '1 day ago',
      'applicants': '0 applicants applied',
      'match': '72%',
      'response': 'Recruiter usually responds in 2 days',
      'isSaved': false,
    },
  ];

  final List<Map<String, dynamic>> myJobsSaved = [];
  final List<Map<String, dynamic>> myJobsHiring = [];

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
            child: InkWell(
              onTap: () => _showSearchModal(context),
              borderRadius: BorderRadius.circular(16),
              child: Container(
                height: 52,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E293B).withValues(alpha: 0.5),
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
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: () => _showPostJobModal(context),
            child: Container(
              height: 52, width: 52,
              decoration: BoxDecoration(color: primary, borderRadius: BorderRadius.circular(16)),
              child: const Icon(Icons.add, color: Colors.white, size: 28),
            ),
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
                  _subTabPill("Hiring", 4),
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
        setState(() => mainTab = index);
      },
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: active ? null : const Color(0xFF1E293B).withValues(alpha: 0.5),
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
          color: active ? null : const Color(0xFF1E293B).withValues(alpha: 0.5),
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
      else if (subTab == 3) count = myJobsSaved.length;
      else if (subTab == 4) count = myJobsHiring.length;
      else count = 0;
    } else if (mainTab == 2) {
      count = offers.length;
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
                color: const Color(0xFF1E293B).withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
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
      if (subTab == 3) return myJobsSaved.isEmpty ? _emptyState() : _jobList(myJobsSaved);
      if (subTab == 4) return myJobsHiring.isEmpty ? _emptyState() : _jobList(myJobsHiring, isHiringView: true);
    }
    if (mainTab == 2) return _jobList(offers);
    return Container();
  }

  Widget _jobList(List<Map<String, dynamic>> list, {bool isHiringView = false}) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: list.length,
      itemBuilder: (context, index) => _jobCard(list[index], isHiringView: isHiringView),
    );
  }

  Widget _emptyState() {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        width: double.infinity,
        decoration: BoxDecoration(
          color: cardColor,
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
              onPressed: () {
                setState(() {
                  viewJobs = List.from(_allViewJobs);
                });
              },
              child: const Text("Clear filters", style: TextStyle(color: Color(0xFF6366F1), fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _jobCard(Map<String, dynamic> job, {bool isHiringView = false}) {
    bool isMyJob = mainTab == 1;
    bool isSaved = job['isSaved'] ?? false;

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
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
                    if (isMyJob && job.containsKey('status') && !isHiringView) ...[
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(color: (job['statusColor'] as Color).withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10)),
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
                            decoration: BoxDecoration(color: Colors.green.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(6)),
                            child: const Text("Hiring", style: TextStyle(color: Colors.greenAccent, fontSize: 10, fontWeight: FontWeight.bold)),
                          )
                        ]
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(isSaved ? Icons.bookmark : Icons.bookmark_border, color: isSaved ? Colors.pinkAccent : Colors.white70),
                onPressed: () => _toggleSaveJob(job),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _infoRow(job),
          const SizedBox(height: 12),
          _matchPill(job['match']),
          const Padding(padding: EdgeInsets.symmetric(vertical: 20), child: Divider(color: Colors.white10, height: 1)),
          _footerInfo(job),
          const SizedBox(height: 24),
          if (isHiringView)
            _hiringActionButtons(job)
          else
            _actionButtons(job),
          if (isMyJob && job.containsKey('timelineStep') && !isHiringView) ...[
            const Padding(padding: EdgeInsets.only(top: 24, bottom: 16), child: Text("Application Timeline", style: TextStyle(color: Colors.white70, fontSize: 14))),
            _timeline(job['timelineStep']),
          ]
        ],
      ),
    );
  }

  void _toggleSaveJob(Map<String, dynamic> job) {
    setState(() {
      bool isSaved = !(job['isSaved'] ?? false);
      job['isSaved'] = isSaved;
      if (isSaved) {
        if (!myJobsSaved.any((j) => j['id'] == job['id'])) {
          myJobsSaved.insert(0, Map.from(job));
        }
      } else {
        myJobsSaved.removeWhere((j) => j['id'] == job['id']);
        void updateIsSaved(List<Map<String, dynamic>> list) {
          for (var item in list) {
            if (item['id'] == job['id']) item['isSaved'] = false;
          }
        }
        updateIsSaved(viewJobs);
        updateIsSaved(myJobsInProgress);
        updateIsSaved(myJobsApplied);
        updateIsSaved(myJobsInPast);
        updateIsSaved(offers);
        updateIsSaved(myJobsHiring);
      }
    });
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
      decoration: BoxDecoration(color: const Color(0xFF1E293B).withValues(alpha: 0.4), borderRadius: BorderRadius.circular(10)),
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
      decoration: BoxDecoration(color: const Color(0xFF6366F1).withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10)),
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
          Expanded(child: _detailsBtn(job)),
          const SizedBox(width: 16),
          _appliedStatusBtn(),
        ],
      );
    }
    if (mainTab == 1 && (subTab == 0 || subTab == 2)) {
      return _detailsBtn(job, fullWidth: true);
    }
    return Row(
      children: [
        Expanded(child: _detailsBtn(job)),
        const SizedBox(width: 16),
        Expanded(child: _quickApplyBtn(job)),
      ],
    );
  }

  Widget _hiringActionButtons(Map<String, dynamic> job) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () => _showJobDetails(context, job),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              side: const BorderSide(color: Colors.white10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            ),
            child: const Text("Details", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            onPressed: () => _showAnalyticsModal(context, job),
            style: ElevatedButton.styleFrom(
              backgroundColor: primary,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              elevation: 0,
            ),
            child: const Text("Analytics", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
          ),
        ),
      ],
    );
  }

  Widget _detailsBtn(Map<String, dynamic> job, {bool fullWidth = false}) {
    var btn = OutlinedButton(
      onPressed: () => _showJobDetails(context, job),
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

  Widget _quickApplyBtn(Map<String, dynamic> job) {
    return ElevatedButton(
      onPressed: () => _showApplyModal(context, job),
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
      builder: (context) => _FilterModal(
        onApply: (filters) {
          setState(() {
            viewJobs = _allViewJobs.where((job) {
              bool matches = true;
              if (filters['remoteOnly'] == true) {
                if (job['workMode'] != 'Remote') matches = false;
              }
              if (filters['expLevel'] != 'All Levels') {
                if (job['expLevel'] != filters['expLevel']) matches = false;
              }
              if (filters['jobType'] != 'Full-time') {
                if (job['type'] != filters['jobType']) matches = false;
              }
              int salary = job['salaryVal'] ?? 0;
              if (salary < filters['salaryRange'].start || salary > filters['salaryRange'].end) {
                matches = false;
              }
              return matches;
            }).toList();
          });
        },
      ),
    );
  }

  void _showApplyModal(BuildContext context, Map<String, dynamic> job) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _ApplyModal(
        job: job,
        onApplied: (appliedJob) {
          setState(() {
            viewJobs.removeWhere((j) => j['id'] == appliedJob['id']);
            offers.removeWhere((j) => j['id'] == appliedJob['id']);
            myJobsApplied.insert(0, {
              ...appliedJob,
              'status': 'Applied',
              'statusColor': Colors.blueAccent,
              'time': 'Applied Just now',
              'timelineStep': 0,
            });
            mainTab = 1;
            subTab = 1;
          });
        },
      ),
    );
  }

  void _showSearchModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _SearchModal(
        onSearch: (keywords, location) {
          setState(() {
            viewJobs = _allViewJobs.where((job) {
              bool matches = true;
              if (keywords.isNotEmpty) {
                String title = job['title'].toString().toLowerCase();
                String company = job['company'].toString().toLowerCase();
                if (!title.contains(keywords.toLowerCase()) && !company.contains(keywords.toLowerCase())) {
                  matches = false;
                }
              }
              if (location.isNotEmpty) {
                String loc = job['location'].toString().toLowerCase();
                if (!loc.contains(location.toLowerCase())) {
                  matches = false;
                }
              }
              return matches;
            }).toList();
          });
        },
      ),
    );
  }

  void _showPostJobModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _PostJobModal(
        onJobPosted: (newJob) {
          setState(() {
            _allViewJobs.insert(0, newJob);
            viewJobs = List.from(_allViewJobs);
            myJobsHiring.insert(0, newJob);
            mainTab = 1;
            subTab = 4;
          });
        },
      ),
    );
  }

  void _showAnalyticsModal(BuildContext context, Map<String, dynamic> job) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _AnalyticsModal(job: job),
    );
  }

  void _showJobDetails(BuildContext context, Map<String, dynamic> job) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => _JobDetailsPage(
      job: job, 
      onApply: () => _showApplyModal(context, job),
      onToggleSave: () => _toggleSaveJob(job),
    )));
  }
}

class _FilterModal extends StatefulWidget {
  final Function(Map<String, dynamic>) onApply;
  const _FilterModal({required this.onApply});
  @override
  State<_FilterModal> createState() => _FilterModalState();
}

class _FilterModalState extends State<_FilterModal> {
  bool easyApply = false;
  bool activelyHiring = false;
  bool remoteOnly = false;
  String experienceLevel = "All Levels";
  String jobType = "Full-time";
  RangeValues salaryRange = const RangeValues(50, 200);

  final Color cardColor = const Color(0xFF111827);
  final Color primary = const Color(0xFF6366F1);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: const BoxDecoration(color: Color(0xFF0F172A), borderRadius: BorderRadius.vertical(top: Radius.circular(32))),
      child: Column(
        children: [
          const SizedBox(height: 12),
          Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(2))),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Filters", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                      TextButton(onPressed: () {
                        setState(() {
                          easyApply = false;
                          activelyHiring = false;
                          remoteOnly = false;
                          experienceLevel = "All Levels";
                          jobType = "Full-time";
                          salaryRange = const RangeValues(50, 200);
                        });
                      }, child: const Text("Clear all", style: TextStyle(color: Color(0xFF7C83FF)))),
                    ],
                  ),
                  const SizedBox(height: 24),
                  _switchOption("Easy Apply", easyApply, (v) => setState(() => easyApply = v)),
                  _switchOption("Actively Hiring", activelyHiring, (v) => setState(() => activelyHiring = v)),
                  _switchOption("Remote Only", remoteOnly, (v) => setState(() => remoteOnly = v)),
                  const Divider(color: Colors.white10, height: 40),
                  const Text("Location", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(color: const Color(0xFF1E293B), borderRadius: BorderRadius.circular(12)),
                    child: const TextField(style: TextStyle(color: Colors.white), decoration: InputDecoration(hintText: "Add city...", hintStyle: TextStyle(color: Colors.white38), border: InputBorder.none)),
                  ),
                  const Divider(color: Colors.white10, height: 40),
                  const Text("Salary Range (k/year)", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  RangeSlider(
                    values: salaryRange,
                    min: 0, max: 500,
                    divisions: 50,
                    labels: RangeLabels("${salaryRange.start.round()}k", "${salaryRange.end.round()}k"),
                    activeColor: primary,
                    onChanged: (v) => setState(() => salaryRange = v),
                  ),
                  const Divider(color: Colors.white10, height: 40),
                  const Text("Experience Level", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 10,
                    children: ["All Levels", "Entry Level", "Mid Level", "Senior"].map((e) => _choiceChip(e, experienceLevel == e, (s) => setState(() => experienceLevel = e))).toList(),
                  ),
                  const Divider(color: Colors.white10, height: 40),
                  const Text("Job Type", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 10,
                    children: ["Full-time", "Part-time", "Contract", "Internship"].map((e) => _choiceChip(e, jobType == e, (s) => setState(() => jobType = e))).toList(),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: ElevatedButton(
              onPressed: () {
                widget.onApply({
                  'easyApply': easyApply,
                  'remoteOnly': remoteOnly,
                  'expLevel': experienceLevel,
                  'jobType': jobType,
                  'salaryRange': salaryRange,
                });
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6366F1), minimumSize: const Size(double.infinity, 56), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), elevation: 0),
              child: const Text("Show Results", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            ),
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
          Switch(value: val, onChanged: onChanged, activeColor: primary, inactiveThumbColor: Colors.white, inactiveTrackColor: Colors.white10),
        ],
      ),
    );
  }

  Widget _choiceChip(String label, bool selected, Function(bool) onSelected) {
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: onSelected,
      selectedColor: primary,
      backgroundColor: cardColor,
      labelStyle: TextStyle(color: selected ? Colors.white : Colors.white70),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: selected ? primary : Colors.white10)),
    );
  }
}

class _SearchModal extends StatefulWidget {
  final Function(String keywords, String location) onSearch;
  const _SearchModal({required this.onSearch});
  @override
  State<_SearchModal> createState() => _SearchModalState();
}

class _SearchModalState extends State<_SearchModal> {
  final TextEditingController keywordsController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: const BoxDecoration(color: Color(0xFF0B1220), borderRadius: BorderRadius.vertical(top: Radius.circular(32))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            child: Text("Search Jobs", style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Keywords", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  _searchInput(Icons.search, "Job title, keywords, or company", keywordsController),
                  const SizedBox(height: 32),
                  const Text("Locations", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  _searchInput(Icons.location_on_outlined, "Type city & hit Enter...", locationController),
                  const SizedBox(height: 12),
                  const Text("Type a city name and press Enter to add it", style: TextStyle(color: Colors.white38, fontSize: 14)),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                      widget.onSearch(keywordsController.text, locationController.text);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6366F1),
                      minimumSize: const Size(double.infinity, 56),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    child: const Text("Search Results", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _searchInput(IconData icon, String hint, TextEditingController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(color: const Color(0xFF1E293B), borderRadius: BorderRadius.circular(16)),
      child: TextField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white24),
          prefixIcon: Icon(icon, color: Colors.white38),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class _ApplyModal extends StatelessWidget {
  final Map<String, dynamic> job;
  final Function(Map<String, dynamic>) onApplied;
  
  const _ApplyModal({required this.job, required this.onApplied});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: const BoxDecoration(color: Color(0xFF0B1220), borderRadius: BorderRadius.vertical(top: Radius.circular(32))),
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text("Apply to ${job['title']}", style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis)),
              IconButton(icon: const Icon(Icons.close, color: Colors.white54), onPressed: () => Navigator.pop(context)),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Full Name", style: TextStyle(color: Colors.white70, fontSize: 16)),
                  const SizedBox(height: 10),
                  _field("Alex Doe"),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text("Email", style: TextStyle(color: Colors.white70, fontSize: 16)), const SizedBox(height: 10), _field("alex@example.com")])),
                      const SizedBox(width: 16),
                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text("Phone (Optional)", style: TextStyle(color: Colors.white70, fontSize: 16)), const SizedBox(height: 10), _field("")])),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text("Resume", style: TextStyle(color: Colors.white70, fontSize: 16)),
                  const SizedBox(height: 10),
                  _resumeUpload(),
                  const SizedBox(height: 24),
                  const Text("Cover Note (Optional)", style: TextStyle(color: Colors.white70, fontSize: 16)),
                  const SizedBox(height: 10),
                  _field("", maxLines: 4),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      onApplied(job);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Application submitted successfully!"),
                          backgroundColor: Colors.green,
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6366F1), minimumSize: const Size(double.infinity, 56), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                    child: const Text("Submit Application", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _field(String hint, {int maxLines = 1}) {
    return TextField(
      maxLines: maxLines,
      style: const TextStyle(color: Colors.white), 
      decoration: InputDecoration(
        hintText: hint, 
        hintStyle: const TextStyle(color: Colors.white24), 
        filled: true, 
        fillColor: const Color(0xFF1E293B), 
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none), 
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14)
      ),
    );
  }

  Widget _resumeUpload() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B).withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10, style: BorderStyle.solid), 
      ),
      child: const Column(
        children: [
          Icon(Icons.upload_outlined, color: Colors.white54, size: 40),
          SizedBox(height: 16),
          Text("Upload Resume", style: TextStyle(color: Color(0xFF6366F1), fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text("PDF, DOCX up to 5MB", style: TextStyle(color: Colors.white38, fontSize: 12)),
        ],
      ),
    );
  }
}

class _PostJobModal extends StatefulWidget {
  final Function(Map<String, dynamic>) onJobPosted;
  const _PostJobModal({required this.onJobPosted});
  @override
  State<_PostJobModal> createState() => _PostJobModalState();
}

class _PostJobModalState extends State<_PostJobModal> {
  String empType = "Full-time";
  String workMode = "Onsite";
  bool enableEasyApply = true;
  bool activelyHiring = true;
  final titleController = TextEditingController();
  final locationController = TextEditingController();
  final salaryController = TextEditingController();
  final descriptionController = TextEditingController();
  final skillsController = TextEditingController();
  final companyController = TextEditingController();
  final aboutCompanyController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: const BoxDecoration(color: Color(0xFF0B1220), borderRadius: BorderRadius.vertical(top: Radius.circular(32))),
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Post a Job", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
              IconButton(icon: const Icon(Icons.close, color: Colors.white54), onPressed: () => Navigator.pop(context)),
            ],
          ),
          const SizedBox(height: 8),
          const Text("Create a new job listing to find the best talent.", style: TextStyle(color: Colors.white38, fontSize: 14)),
          const SizedBox(height: 24),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _sectionHeader("Job Details"),
                  _inputLabel("Job Title *"),
                  _textField(titleController, "e.g. Senior Frontend Engineer"),
                  _inputLabel("Employment Type *"),
                  _dropdown(empType, ["Full-time", "Part-time", "Contract", "Freelancer", "Internship"], (v) => setState(() => empType = v!)),
                  _inputLabel("Location *"),
                  _textField(locationController, "e.g. San Francisco, CA"),
                  _inputLabel("Work Mode *"),
                  _dropdown(workMode, ["Onsite", "Hybrid", "Remote"], (v) => setState(() => workMode = v!)),
                  _inputLabel("Salary Range"),
                  _textField(salaryController, "e.g. \$120k - \$160k"),
                  _inputLabel("Description"),
                  _textField(descriptionController, "Describe the role, responsibilities, and requirements...", maxLines: 4),
                  _inputLabel("Skills (comma separated)"),
                  _textField(skillsController, "e.g. React, TypeScript, Tailwind CSS"),
                  const SizedBox(height: 32),
                  _sectionHeader("Company Information"),
                  _inputLabel("Company Name *"),
                  _textField(companyController, "e.g. Google"),
                  _inputLabel("About Company"),
                  _textField(aboutCompanyController, "Brief description about the company...", maxLines: 4),
                  const SizedBox(height: 32),
                  _sectionHeader("Settings"),
                  _checkboxOption("Enable Easy Apply", "Allow candidates to apply with one click", enableEasyApply, (v) => setState(() => enableEasyApply = v!)),
                  _checkboxOption("Actively Hiring Badge", "Show an 'Actively Hiring' badge on the job card", activelyHiring, (v) => setState(() => activelyHiring = v!)),
                  const SizedBox(height: 40),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            side: const BorderSide(color: Colors.white10),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          child: const Text("Cancel", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (titleController.text.isEmpty || companyController.text.isEmpty) return;
                            final newJob = {
                              'id': DateTime.now().millisecondsSinceEpoch.toString(),
                              'title': titleController.text,
                              'company': companyController.text,
                              'initial': companyController.text[0].toUpperCase(),
                              'salary': salaryController.text.isEmpty ? 'Negotiable' : salaryController.text,
                              'salaryVal': 100,
                              'location': locationController.text,
                              'type': empType,
                              'workMode': workMode,
                              'time': 'Just now',
                              'applicants': '0 applicants applied',
                              'match': '100%',
                              'response': 'New job listing',
                              'isHiring': activelyHiring,
                              'isSaved': false,
                              'isEasyApply': enableEasyApply,
                            };
                            widget.onJobPosted(newJob);
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF6366F1),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          child: const Text("Post Job", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionHeader(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(text, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          const Divider(color: Colors.white10, height: 24),
        ],
      ),
    );
  }

  Widget _inputLabel(String text) {
    return Padding(padding: const EdgeInsets.only(bottom: 8, top: 16), child: Text(text, style: const TextStyle(color: Colors.white70, fontSize: 14)));
  }

  Widget _textField(TextEditingController controller, String hint, {int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white24),
        filled: true,
        fillColor: const Color(0xFF1E293B).withValues(alpha: 0.5),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.white10)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.white10)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }

  Widget _dropdown(String value, List<String> items, Function(String?) onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B).withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          items: items.map((e) => DropdownMenuItem(value: e, child: Text(e, style: const TextStyle(color: Colors.white)))).toList(),
          onChanged: onChanged,
          dropdownColor: const Color(0xFF1E293B),
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white54),
          isExpanded: true,
        ),
      ),
    );
  }

  Widget _checkboxOption(String title, String sub, bool value, Function(bool?) onChanged) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(color: const Color(0xFF1E293B).withValues(alpha: 0.3), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.white10)),
      child: CheckboxListTile(
        value: value,
        onChanged: onChanged,
        title: Text(title, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
        subtitle: Text(sub, style: const TextStyle(color: Colors.white38, fontSize: 12)),
        activeColor: const Color(0xFF6366F1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}

class _AnalyticsModal extends StatelessWidget {
  final Map<String, dynamic> job;
  const _AnalyticsModal({required this.job});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: const BoxDecoration(color: Color(0xFF0B1220), borderRadius: BorderRadius.vertical(top: Radius.circular(32))),
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Job Analytics", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
              IconButton(icon: const Icon(Icons.close, color: Colors.white54), onPressed: () => Navigator.pop(context)),
            ],
          ),
          const SizedBox(height: 24),
          _statCard("Total Applicants", job['applicants'].toString().split(' ')[0]),
          const SizedBox(height: 16),
          _statCard("Views", "142"),
          const SizedBox(height: 16),
          _statCard("Saves", "12"),
          const Spacer(),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6366F1), minimumSize: const Size(double.infinity, 56), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
            child: const Text("View Applicants List", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _statCard(String label, String val) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: const Color(0xFF111827), borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.white10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.white70, fontSize: 16)),
          Text(val, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class _JobDetailsPage extends StatefulWidget {
  final Map<String, dynamic> job;
  final VoidCallback onApply;
  final VoidCallback onToggleSave;
  const _JobDetailsPage({required this.job, required this.onApply, required this.onToggleSave});
  @override
  State<_JobDetailsPage> createState() => _JobDetailsPageState();
}

class _JobDetailsPageState extends State<_JobDetailsPage> {
  @override
  Widget build(BuildContext context) {
    bool isSaved = widget.job['isSaved'] ?? false;
    return Scaffold(
      backgroundColor: const Color(0xFF0B1220),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white), onPressed: () => Navigator.pop(context)),
        title: Text(widget.job['title'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(icon: const Icon(Icons.share_outlined, color: Colors.white), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(color: const Color(0xFF111827), borderRadius: BorderRadius.circular(24), border: Border.all(color: Colors.white.withValues(alpha: 0.05))),
              child: Column(
                children: [
                  Container(
                    width: 64, height: 64,
                    alignment: Alignment.center,
                    child: Text(widget.job['initial'], style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 20),
                  Text(widget.job['title'], style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.business, color: Colors.white54, size: 18),
                      const SizedBox(width: 8),
                      Text(widget.job['company'], style: const TextStyle(color: Colors.white70, fontSize: 16)),
                      const SizedBox(width: 16),
                      const Icon(Icons.location_on_outlined, color: Colors.white54, size: 18),
                      const SizedBox(width: 8),
                      Text(widget.job['location'], style: const TextStyle(color: Colors.white70, fontSize: 16)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.access_time, color: Colors.white38, size: 16),
                      const SizedBox(width: 6),
                      Text(widget.job['time'], style: const TextStyle(color: Colors.white38, fontSize: 14)),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _tag(widget.job['type']),
                      const SizedBox(width: 8),
                      _tag("Hybrid"),
                      const SizedBox(width: 8),
                      _tag(widget.job['salary'], isGreen: true),
                    ],
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: widget.onApply,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6366F1),
                      minimumSize: const Size(double.infinity, 56),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.bolt, color: Colors.white),
                        SizedBox(width: 8),
                        Text("Quick Apply", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  OutlinedButton(
                    onPressed: () {
                      widget.onToggleSave();
                      setState(() {});
                    },
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 56),
                      side: BorderSide(color: isSaved ? Colors.pinkAccent : Colors.white10),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(isSaved ? Icons.bookmark : Icons.bookmark_border, color: isSaved ? Colors.pinkAccent : Colors.white),
                        const SizedBox(width: 8),
                        Text(isSaved ? "Saved" : "Save Job", style: TextStyle(color: isSaved ? Colors.pinkAccent : Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _section("About the Job", "We are looking for a talented individual to join our growing team. You will be working on cutting-edge technologies and solving complex problems."),
            const SizedBox(height: 24),
            const Text("Skills Required", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Wrap(
              spacing: 10,
              children: ["React", "TypeScript", "Node.js", "Design Systems"].map((s) => _skillTag(s)).toList(),
            ),
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(color: const Color(0xFF111827), borderRadius: BorderRadius.circular(24), border: Border.all(color: Colors.white.withValues(alpha: 0.05))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.bolt, color: Color(0xFFA855F7), size: 20),
                      SizedBox(width: 8),
                      Text("Recruiter Insights", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(widget.job['response'], style: const TextStyle(color: Colors.white54, fontSize: 14)),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Your Match", style: TextStyle(color: Colors.white70, fontSize: 16)),
                      Text(widget.job['match'], style: const TextStyle(color: Color(0xFF6366F1), fontSize: 16, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  LinearProgressIndicator(
                    value: double.parse(widget.job['match'].replaceAll('%', '')) / 100,
                    backgroundColor: Colors.white10,
                    color: const Color(0xFF6366F1),
                    minHeight: 6,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _section("About ${widget.job['company']}", "We are a leading company in our industry, dedicated to innovation and excellence."),
            const SizedBox(height: 16),
            _companyInfoRow("Industry", "Technology"),
            _companyInfoRow("Type", "MNC"),
            _companyInfoRow("Headquarters", widget.job['location']),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _tag(String text, {bool isGreen = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(color: isGreen ? Colors.green.withValues(alpha: 0.1) : Colors.white.withValues(alpha: 0.05), borderRadius: BorderRadius.circular(8)),
      child: Text(text, style: TextStyle(color: isGreen ? Colors.greenAccent : Colors.white70, fontSize: 13, fontWeight: FontWeight.w500)),
    );
  }

  Widget _skillTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(color: const Color(0xFF1E293B), borderRadius: BorderRadius.circular(20)),
      child: Text(text, style: const TextStyle(color: Colors.white70, fontSize: 14)),
    );
  }

  Widget _section(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Text(content, style: const TextStyle(color: Colors.white54, fontSize: 15, height: 1.6)),
      ],
    );
  }

  Widget _companyInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.white38, fontSize: 15)),
          Text(value, style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
