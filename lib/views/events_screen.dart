import 'package:flutter/material.dart';
import '../models/event_model.dart';
import 'event_card.dart';
import 'event_details_screen.dart';
import 'create_event_screen.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;


  // ✅ FIXED EVENT DATA (MATCHES EventModel)
  final List<EventModel> allEvents = [
    EventModel(
      title: 'Product Management Summit',
      description: 'An annual summit for product managers.',
      location: 'San Francisco, CA',
      image: 'lib/images/event1.jpg',
      category: 'Business',
      eventType: 'In-person',
      startDate: '15 Mar 2025',
      startTime: '10:00 AM',
      endDate: '15 Mar 2025',
      endTime: '05:00 PM',
      isFree: true,
    ),
    EventModel(
      title: 'Global Networking Event',
      description: 'Meet professionals worldwide.',
      location: 'Online',
      image: 'lib/images/event2.jpg',
      category: 'Networking',
      eventType: 'Online',
      startDate: '20 Mar 2025',
      startTime: '06:00 PM',
      endDate: '20 Mar 2025',
      endTime: '08:00 PM',
      isFree: false,
    ),
  ];

  List<EventModel> registeredEvents = [];
  List<EventModel> savedEvents = [];
  List<EventModel> myEvents = [];

  final TextEditingController _searchCtrl = TextEditingController();

  bool filterOnline = false;
  bool filterInPerson = false;
  bool filterFree = false;
  bool filterPaid = false;

  final Map<String, bool> categoryFilters = {
    'Tech': false,
    'Business': false,
    'Networking': false,
    'Workshop': false,
    'Summit': false,
    'Conference': false,
    'Masterclass': false,
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  void _openCreateEvent() async {
    final EventModel? event = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const CreateEventScreen()),
    );

    if (event != null) {
      setState(() {
        final created = event.copyWith(createdByMe: true);
        myEvents.add(created);
        allEvents.add(created);
        _tabController.index = 3;
      });
    }
  }

  // ✅ COMPLETE FILTER LOGIC
  List<EventModel> get _filteredEvents {
    return allEvents.where((e) {
      final searchMatch =
      e.title.toLowerCase().contains(_searchCtrl.text.toLowerCase());

      final priceMatch = (!filterFree && !filterPaid) ||
          (filterFree && e.isFree) ||
          (filterPaid && !e.isFree);

      final typeMatch = (!filterOnline && !filterInPerson) ||
          (filterOnline && e.eventType == 'Online') ||
          (filterInPerson && e.eventType == 'In-person');

      final activeCategories =
      categoryFilters.entries.where((e) => e.value).map((e) => e.key);

      final categoryMatch =
          activeCategories.isEmpty || activeCategories.contains(e.category);

      return searchMatch && priceMatch && typeMatch && categoryMatch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1220),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _header(),
              const SizedBox(height: 16),
              _createButton(),
              const SizedBox(height: 16),
              _searchRow(),
              const SizedBox(height: 16),
              _tabs(),
              const SizedBox(height: 16),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _grid(_filteredEvents),
                    _grid(registeredEvents),
                    _grid(savedEvents),
                    _grid(myEvents, isMyEvents: true),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header() => const Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Events',
        style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 4),
      Text(
        'Discover and join professional events',
        style: TextStyle(color: Colors.white54),
      ),
    ],
  );

  Widget _createButton() => SizedBox(
    width: double.infinity,
    child: ElevatedButton.icon(
      onPressed: _openCreateEvent,
      icon: const Icon(Icons.add),
      label: const Text('Create Event'),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF6366F1),
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    ),
  );

  Widget _searchRow() => Row(
    children: [
      Expanded(
        child: Container(
          height: 46,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: const Color(0xFF1F2937),
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            controller: _searchCtrl,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              icon: Icon(Icons.search, color: Colors.white54),
              hintText: 'Search events...',
              hintStyle: TextStyle(color: Colors.white54),
              border: InputBorder.none,
            ),
            onChanged: (_) => setState(() {}),
          ),
        ),
      ),
      const SizedBox(width: 12),
      GestureDetector(
        onTap: _openFilterSheet,
        child: Container(
          height: 46,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: const Color(0xFF1F2937),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.filter_list, color: Colors.white),
        ),
      ),
    ],
  );

  // 🔥 FILTER SHEET (UNCHANGED UI, FIXED LOGIC)
  void _openFilterSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        padding: const EdgeInsets.only(top: 12),
        decoration: const BoxDecoration(
          color: Color(0xFF0B1220),
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _sheetHandle(),
                const SizedBox(height: 16),
                const Text(
                  'Filters',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),

                _filterCard(
                  title: 'Event Type',
                  children: [
                    _filterChip('Online', filterOnline,
                            (v) => setState(() => filterOnline = v)),
                    _filterChip('In-person', filterInPerson,
                            (v) => setState(() => filterInPerson = v)),
                  ],
                ),

                _filterCard(
                  title: 'Price',
                  children: [
                    _filterChip(
                        'Free', filterFree, (v) => setState(() => filterFree = v)),
                    _filterChip(
                        'Paid', filterPaid, (v) => setState(() => filterPaid = v)),
                  ],
                ),

                _filterCard(
                  title: 'Category',
                  children: categoryFilters.keys
                      .map(
                        (c) => _filterChip(
                      c,
                      categoryFilters[c]!,
                          (v) => setState(() => categoryFilters[c] = v),
                    ),
                  )
                      .toList(),
                ),

                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6366F1),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text(
                      'Apply Filters',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget _sheetHandle() {
    return Center(
      child: Container(
        width: 42,
        height: 4,
        decoration: BoxDecoration(
          color: Colors.white24,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Widget _filterCard({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF111827),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: children,
          ),
        ],
      ),
    );
  }

  Widget _filterChip(
      String label,
      bool selected,
      Function(bool) onChanged,
      ) {
    return GestureDetector(
      onTap: () => onChanged(!selected),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF6366F1) : const Color(0xFF1F2937),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: selected ? Colors.transparent : Colors.white12,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (selected)
              const Icon(Icons.check, size: 16, color: Colors.white),
            if (selected) const SizedBox(width: 6),
            Text(
              label,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }


  Widget _filterSection(String title, List<Widget> chips) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title,
          style: const TextStyle(color: Colors.white70, fontSize: 16)),
      const SizedBox(height: 10),
      Wrap(spacing: 10, runSpacing: 10, children: chips),
      const SizedBox(height: 16),
    ],
  );

  Widget _chip(String label, bool selected, Function(bool) onChanged) {
    return GestureDetector(
      onTap: () => onChanged(!selected),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF6366F1) : const Color(0xFF1F2937),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(label, style: const TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _tabs() => TabBar(
    controller: _tabController,
    indicatorColor: const Color(0xFF6366F1),
    labelColor: const Color(0xFF6366F1),
    unselectedLabelColor: Colors.white54,
    tabs: const [
      Tab(text: 'Upcoming'),
      Tab(text: 'Registered'),
      Tab(text: 'Saved'),
      Tab(text: 'My Events'),
    ],
  );

  Widget _grid(List<EventModel> events, {bool isMyEvents = false}) {
    if (events.isEmpty) {
      return const Center(
        child: Text('No events', style: TextStyle(color: Colors.white54)),
      );
    }

    return ListView.builder(
      itemCount: events.length,
      itemBuilder: (_, i) => EventCard(
        event: events[i],
        isMyEvent: isMyEvents,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => EventDetailsScreen(event: events[i]),
            ),
          );
        },
      ),
    );
  }
}
























