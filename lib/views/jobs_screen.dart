import 'package:flutter/material.dart';
import 'chat_screen.dart';
import 'notification_screen.dart';
import 'bottom_navigation.dart';
import 'my_jobs_screen.dart';
import 'apply_job_screen.dart';
import 'offers_screen.dart';

class JobsScreen extends StatefulWidget {
  const JobsScreen({super.key});

  @override
  State<JobsScreen> createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {
  int bottomIndex = 1;
  int mainTab = 0;
  // SEARCH STATE
  bool expandSearch = false;
  String keyword = '';


  /* ================= THEME ================= */
  final Color bg = const Color(0xFF0B1220);
  final Color card = const Color(0xFF111827);
  final Color border = const Color(0xFF1F2937);

  final Gradient gradient =
  const LinearGradient(colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)]);

  /* ================= FILTER STATE ================= */
  bool showFilter = false;

  bool fullTime = false;
  bool partTime = false;
  bool contract = false;
  bool remote = false;
  bool internship = false;

  String location = '';
  String experience = 'All Levels';
  String salary = 'Any';
  String datePosted = 'Any Time';

  /* ================= JOB DATA ================= */
  final List<Map<String, dynamic>> jobs = [
    {
      'title': 'Senior Financial Analyst',
      'company': 'JPMorgan Chase',
      'salary': '\$125k - \$155k',
      'location': 'New York, NY',
      'type': 'Full-time',
      'experience': 'Senior Level',
      'time': '2 days ago',
      'applicants': '25 applicants',
    },
    {
      'title': 'Business Analyst',
      'company': 'McKinsey & Company',
      'salary': '\$110k - \$140k',
      'location': 'Boston, MA',
      'type': 'Full-time',
      'experience': 'Mid Level',
      'time': '3 days ago',
      'applicants': '18 applicants',
    },
    {
      'title': 'Product Manager',
      'company': 'Google',
      'salary': '\$120k - \$180k',
      'location': 'San Francisco, CA',
      'type': 'Remote',
      'experience': 'Senior Level',
      'time': '1 day ago',
      'applicants': '40 applicants',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      appBar: _appBar(),
      bottomNavigationBar: AppBottomNavigation(currentIndex: bottomIndex),
      body: Stack(
        children: [
          Column(
            children: [
              _search(),
              _mainTabs(),
              _metaRow(),
              Expanded(child: _jobList()),
            ],
          ),
          if (showFilter) _filterOverlay(),
        ],
      ),
    );
  }

  /* ================= APP BAR ================= */

  AppBar _appBar() {
    return AppBar(
      backgroundColor: bg,
      elevation: 0,
      title: const Text('Jobs', style: TextStyle(color: Colors.white)),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_none, color: Colors.white),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const NotificationScreen()),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.chat_outlined, color: Colors.white),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ChatScreen()),
          ),
        ),
      ],
    );
  }

  /* ================= SEARCH ================= */

  Widget _search() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: border),
      ),
      child: expandSearch ? _expandedSearch() : _collapsedSearch(),
    );
  }
  Widget _collapsedSearch() {
    return Row(
      children: [
        const Icon(Icons.search, color: Colors.white54),
        const SizedBox(width: 10),
        const Expanded(
          child: Text(
            'Search jobs, companies...',
            style: TextStyle(color: Colors.white54),
          ),
        ),
        GestureDetector(
          onTap: () => setState(() => expandSearch = true),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
            decoration: BoxDecoration(
              gradient: gradient,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'Search',
              style: TextStyle(color: Colors.white),
            ),
          ),
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
        _searchInput(
          hint: 'Job title or company',
          onChanged: (v) => keyword = v,
        ),
        const SizedBox(height: 12),
        const Text('Location', style: TextStyle(color: Colors.white70)),
        const SizedBox(height: 6),
        _searchInput(
          hint: 'Type city...',
          icon: Icons.location_on,
          onChanged: (v) => location = v,
        ),
        const SizedBox(height: 16),
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () => setState(() => expandSearch = false),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
              decoration: BoxDecoration(
                gradient: gradient,
                borderRadius: BorderRadius.circular(22),
              ),
              child: const Text(
                'Search Jobs',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
  Widget _searchInput({
    required String hint,
    IconData? icon,
    required ValueChanged<String> onChanged,
  }) {
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: border),
      ),
      child: TextField(
        onChanged: onChanged,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white54),
          border: InputBorder.none,
          prefixIcon:
          icon != null ? Icon(icon, color: Colors.white54) : null,
        ),
      ),
    );
  }


  /* ================= TABS ================= */

  Widget _mainTabs() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Row(
        children: [
          _tab('View Jobs', 0),
          _tab('My Jobs', 1),
          _tab('Offers', 2, badge: '2'),
        ],
      ),
    );
  }

  Widget _tab(String text, int index, {String? badge}) {
    final active = mainTab == index;
    return GestureDetector(
      onTap: () {
        if (index == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const MyJobsScreen()),
          );
          return;
        }
        if (index == 2) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const OffersScreen()),
          );
          return;
        }
        setState(() => mainTab = index);
      },
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          gradient: active ? gradient : null,
          color: active ? null : card,
          borderRadius: BorderRadius.circular(22),
          border: active ? null : Border.all(color: border),
        ),
        child: Row(
          children: [
            Text(text, style: const TextStyle(color: Colors.white)),
            if (badge != null) ...[
              const SizedBox(width: 6),
              CircleAvatar(
                radius: 9,
                backgroundColor: Colors.pink,
                child: Text(badge,
                    style: const TextStyle(fontSize: 10, color: Colors.white)),
              )
            ]
          ],
        ),
      ),
    );
  }

  /* ================= META ROW ================= */

  Widget _metaRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('${_filteredJobs().length} jobs found',
              style: const TextStyle(color: Colors.white70)),
          GestureDetector(
            onTap: () => setState(() => showFilter = true),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
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

  /* ================= FILTER LOGIC ================= */

  List<Map<String, dynamic>> _filteredJobs() {
    return jobs.where((job) {
      if (location.isNotEmpty &&
          !job['location']
              .toLowerCase()
              .contains(location.toLowerCase())) return false;

      if (experience != 'All Levels' &&
          job['experience'] != experience) return false;

      if ((fullTime || partTime || contract || remote || internship) &&
          ![
            if (fullTime) 'Full-time',
            if (partTime) 'Part-time',
            if (contract) 'Contract',
            if (remote) 'Remote',
            if (internship) 'Internship',
          ].contains(job['type'])) return false;

      return true;
    }).toList();
  }

  /* ================= JOB LIST ================= */

  Widget _jobList() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: _filteredJobs().map(_jobCard).toList(),
    );
  }

  Widget _jobCard(Map<String, dynamic> job) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: border),
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              gradient: gradient,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(job['title'],
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text(job['company'],
                    style: const TextStyle(color: Colors.white70)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _meta(job['location']),
                    _dot(),
                    _meta(job['type']),
                    _dot(),
                    _meta(job['time']),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(job['salary'],
                        style:
                        const TextStyle(color: Colors.indigoAccent)),
                    const SizedBox(width: 12),
                    Text(job['applicants'],
                        style:
                        const TextStyle(color: Colors.white54)),
                  ],
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ApplyJobScreen(job: job),
              ),
            ),

            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 18, vertical: 10),
              decoration: BoxDecoration(
                gradient: gradient,
                borderRadius: BorderRadius.circular(18),
              ),
              child:
              const Text('Apply', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _meta(String t) =>
      Text(t, style: const TextStyle(color: Colors.white54, fontSize: 12));

  Widget _dot() => const Padding(
    padding: EdgeInsets.symmetric(horizontal: 6),
    child: Icon(Icons.circle, size: 4, color: Colors.white38),
  );

  /* ================= SLIDE FILTER OVERLAY ================= */

  Widget _filterOverlay() {
    return GestureDetector(
      onTap: () => setState(() => showFilter = false),
      child: Container(
        color: Colors.black54,
        child: Align(
          alignment: Alignment.centerLeft,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: MediaQuery.of(context).size.width * 0.85,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF1E293B),
              borderRadius:
              const BorderRadius.horizontal(right: Radius.circular(26)),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Filters',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),

                  const SizedBox(height: 24),
                  const Text('Job Type',
                      style: TextStyle(color: Colors.white70)),
                  _check('Full-time', fullTime,
                          (v) => setState(() => fullTime = v)),
                  _check('Part-time', partTime,
                          (v) => setState(() => partTime = v)),
                  _check('Contract', contract,
                          (v) => setState(() => contract = v)),
                  _check('Remote', remote,
                          (v) => setState(() => remote = v)),
                  _check('Internship', internship,
                          (v) => setState(() => internship = v)),

                  const SizedBox(height: 20),
                  const Text('Location',
                      style: TextStyle(color: Colors.white70)),
                  _locationInput(),

                  const SizedBox(height: 20),
                  const Text('Experience Level',
                      style: TextStyle(color: Colors.white70)),
                  _dropdown(experience, [
                    'All Levels',
                    'Entry Level',
                    'Mid Level',
                    'Senior Level',
                    'Lead/Manager',
                  ], (v) => setState(() => experience = v)),

                  const SizedBox(height: 20),
                  const Text('Salary Range',
                      style: TextStyle(color: Colors.white70)),
                  _dropdown(salary, [
                    'Any',
                    '\$80k - \$100k',
                    '\$100k - \$130k',
                    '\$130k - \$160k',
                    '\$160k+',
                  ], (v) => setState(() => salary = v)),

                  const SizedBox(height: 20),
                  const Text('Date Posted',
                      style: TextStyle(color: Colors.white70)),
                  _dropdown(datePosted, [
                    'Any Time',
                    'Past 24 hours',
                    'Past week',
                    'Past month',
                  ], (v) => setState(() => datePosted = v)),

                  const SizedBox(height: 30),
                  GestureDetector(
                    onTap: () => setState(() => showFilter = false),
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        gradient: gradient,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      alignment: Alignment.center,
                      child: const Text('Apply Filters',
                          style: TextStyle(
                              color: Colors.white, fontSize: 16)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _check(String text, bool value, ValueChanged<bool> onChanged) {
    return CheckboxListTile(
      value: value,
      onChanged: (v) => onChanged(v!),
      title: Text(text, style: const TextStyle(color: Colors.white)),
      activeColor: Colors.indigo,
      contentPadding: EdgeInsets.zero,
      controlAffinity: ListTileControlAffinity.leading,
    );
  }

  Widget _locationInput() {
    return Container(
      height: 44,
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: border),
      ),
      child: TextField(
        style: const TextStyle(color: Colors.white),
        decoration: const InputDecoration(
          hintText: 'Type city...',
          hintStyle: TextStyle(color: Colors.white54),
          border: InputBorder.none,
        ),
        onChanged: (v) => setState(() => location = v),
      ),
    );
  }

  Widget _dropdown(
      String value, List<String> items, ValueChanged<String> onChanged) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: border),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          dropdownColor: bg,
          style: const TextStyle(color: Colors.white),
          icon: const Icon(Icons.keyboard_arrow_down,
              color: Colors.white54),
          items: items
              .map((e) =>
              DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: (v) => onChanged(v!),
        ),
      ),
    );
  }
}


































