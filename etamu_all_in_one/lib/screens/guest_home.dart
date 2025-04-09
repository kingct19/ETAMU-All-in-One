import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'guest_webview.dart';

class GuestHomePage extends StatefulWidget {
  const GuestHomePage({super.key});

  @override
  State<GuestHomePage> createState() => _GuestHomePageState();
}

class _GuestHomePageState extends State<GuestHomePage> {
  late final WebViewController _controller;
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _shortcutsKey = GlobalKey();
  bool _scrolledToShortcuts = false;

  @override
  void initState() {
    super.initState();
    _controller =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..loadRequest(Uri.parse('https://www.tamuc.edu'));
  }

  void _toggleScroll() {
    final double scrollTarget =
        _scrolledToShortcuts ? 0 : MediaQuery.of(context).size.height;
    _scrollController.animateTo(
      scrollTarget,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
    setState(() => _scrolledToShortcuts = !_scrolledToShortcuts);
  }

  @override
  Widget build(BuildContext context) {
    const navyBlue = Color(0xFF002147);
    const gold = Color(0xFFFFD700);

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: WebViewWidget(controller: _controller),
                ),
                Container(
                  key: _shortcutsKey,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 24,
                  ),
                  decoration: const BoxDecoration(
                    color: navyBlue,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8,
                        offset: Offset(0, -4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '🚀 Quick Links',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'BreeSerif',
                          color: gold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      GridView.count(
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        children: _shortcuts.map(_buildShortcutCard).toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 24,
            right: 24,
            child: FloatingActionButton.extended(
              onPressed: _toggleScroll,
              backgroundColor: navyBlue,
              foregroundColor: Colors.white,
              label: Text(
                _scrolledToShortcuts ? 'Back to Website' : 'Quick Links',
              ),
              icon: Icon(
                _scrolledToShortcuts
                    ? Icons.arrow_upward
                    : Icons.arrow_downward,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShortcutCard(Map<String, dynamic> item) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (_) => GuestWebViewPage(title: item['title'], url: item['url']),
          ),
        );
      },
      borderRadius: BorderRadius.circular(12),
      splashColor: Colors.amber.withOpacity(0.2),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFF08335B),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFFFD700), width: 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(item['icon'], size: 36, color: Colors.white),
            const SizedBox(height: 10),
            Text(
              item['title'],
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontFamily: 'BreeSerif',
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  final List<Map<String, dynamic>> _shortcuts = [
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
      'title': 'Contact Directory',
      'url':
          'https://appsprod.tamuc.edu//pb/Default.asp?search=keywordresult&_gl=1*gec4kc',
      'icon': Icons.contact_page,
    },
    {
      'title': 'Campus Life Tour',
      'url': 'https://www.tamuc.edu/map/',
      'icon': Icons.map,
    },
    {
      'title': 'Parking',
      'url': 'https://www.tamuc.edu/parking/',
      'icon': Icons.local_parking,
    },
    {
      'title': 'Lion Athletics',
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
}