/*import 'package:flutter/material.dart';
import '../models/event_model.dart';
import 'event_card.dart';
import 'event_details_screen.dart';
import 'create_event_screen.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // ================= ALL EVENTS =================
  final List<EventModel> allEvents = [
    EventModel(
      title: 'Product Management Summit 2025',
      date: 'March 15',
      location: 'San Francisco, CA',
      attendees: '234 attendees',
      image: 'lib/images/event1.jpg',
      description:
      'An annual summit for product managers to learn, connect, and grow.',
      isFree: true,
    ),
    EventModel(
      title: 'Tech Networking Mixer',
      date: 'March 20',
      location: 'Virtual Event',
      attendees: '156 attendees',
      image: 'lib/images/event2.jpg',
      description: 'A virtual networking event for tech professionals.',
      isFree: false,
    ),

    EventModel(
      title: 'Web Development Workshop',
      date: 'March 25',
      location: 'New York, NY',
      attendees: '89 attendees',
      image: 'lib/images/event3.jpg',
      description: 'Hands-on workshop on modern web technologies.',
      isFree: true,
    ),
    EventModel(
      title: 'Tech Networking Mixer',
      date: 'March 20',
      location: 'Virtual Event',
      attendees: '156 attendees',
      image: 'lib/images/event7.jpg',
      description: 'A virtual networking event for tech professionals.',
      isFree: false,
    ),
  ];

  // ================= PARTICIPATED (REGISTERED + ATTENDED) =================
  final List<EventModel> participatedEvents = [
    // 🔔 UPCOMING (REGISTERED)
    EventModel(
      title: 'Flutter Dev Conference',
      date: 'March 25, 2025',
      location: 'Hyderabad, India',
      attendees: '—',
      image: 'lib/images/event8.jpg',
      description:
      'An upcoming conference you have registered for focusing on Flutter and Dart best practices.',
      isFree: true,

      participationStatus: 'Registered',
      createdByMe: false,
      totalRegistrations: 210,
      attendedCount: 0,
    ),

    // ✅ COMPLETED (ATTENDED)
    EventModel(
      title: 'AI & ML Bootcamp',
      date: 'Jan 18–20, 2025',
      location: 'Mumbai, India',
      attendees: '98 attendees',
      image: 'lib/images/event6.jpg',
      description:
      'A 3-day intensive bootcamp you attended covering AI & ML fundamentals.',
      isFree: false,

      participationStatus: 'Completed',
      createdByMe: false,
      totalRegistrations: 110,
      attendedCount: 98,
    ),
  ];

  // ================= MY EVENTS (CREATED BY USER) =================
  final List<EventModel> myEvents = [
    EventModel(
      title: 'Flutter Dev Conference',
      date: 'April 10',
      location: 'Hyderabad, India',
      attendees: '75 registered',
      image: 'lib/images/event5.jpg',
      description:
      'Flutter conference created by you for mobile developers.',
      isFree: true,
      createdByMe: true,
      totalRegistrations: 75,
      attendedCount: 61,
      status: 'Upcoming',
    ),
    EventModel(
      title: 'UI/UX Design Sprint',
      date: 'Feb 2',
      location: 'Remote',
      attendees: '120 registered',
      image: 'lib/images/event7.jpg',
      description:
      'Design sprint conducted and completed successfully.',
      isFree: true,
      createdByMe: true,
      totalRegistrations: 120,
      attendedCount: 104,
      status: 'Completed',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  // ================= CREATE EVENT =================
  Future<void> _openCreateEvent() async {
    final EventModel? newEvent = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const CreateEventScreen()),
    );

    if (newEvent != null) {
      setState(() {
        allEvents.add(newEvent);
        myEvents.add(newEvent.copyWith(
          createdByMe: true,
          totalRegistrations: 0,
          attendedCount: 0,
          status: 'Upcoming',
        ));
        _tabController.index = 2; // My Events
      });
    }
  }

  // ================= UI =================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1220),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _header(),
              const SizedBox(height: 16),
              _searchAndCreate(),
              const SizedBox(height: 20),
              _tabs(),
              const SizedBox(height: 16),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _eventGrid(allEvents),
                    _eventGrid(participatedEvents),
                    _myEventGrid(myEvents),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ================= HEADER =================
  Widget _header() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Events',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 6),
        Text(
          'Discover, attend and manage professional events',
          style: TextStyle(color: Colors.white54),
        ),
      ],
    );
  }

  // ================= SEARCH + CREATE =================
  Widget _searchAndCreate() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 46,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: const Color(0xFF1F2937),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Row(
              children: [
                Icon(Icons.search, color: Colors.white54),
                SizedBox(width: 10),
                Text(
                  'Search events by title, location...',
                  style: TextStyle(color: Colors.white54),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        ElevatedButton.icon(
          onPressed: _openCreateEvent,
          icon: const Icon(Icons.add),
          label: const Text('Create Event'),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF7C83FF),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ],
    );
  }

  // ================= TABS =================
  Widget _tabs() {
    return TabBar(
      controller: _tabController,
      indicatorColor: const Color(0xFF7C83FF),
      labelColor: const Color(0xFF7C83FF),
      unselectedLabelColor: Colors.white54,
      tabs: const [
        Tab(text: 'All Events'),
        Tab(text: 'Participated'),
        Tab(text: 'My Events'),
      ],
    );
  }

  // ================= EVENT GRID =================
  Widget _eventGrid(List<EventModel> events) {
    if (events.isEmpty) {
      return const Center(
        child: Text('No events found',
            style: TextStyle(color: Colors.white54)),
      );
    }

    return GridView.builder(
      itemCount: events.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.72,
      ),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    EventDetailsScreen(event: events[index]),
              ),
            );
          },
          child: EventCard(event: events[index]),
        );
      },
    );
  }

  // ================= MY EVENTS GRID (WITH ANALYTICS) =================
  Widget _myEventGrid(List<EventModel> events) {
    return GridView.builder(
      itemCount: events.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.75,
      ),
      itemBuilder: (context, index) {
        return EventCard(
          event: events[index],
          showAnalytics: true,
        );
      },
    );
  }
}*/





































































