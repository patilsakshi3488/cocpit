import 'package:flutter/material.dart';
import '../models/event_model.dart';
import 'event_card.dart';
import 'event_details_screen.dart';
import 'create_event_screen.dart';
import 'bottom_navigation.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchCtrl = TextEditingController();

  // State
  List<EventModel> allEvents = [
    EventModel(
      title: 'Web Development Workshop',
      description: 'A hands-on workshop for learning web development from scratch using modern frameworks.',
      location: 'New York, NY',
      image: 'lib/images/event1.jpg',
      category: 'Workshop',
      eventType: 'In-person',
      startDate: '25 MAR',
      startTime: '14:00',
      endDate: '25 MAR',
      endTime: '18:00',
      isFree: true,
      totalRegistrations: 89,
    ),
    EventModel(
      title: 'Product Management Summit 2025',
      description: 'An annual summit for product managers to learn about the latest industry trends and networking.',
      location: 'San Francisco, CA',
      image: 'lib/images/event2.jpg',
      category: 'Summit',
      eventType: 'Online',
      startDate: '15 MAR',
      startTime: '10:00',
      endDate: '15 MAR',
      endTime: '17:00',
      isFree: false,
      totalRegistrations: 234,
    ),
  ];

  List<String> registeredEventTitles = [];
  List<String> savedEventTitles = [];

  // Filters
  bool fOnline = false;
  bool fInPerson = false;
  bool fFree = false;
  bool fPaid = false;
  Map<String, bool> fCategories = {
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

  @override
  void dispose() {
    _tabController.dispose();
    _searchCtrl.dispose();
    super.dispose();
  }

  List<EventModel> get _filteredEvents {
    return allEvents.where((e) {
      final query = _searchCtrl.text.toLowerCase();
      final matchesSearch = e.title.toLowerCase().contains(query) || e.description.toLowerCase().contains(query);
      final matchesType = (!fOnline && !fInPerson) || (fOnline && e.eventType == 'Online') || (fInPerson && e.eventType == 'In-person');
      final matchesPrice = (!fFree && !fPaid) || (fFree && e.isFree) || (fPaid && !e.isFree);
      final activeCats = fCategories.entries.where((c) => c.value).map((c) => c.key).toList();
      final matchesCategory = activeCats.isEmpty || activeCats.contains(e.category);
      return matchesSearch && matchesType && matchesPrice && matchesCategory;
    }).toList();
  }

  void _openFilterSheet() {
    bool tOnline = fOnline;
    bool tInPerson = fInPerson;
    bool tFree = fFree;
    bool tPaid = fPaid;
    Map<String, bool> tCats = Map.from(fCategories);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setSS) => DraggableScrollableSheet(
          initialChildSize: 0.8,
          maxChildSize: 0.9,
          minChildSize: 0.5,
          builder: (_, controller) => Container(
            decoration: const BoxDecoration(color: Color(0xFF0B1220), borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const SizedBox(height: 12),
                Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(2))),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView(
                    controller: controller,
                    children: [
                      const Text('Filters', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 30),
                      _fSection('Event Type'),
                      _fItem('Online', tOnline, (v) => setSS(() => tOnline = v)),
                      _fItem('In-person', tInPerson, (v) => setSS(() => tInPerson = v)),
                      const SizedBox(height: 20),
                      _fSection('Price'),
                      _fItem('Free', tFree, (v) => setSS(() => tFree = v)),
                      _fItem('Paid', tPaid, (v) => setSS(() => tPaid = v)),
                      const SizedBox(height: 20),
                      _fSection('Category'),
                      ...tCats.keys.map((cat) => _fItem(cat, tCats[cat]!, (v) => setSS(() => tCats[cat] = v))),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            setSS(() {
                              tOnline = false; tInPerson = false; tFree = false; tPaid = false;
                              tCats.updateAll((k, v) => false);
                            });
                          },
                          style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.white12), padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                          child: const Text('Reset', style: TextStyle(color: Colors.white70)),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() { fOnline = tOnline; fInPerson = tInPerson; fFree = tFree; fPaid = tPaid; fCategories = tCats; });
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6366F1), padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                          child: const Text('Apply Filters', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _fSection(String t) => Padding(padding: const EdgeInsets.only(bottom: 12), child: Text(t, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)));
  Widget _fItem(String l, bool s, Function(bool) onTap) => GestureDetector(
    onTap: () => onTap(!s),
    behavior: HitTestBehavior.opaque,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(width: 22, height: 22, decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), border: Border.all(color: s ? const Color(0xFF6366F1) : Colors.white24, width: 2), color: s ? const Color(0xFF6366F1) : Colors.transparent), child: s ? const Icon(Icons.check, size: 16, color: Colors.white) : null),
          const SizedBox(width: 14),
          Text(l, style: const TextStyle(color: Colors.white70, fontSize: 16)),
        ],
      ),
    ),
  );

  void _onEventTap(EventModel event) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EventDetailsScreen(
          event: event,
          isRegistered: registeredEventTitles.contains(event.title),
          isSaved: savedEventTitles.contains(event.title),
          onSaveToggle: (saved) {
            setState(() {
              if (saved) {
                if (!savedEventTitles.contains(event.title)) savedEventTitles.add(event.title);
              } else {
                savedEventTitles.remove(event.title);
              }
            });
          },
          onRegister: () {
            setState(() {
              if (!registeredEventTitles.contains(event.title)) {
                registeredEventTitles.add(event.title);
                event.totalRegistrations++;
              }
            });
          },
          onCancelRegistration: () {
            setState(() {
              registeredEventTitles.remove(event.title);
              event.totalRegistrations--;
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1220),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Events', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
                  const Text('Discover and join professional events', style: TextStyle(color: Colors.white54, fontSize: 16)),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: const LinearGradient(colors: [Color(0xFF6366F1), Color(0xFF818CF8)]),
                      ),
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          final res = await Navigator.push(context, MaterialPageRoute(builder: (_) => const CreateEventScreen()));
                          if (res != null) {
                            setState(() {
                              final e = (res as EventModel).copyWith(createdByMe: true);
                              allEvents.add(e);
                              _tabController.index = 3;
                            });
                          }
                        },
                        icon: const Icon(Icons.add, color: Colors.white),
                        label: const Text('Create Event', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 52,
                          decoration: BoxDecoration(color: const Color(0xFF111827), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.white10)),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: [
                              const Icon(Icons.search, color: Colors.white24),
                              const SizedBox(width: 12),
                              Expanded(
                                child: TextField(
                                  controller: _searchCtrl,
                                  style: const TextStyle(color: Colors.white),
                                  onChanged: (v) => setState(() {}),
                                  decoration: const InputDecoration(hintText: 'Search events...', hintStyle: TextStyle(color: Colors.white24), border: InputBorder.none),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      GestureDetector(
                        onTap: _openFilterSheet,
                        child: Container(
                          height: 52, width: 100,
                          decoration: BoxDecoration(color: const Color(0xFF111827), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.white10)),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.filter_list, color: Colors.white),
                              SizedBox(width: 8),
                              Text('Filter', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // 👉 Suggested for you section
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Text(
                'Suggested for you',
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 160,
              child: ListView.builder(
                padding: const EdgeInsets.only(left: 20),
                scrollDirection: Axis.horizontal,
                itemCount: allEvents.length,
                itemBuilder: (context, index) => _suggestedCard(allEvents[index]),
              ),
            ),
            const SizedBox(height: 10),

            TabBar(
              controller: _tabController,
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              indicatorColor: const Color(0xFF6366F1),
              labelColor: const Color(0xFF6366F1),
              unselectedLabelColor: Colors.white38,
              dividerColor: Colors.transparent,
              tabs: const [Tab(text: 'Upcoming'), Tab(text: 'Registered'), Tab(text: 'Saved'), Tab(text: 'My Events')],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _evList(_filteredEvents),
                  _evList(allEvents.where((e) => registeredEventTitles.contains(e.title)).toList()),
                  _evList(allEvents.where((e) => savedEventTitles.contains(e.title)).toList()),
                  _evList(allEvents.where((e) => e.createdByMe).toList(), isMy: true),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNavigation(currentIndex: 3),
    );
  }

  Widget _suggestedCard(EventModel event) {
    return GestureDetector(
      onTap: () => _onEventTap(event),
      child: Container(
        width: 240,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: const Color(0xFF111827),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.asset(
                event.image,
                height: 90,
                width: 240,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(height: 90, color: Colors.grey[900]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 12, color: Colors.white54),
                      const SizedBox(width: 4),
                      Expanded(child: Text(event.location, maxLines: 1, style: const TextStyle(color: Colors.white54, fontSize: 12))),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _evList(List<EventModel> events, {bool isMy = false}) {
    if (events.isEmpty) return const Center(child: Text('No events found', style: TextStyle(color: Colors.white24)));
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: events.length,
      itemBuilder: (context, i) => EventCard(
        event: events[i],
        isMyEvent: isMy,
        isRegistered: registeredEventTitles.contains(events[i].title),
        isSaved: savedEventTitles.contains(events[i].title),
        onSaveToggle: () {
          setState(() {
            if (savedEventTitles.contains(events[i].title)) {
              savedEventTitles.remove(events[i].title);
            } else {
              savedEventTitles.add(events[i].title);
            }
          });
        },
        onTap: () => _onEventTap(events[i]),
      ),
    );
  }
}
