import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/guest_webview.dart';
import 'package:shared_preferences/shared_preferences.dart'; // <-- ADD THIS IMPORT
import 'dart:convert'; // <-- ADD THIS IMPORT

class StudentDashboardPage extends StatefulWidget {
  const StudentDashboardPage({super.key});

  @override
  State<StudentDashboardPage> createState() => _StudentDashboardPageState();
}

class _StudentDashboardPageState extends State<StudentDashboardPage> {
  final List<Map<String, dynamic>> _studentTools = const [
    {
      'title': 'myLEO',
      'url': 'https://leoportal.tamuc.edu/uPortal/f/welcome/normal/render.uP',
      'icon': Icons.school,
      'color': Color(0xFF002147), // Navy Blue
    },
    {
      'title': 'My Classes (D2L)',
      'url': 'https://myleoonline.tamuc.edu/d2l/login',
      'icon': Icons.laptop_mac,
      'color': Color(0xFF002147), // Gold
    },
    {
      'title': 'Library Resources',
      'url': 'https://idp.tamuc.edu/idp/profile/cas/login?execution=e8s1',
      'icon': Icons.menu_book,
      'color': Color(0xFF002147), // Dark Blue-Gray
    },
    {
      'title': 'Graduate DegreeWorks',
      'url': 'https://leoportal.tamuc.edu/uPortal/f/welcome/normal/render.uP',
      'icon': Icons.account_balance,
      'color': Color(0xFF002147), // Navy Blue
    },
    {
      'title': 'Undergraduate DegreeWorks',
      'url': 'https://leoportal.tamuc.edu/uPortal/f/welcome/normal/render.uP',
      'icon': Icons.school_outlined,
      'color': Color(0xFF002147), // Gold
    },
  ];

  Map<DateTime, List<String>> _events = {}; // <-- ADD THIS

  List<Map<String, dynamic>> _upcomingEvents = [];
  bool _isLoadingEvents = true;

  @override
  void initState() {
    super.initState();
    _loadEvents();
    loadUpcomingEvents();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadEvents();
  }

  Future<void> _loadEvents() async {
    final prefs = await SharedPreferences.getInstance();
    final savedEvents = prefs.getString('calendar_events');
    if (savedEvents != null) {
      final Map<String, dynamic> decoded = json.decode(savedEvents);
      setState(() {
        _events = decoded.map((key, value) {
          final dateKey = DateTime.parse(key);
          final eventsList = List<String>.from(value);
          return MapEntry(dateKey, eventsList);
        });
        _events.removeWhere((key, value) => value.isEmpty);
      });
    } else {
      setState(() {
        _events = {};
      });
    }
  }

  Future<void> loadUpcomingEvents() async {
    setState(() => _isLoadingEvents = true);
    final prefs = await SharedPreferences.getInstance();
    final savedEvents = prefs.getString('calendar_events');
    if (savedEvents != null) {
      final Map<String, dynamic> decoded = json.decode(savedEvents);
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final upcoming =
          decoded.entries
              .map((entry) {
                final date = DateTime.parse(entry.key);
                final events = List<String>.from(entry.value);
                return events
                    .where(
                      (event) =>
                          date.isAtSameMomentAs(today) || date.isAfter(today),
                    )
                    .map((eventTitle) => {'date': date, 'title': eventTitle});
              })
              .expand((eventList) => eventList)
              .toList();
      upcoming.sort(
        (a, b) => (a['date'] as DateTime).compareTo(b['date'] as DateTime),
      );
      setState(() {
        _upcomingEvents = upcoming;
        _isLoadingEvents = false;
      });
    } else {
      setState(() {
        _upcomingEvents = [];
        _isLoadingEvents = false;
      });
    }
  }

  void refreshDashboard() {
    loadUpcomingEvents();
  }