/*import 'dart:io';
import 'package:flutter/material.dart';
import 'bottom_navigation.dart';
import 'create_event_screen.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // ================= DATA =================

  final List<EventData> allEvents = [
    EventData(
      title: 'Tech Summit 2024: AI & Innovation',
      date: 'Dec 20, 2024',
      location: 'San Francisco',
      attendees: '1250 attendees',
      imagePath: 'lib/images/event1.jpg',
      isAsset: true,
    ),
  ];

  final List<EventData> participatedEvents = [];
  final List<EventData> myEvents = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  // ================= CREATE EVENT =================

  Future<void> _openCreateEvent() async {
    final EventData? newEvent = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const CreateEventScreen()),
    );

    if (newEvent != null) {
      setState(() {
        allEvents.add(newEvent);
        participatedEvents.add(newEvent);
        myEvents.add(newEvent);
        _tabController.index = 2; // My Events
      });
    }
  }

  // ================= DELETE =================

  void _deleteEvent(EventData event) {
    setState(() {
      allEvents.remove(event);
      participatedEvents.remove(event);
      myEvents.remove(event);
    });
  }

  // ================= UI =================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1220),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _topBar(),
            _header(),
            _tabs(),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _eventList(allEvents, showActions: false),
                  _eventList(participatedEvents, showActions: false),
                  _eventList(myEvents, showActions: true), // 🔥 My Events
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNavigation(currentIndex: 3),
    );
  }

  // 🔝 TOP BAR
  Widget _topBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 42,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: const Color(0xFF1F2937),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                children: [
                  Icon(Icons.search, color: Colors.white54),
                  SizedBox(width: 10),
                  Text("Search events...",
                      style: TextStyle(color: Colors.white54)),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          IconButton(
            icon: const Icon(Icons.add_circle, color: Color(0xFF7C83FF)),
            onPressed: _openCreateEvent,
          ),
        ],
      ),
    );
  }

  // 📌 HEADER
  Widget _header() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Events",
            style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 6),
          Text(
            "Discover, create and manage events",
            style: TextStyle(color: Color(0xFF94A3B8)),
          ),
        ],
      ),
    );
  }

  // 📑 TABS
  Widget _tabs() {
    return TabBar(
      controller: _tabController,
      indicatorColor: const Color(0xFF7C83FF),
      labelColor: const Color(0xFF7C83FF),
      unselectedLabelColor: Colors.white54,
      tabs: const [
        Tab(text: 'All Events'),
        Tab(text: 'Participated'),
        Tab(text: 'My Events'),
      ],
    );
  }

  // 📅 EVENT LIST
  Widget _eventList(List<EventData> events, {required bool showActions}) {
    if (events.isEmpty) {
      return const Center(
        child: Text("No events yet",
            style: TextStyle(color: Colors.white54)),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: events.length,
      itemBuilder: (context, index) {
        return EventCard(
          event: events[index],
          showActions: showActions,
          onDelete: () => _deleteEvent(events[index]),
        );
      },
    );
  }
}

// ================= MODEL =================

class EventData {
  final String title;
  final String date;
  final String location;
  final String attendees;
  final String imagePath;
  final bool isAsset;

  EventData({
    required this.title,
    required this.date,
    required this.location,
    required this.attendees,
    required this.imagePath,
    required this.isAsset,
  });
}

// ================= CARD =================

class EventCard extends StatelessWidget {
  final EventData event;
  final bool showActions;
  final VoidCallback? onDelete;

  const EventCard({
    super.key,
    required this.event,
    required this.showActions,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF1F2937),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius:
                const BorderRadius.vertical(top: Radius.circular(16)),
                child: event.isAsset
                    ? Image.asset(
                  event.imagePath,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )
                    : Image.file(
                  File(event.imagePath),
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              if (showActions)
                Positioned(
                  right: 8,
                  top: 8,
                  child: PopupMenuButton<String>(
                    color: const Color(0xFF1F2937),
                    onSelected: (value) {
                      if (value == 'delete') {
                        onDelete?.call();
                      }
                    },
                    itemBuilder: (context) => const [
                      PopupMenuItem(
                        value: 'delete',
                        child: Text("Delete",
                            style: TextStyle(color: Colors.redAccent)),
                      ),
                    ],
                    icon: const Icon(Icons.more_vert, color: Colors.white),
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(event.title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                _info(Icons.calendar_today, event.date),
                _info(Icons.location_on, event.location),
                _info(Icons.people, event.attendees),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _info(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.white54),
          const SizedBox(width: 8),
          Text(text, style: const TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }
}*/
