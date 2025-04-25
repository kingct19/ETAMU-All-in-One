import 'package:flutter/material.dart';
import 'package:etamu_all_in_one/theme.dart';
import '../widgets/guest_webview.dart';

class GuestMenuTab extends StatefulWidget {
  const GuestMenuTab({super.key});

  @override
  State<GuestMenuTab> createState() => _GuestMenuTabState();
}

class _GuestMenuTabState extends State<GuestMenuTab> {
  bool _showPreferences = false;
  bool _darkMode = false;

  final List<Map<String, dynamic>> _menuItems = const [
    {
      'title': 'Apply to ETAMU',
      'url': 'https://www.tamuc.edu/apply/',
      'icon': Icons.school,
      'color': Color(0xFF002147),
    },
    {
      'title': 'Academic Calendar',
      'url': 'https://calendar.tamuc.edu/academic',
      'icon': Icons.calendar_month,
      'color': Color(0xFF002147),
    },
    {
      'title': 'Directory',
      'url': 'https://appsprod.tamuc.edu/pb/Default.asp?search=keywordresult',
      'icon': Icons.contact_page,
      'color': Color(0xFF002147),
    },
    {
      'title': 'Campus Map',
      'url': 'https://www.tamuc.edu/map/',
      'icon': Icons.map,
      'color': Color(0xFF002147),
    },
    {
      'title': 'Parking',
      'url': 'https://www.tamuc.edu/parking/',
      'icon': Icons.local_parking,
      'color': Color(0xFF002147),
    },
    {
      'title': 'Athletics',
      'url': 'https://lionathletics.com/',
      'icon': Icons.sports_soccer,
      'color': Color(0xFF002147),
    },
    {
      'title': 'Campus Rec',
      'url': 'https://www.tamuc.edu/campusrec/',
      'icon': Icons.fitness_center,
      'color': Color(0xFF002147),
    },
    {
      'title': 'Lion Safe App',
      'url': 'https://apps.apple.com/us/app/lion-safe/id1434558723',
      'icon': Icons.shield,
      'color': Color(0xFF002147),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Container(),
        backgroundColor: ETAMUTheme.primary,
        elevation: 0,
        title: const Text(
          'Guest Menu',
          style: TextStyle(
            fontFamily: 'BreeSerif',
            color: ETAMUTheme.secondary,
          ),
        ),
        iconTheme: const IconThemeData(color: ETAMUTheme.secondary),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // ⚙️ Preferences Section
            InkWell(
              onTap: () => setState(() => _showPreferences = !_showPreferences),
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: ETAMUTheme.primary.withOpacity(0.85),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: ETAMUTheme.secondary),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '⚙ Preferences',
                      style: TextStyle(
                        fontFamily: 'BreeSerif',
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    Icon(
                      _showPreferences ? Icons.expand_less : Icons.expand_more,
                      color: ETAMUTheme.secondary,
                    ),
                  ],
                ),
              ),
            ),
            if (_showPreferences) ...[
              const SizedBox(height: 12),
              SwitchListTile(
                value: _darkMode,
                onChanged: (val) => setState(() => _darkMode = val),
                title: const Text(
                  'Dark Mode',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'BreeSerif',
                  ),
                ),
                secondary: const Icon(Icons.dark_mode, color: Colors.white),
              ),
              ListTile(
                leading: const Icon(Icons.feedback, color: Colors.white),
                title: const Text(
                  'Submit Feedback',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'BreeSerif',
                  ),
                ),
                onTap: () {
                  // TODO: Add feedback
                },
              ),
            ],
            const SizedBox(height: 20),

            // 🧩 Grid Shortcuts
            Expanded(
              child: GridView.builder(
                itemCount: _menuItems.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemBuilder: (context, index) {
                  final item = _menuItems[index];
                  return Material(
                    color: Colors.transparent,
                    elevation: 6,
                    borderRadius: BorderRadius.circular(16),
                    child: InkWell(
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
                      borderRadius: BorderRadius.circular(16),
                      splashColor: ETAMUTheme.secondary.withOpacity(0.2),
                      highlightColor: ETAMUTheme.secondary.withOpacity(0.1),
                      child: Container(
                        decoration: BoxDecoration(
                          color: item['color'],
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: ETAMUTheme.secondary),
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(item['icon'], color: Colors.white, size: 32),
                            const SizedBox(height: 10),
                            Text(
                              item['title'],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontFamily: 'BreeSerif',
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