  List<Map<String, dynamic>> _getUpcomingEvents() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final upcoming =
        _events.entries
            .where((entry) {
              final entryDate = DateTime(
                entry.key.year,
                entry.key.month,
                entry.key.day,
              );
              return entryDate.isAtSameMomentAs(today) ||
                  entryDate.isAfter(today);
            })
            .expand(
              (entry) => entry.value.map(
                (event) => {'date': entry.key, 'title': event},
              ),
            )
            .toList();
    upcoming.sort((a, b) {
      final aDate = a['date'] as DateTime;
      final bDate = b['date'] as DateTime;
      return aDate.compareTo(bDate);
    });
    return upcoming;
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning';
    if (hour < 17) return 'Good Afternoon';
    return 'Good Evening';
  }

  String _getUserName() {
    final user = FirebaseAuth.instance.currentUser;
    return user?.displayName ?? 'Lion';
  }

  @override
  Widget build(BuildContext context) {
    const Color bgColor = Color(0xFFF8F9FB);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const SizedBox(),
        title: const Text(
          'Student Dashboard',
          style: TextStyle(fontFamily: 'BreeSerif', color: Colors.black87),
        ),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await _loadEvents();
            await loadUpcomingEvents();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${_getGreeting()}, ${_getUserName()} 👋',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'BreeSerif',
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Explore your campus tools below',
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
                const SizedBox(height: 20),

                // Search Bar
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 6,
                        color: Colors.black12,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      icon: Icon(Icons.search),
                      hintText: 'Search...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Upcoming Events Section (better design)
                if (_isLoadingEvents)
                  const Center(child: CircularProgressIndicator())
                else if (_upcomingEvents.isEmpty)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey.shade50,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.blueGrey.shade100),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'No Upcoming Events',
                          style: TextStyle(
                            fontFamily: 'BreeSerif',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'Go to Calendar to add a new event!',
                          style: TextStyle(
                            fontFamily: 'BreeSerif',
                            fontSize: 14,
                            color: Colors.black45,
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Upcoming Events',
                        style: TextStyle(
                          fontFamily: 'BreeSerif',
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _upcomingEvents.length,
                        itemBuilder: (context, index) {
                          final event = _upcomingEvents[index];
                          final eventTitle = event['title'] as String;
                          final eventDate = event['date'] as DateTime;

                          return Dismissible(
                            key: Key(
                              '$eventTitle${eventDate.toIso8601String()}',
                            ),
                            background: Container(
                              padding: const EdgeInsets.only(left: 20),
                              alignment: Alignment.centerLeft,
                              color: Colors.redAccent,
                              child: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                            direction: DismissDirection.startToEnd,
                            onDismissed: (direction) async {
                              final prefs =
                                  await SharedPreferences.getInstance();
                              final savedEvents = prefs.getString(
                                'calendar_events',
                              );
                              if (savedEvents != null) {
                                final Map<String, dynamic> decoded = json
                                    .decode(savedEvents);
                                final dateKey =
                                    eventDate
                                        .toIso8601String()
                                        .split('T')
                                        .first;
                                if (decoded.containsKey(dateKey)) {
                                  final List<String> titles = List<String>.from(
                                    decoded[dateKey],
                                  );
                                  titles.remove(eventTitle);
                                  if (titles.isEmpty) {
                                    decoded.remove(dateKey);
                                  } else {
                                    decoded[dateKey] = titles;
                                  }
                                  await prefs.setString(
                                    'calendar_events',
                                    json.encode(decoded),
                                  );
                                }
                              }
                              setState(() {
                                _upcomingEvents.removeAt(
                                  index,
                                ); // Immediately remove from the list
                              });
                            },
                            child: InkWell(
                              onTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Event details coming soon!'),
                                  ),
                                );
                              },
                              borderRadius: BorderRadius.circular(16),
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 16),
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 6,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Icon(
                                      Icons.event,
                                      color: Color(0xFFFFD700),
                                      size: 32,
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            eventTitle,
                                            style: const TextStyle(
                                              fontFamily: 'BreeSerif',
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            '${eventDate.month}/${eventDate.day}/${eventDate.year}',
                                            style: const TextStyle(
                                              fontFamily: 'BreeSerif',
                                              fontSize: 14,
                                              color: Colors.black54,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                const SizedBox(height: 20),

                // Grid Tools Section
                GridView.builder(
                  itemCount: _studentTools.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.0,
                  ),
                  itemBuilder: (context, index) {
                    final item = _studentTools[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (_) => GuestWebViewPage(
                                  title: item['title'],
                                  url: item['url'],
                                ),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: item['color'],
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: item['color'].withOpacity(0.3),
                              blurRadius: 6,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(item['icon'], size: 30, color: Colors.white),
                            const SizedBox(height: 12),
                            Text(
                              item['title'],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: 'BreeSerif',
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
