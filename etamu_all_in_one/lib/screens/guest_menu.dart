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
    },
    {
      'title': 'Academic Calendar',
      'url': 'https://calendar.tamuc.edu/academic',
      'icon': Icons.calendar_month,
    },
    {
      'title': 'Directory',
      'url': 'https://appsprod.tamuc.edu/pb/Default.asp?search=keywordresult',
      'icon': Icons.contact_page,
    },
    {
      'title': 'Campus Map',
      'url': 'https://www.tamuc.edu/map/',
      'icon': Icons.map,
    },
    {
      'title': 'Parking',
      'url': 'https://www.tamuc.edu/parking/',
      'icon': Icons.local_parking,
    },
    {
      'title': 'Athletics',
      'url': 'https://lionathletics.com/',
      'icon': Icons.sports_soccer,
    },
    {
      'title': 'Campus Rec',
      'url': 'https://www.tamuc.edu/campusrec/',
      'icon': Icons.fitness_center,
    },
    {
      'title': 'Lion Safe App',
      'url': 'https://apps.apple.com/us/app/lion-safe/id1434558723',
      'icon': Icons.shield,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ETAMUTheme.primary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(ETAMUTheme.paddingMd),
          child: Column(
            children: [
              InkWell(
                onTap:
                    () => setState(() => _showPreferences = !_showPreferences),
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: ETAMUTheme.primary.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: ETAMUTheme.secondary),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '⚙ Preferences',
                        style: Theme.of(
                          context,
                        ).textTheme.labelLarge?.copyWith(color: Colors.white),
                      ),
                      Icon(
                        _showPreferences
                            ? Icons.expand_less
                            : Icons.expand_more,
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
                  title: Text(
                    'Dark Mode',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: Colors.white),
                  ),
                  secondary: const Icon(Icons.dark_mode, color: Colors.white),
                ),
                ListTile(
                  leading: const Icon(Icons.feedback, color: Colors.white),
                  title: Text(
                    'Submit Feedback',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: Colors.white),
                  ),
                  onTap: () {
                    // TODO: Add feedback navigation
                  },
                ),
              ],
              const SizedBox(height: 12),
              Expanded(
                child: GridView.builder(
                  itemCount: _menuItems.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemBuilder: (context, index) {
                    final item = _menuItems[index];
                    return InkWell(
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
                      borderRadius: BorderRadius.circular(12),
                      splashColor: ETAMUTheme.secondary.withOpacity(0.2),
                      child: Container(
                        decoration: BoxDecoration(
                          color: ETAMUTheme.primary.withOpacity(0.85),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: ETAMUTheme.secondary),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(item['icon'], color: Colors.white, size: 28),
                            const SizedBox(height: 8),
                            Text(
                              item['title'],
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.labelLarge
                                  ?.copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
