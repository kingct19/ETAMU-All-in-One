import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/guest_webview.dart';

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
        child: SingleChildScrollView(
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

              // Search bar
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

              // Tool grid cards
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
    );
  }
}
