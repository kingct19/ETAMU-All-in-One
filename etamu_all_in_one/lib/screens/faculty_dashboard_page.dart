import 'package:flutter/material.dart';
import 'guest_webview.dart';

class FacultyDashboardPage extends StatelessWidget {
  const FacultyDashboardPage({super.key});

  final List<Map<String, dynamic>> _facultyTools = const [
    {
      'title': 'myLEO',
      'url':
          'https://leoportal.tamuc.edu/uPortal/f/welcome/normal/render.uP',
      'icon': Icons.school,
    },
    {
      'title': 'My Classes (D2L)',
      'url': 'https://myleoonline.tamuc.edu/d2l/login',
      'icon': Icons.laptop_chromebook,
    },
    {
      'title': 'Library Resources',
      'url': 'https://idp.tamuc.edu/idp/profile/cas/login?execution=e8s1',
      'icon': Icons.menu_book,
    },
    {
      'title': 'Graduate DegreeWorks',
      'url':
          'https://leoportal.tamuc.edu/uPortal/f/welcome/normal/render.uP',
      'icon': Icons.account_balance,
    },
    {
      'title': 'Undergraduate DegreeWorks',
      'url':
          'https://leoportal.tamuc.edu/uPortal/f/welcome/normal/render.uP',
      'icon': Icons.school_outlined,
    },
    {
      'title': 'Email (Outlook)',
      'url':
          'https://outlook.tamuc.edu/owa/auth/logon.aspx?replaceCurrent=1&url=https%3a%2f%2foutlook.tamuc.edu%2fowa%2f',
      'icon': Icons.email,
    },
  ];

  @override
  Widget build(BuildContext context) {
    const Color bgColor = Color(0xFF002147);
    const Color gold = Color(0xFFFFD700);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text(
          'Faculty Portal',
          style: TextStyle(fontFamily: 'BreeSerif', color: gold),
        ),
        backgroundColor: bgColor,
        iconTheme: const IconThemeData(color: gold),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: _facultyTools.map((item) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => GuestWebViewPage(
                      title: item['title'],
                      url: item['url'],
                    ),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF08335B),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: gold),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(item['icon'], size: 36, color: Colors.white),
                    const SizedBox(height: 12),
                    Text(
                      item['title'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: 'BreeSerif',
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