//filter logic
/*
List<Map<String, dynamic>> _filteredJobs() {
  return jobs.where((job) {
    if (location.isNotEmpty &&
        !job['location']
            .toLowerCase()
            .contains(location.toLowerCase())) return false;

    if (experience != 'All Levels' &&
        job['experience'] != experience) return false;

    if ((fullTime || partTime || contract || remote || internship) &&
        ![
          if (fullTime) 'Full-time',
          if (partTime) 'Part-time',
          if (contract) 'Contract',
          if (remote) 'Remote',
          if (internship) 'Internship',
        ].contains(job['type'])) return false;

    return true;
  }).toList();
}

/* ================= JOB LIST ================= */

Widget _jobList() {
  return ListView(
    padding: const EdgeInsets.all(16),
    children: _filteredJobs().map(_jobCard).toList(),
  );
}

Widget _jobCard(Map<String, dynamic> job) {
  return Container(
    margin: const EdgeInsets.only(bottom: 18),
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: card,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: border),
    ),
    child: Row(
      children: [
        Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(job['title'],
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600)),
              const SizedBox(height: 4),
              Text(job['company'],
                  style: const TextStyle(color: Colors.white70)),
              const SizedBox(height: 8),
              Row(
                children: [
                  _meta(job['location']),
                  _dot(),
                  _meta(job['type']),
                  _dot(),
                  _meta(job['time']),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(job['salary'],
                      style:
                      const TextStyle(color: Colors.indigoAccent)),
                  const SizedBox(width: 12),
                  Text(job['applicants'],
                      style:
                      const TextStyle(color: Colors.white54)),
                ],
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ApplyJobScreen()),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 18, vertical: 10),
            decoration: BoxDecoration(
              gradient: gradient,
              borderRadius: BorderRadius.circular(18),
            ),
            child:
            const Text('Apply', style: TextStyle(color: Colors.white)),
          ),
        ),
      ],
    ),
  );
}

