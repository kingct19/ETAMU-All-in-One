import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse('https://www.tamuc.edu'));
  }

  void _toggleScroll() {
    if (_scrolledToShortcuts) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    } else {
      Scrollable.ensureVisible(
        _shortcutsKey.currentContext!,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
    setState(() => _scrolledToShortcuts = !_scrolledToShortcuts);
  }

  @override
  Widget build(BuildContext context) {
    const Color navyBlue = Color(0xFF002147);
    const Color gold = Color(0xFFFFD700);
    const Color lightBackground = Color(0xFFF9F9F9);

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
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: Offset(0, -4),
                      )
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
                          color: navyBlue,
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
              label: Text(_scrolledToShortcuts ? 'Back to Website' : 'Quick Links'),
              icon: Icon(_scrolledToShortcuts ? Icons.arrow_upward : Icons.arrow_downward),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShortcutCard(Map<String, dynamic> item) {
    return InkWell(
      onTap: () async {
        final uri = Uri.parse(item['url']);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        }
      },
      borderRadius: BorderRadius.circular(12),
      splashColor: Colors.amber.withOpacity(0.2),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F6FA),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFF002147), width: 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(item['icon'], size: 36, color: const Color(0xFF002147)),
            const SizedBox(height: 10),
            Text(
              item['title'],
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontFamily: 'BreeSerif',
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
      'url': 'https://www.tamuc.edu/apply-now/',
      'icon': Icons.school,
    },
    {
      'title': 'Campus Life Virtual Tour',
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
      'title': 'Academic Calendar',
      'url': 'https://www.tamuc.edu/registrar/academic-calendar/',
      'icon': Icons.calendar_today,
    },
    {
      'title': 'Contact Directory',
      'url': 'https://www.tamuc.edu/contact-us/',
      'icon': Icons.contact_page,
    },
    {
      'title': 'Lion Safe App',
      'url': 'https://apps.apple.com/us/app/lion-safe/id1434558723',
      'icon': Icons.shield,
    },
  ];
}