Widget _meta(String t) =>
    Text(t, style: const TextStyle(color: Colors.white54, fontSize: 12));

Widget _dot() => const Padding(
  padding: EdgeInsets.symmetric(horizontal: 6),
  child: Icon(Icons.circle, size: 4, color: Colors.white38),
);

/* ================= SLIDE FILTER OVERLAY ================= */

Widget _filterOverlay() {
  return GestureDetector(
    onTap: () => setState(() => showFilter = false),
    child: Container(
      color: Colors.black54,
      child: Align(
        alignment: Alignment.centerLeft,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: MediaQuery.of(context).size.width * 0.85,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF1E293B),
            borderRadius:
            const BorderRadius.horizontal(right: Radius.circular(26)),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Filters',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),

                const SizedBox(height: 24),
                const Text('Job Type',
                    style: TextStyle(color: Colors.white70)),
                _check('Full-time', fullTime,
                        (v) => setState(() => fullTime = v)),
                _check('Part-time', partTime,
                        (v) => setState(() => partTime = v)),
                _check('Contract', contract,
                        (v) => setState(() => contract = v)),
                _check('Remote', remote,
                        (v) => setState(() => remote = v)),
                _check('Internship', internship,
                        (v) => setState(() => internship = v)),

                const SizedBox(height: 20),
                const Text('Location',
                    style: TextStyle(color: Colors.white70)),
                _locationInput(),

                const SizedBox(height: 20),
                const Text('Experience Level',
                    style: TextStyle(color: Colors.white70)),
                _dropdown(experience, [
                  'All Levels',
                  'Entry Level',
                  'Mid Level',
                  'Senior Level',
                  'Lead/Manager',
                ], (v) => setState(() => experience = v)),

                const SizedBox(height: 20),
                const Text('Salary Range',
                    style: TextStyle(color: Colors.white70)),
                _dropdown(salary, [
                  'Any',
                  '\$80k - \$100k',
                  '\$100k - \$130k',
                  '\$130k - \$160k',
                  '\$160k+',
                ], (v) => setState(() => salary = v)),

                const SizedBox(height: 20),
                const Text('Date Posted',
                    style: TextStyle(color: Colors.white70)),
                _dropdown(datePosted, [
                  'Any Time',
                  'Past 24 hours',
                  'Past week',
                  'Past month',
                ], (v) => setState(() => datePosted = v)),

                const SizedBox(height: 30),
                GestureDetector(
                  onTap: () => setState(() => showFilter = false),
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      gradient: gradient,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    alignment: Alignment.center,
                    child: const Text('Apply Filters',
                        style: TextStyle(
                            color: Colors.white, fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

Widget _check(String text, bool value, ValueChanged<bool> onChanged) {
  return CheckboxListTile(
    value: value,
    onChanged: (v) => onChanged(v!),
    title: Text(text, style: const TextStyle(color: Colors.white)),
    activeColor: Colors.indigo,
    contentPadding: EdgeInsets.zero,
    controlAffinity: ListTileControlAffinity.leading,
  );
}

Widget _locationInput() {
  return Container(
    height: 44,
    margin: const EdgeInsets.only(top: 8),
    padding: const EdgeInsets.symmetric(horizontal: 12),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: border),
    ),
    child: TextField(
      style: const TextStyle(color: Colors.white),
      decoration: const InputDecoration(
        hintText: 'Type city...',
        hintStyle: TextStyle(color: Colors.white54),
        border: InputBorder.none,
      ),
      onChanged: (v) => setState(() => location = v),
    ),
  );
}

Widget _dropdown(
    String value, List<String> items, ValueChanged<String> onChanged) {
  return Container(
    margin: const EdgeInsets.only(top: 8),
    padding: const EdgeInsets.symmetric(horizontal: 12),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: border),
    ),
    child: DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: value,
        isExpanded: true,
        dropdownColor: bg,
        style: const TextStyle(color: Colors.white),
        icon: const Icon(Icons.keyboard_arrow_down,
            color: Colors.white54),
        items: items
            .map((e) =>
            DropdownMenuItem(value: e, child: Text(e)))
            .toList(),
        onChanged: (v) => onChanged(v!),
      ),
    ),
  );
}
}*/
