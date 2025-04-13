import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:etamu_all_in_one/widgets/calender_page.dart';
import 'package:etamu_all_in_one/widgets/bus_route.dart';
import 'package:etamu_all_in_one/widgets/campus_map.dart';
import 'package:etamu_all_in_one/widgets/messages_tab.dart';
import 'package:etamu_all_in_one/screens/role_selection_page.dart';
import 'package:etamu_all_in_one/screens/student_dashboard_page.dart';
import 'package:etamu_all_in_one/screens/faculty_dashboard_page.dart';

class Home extends StatefulWidget {
  final String role; // 'student' or 'faculty'

  const Home({super.key, required this.role});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  int _selectedIndex = 0;

  late final List<Widget> _tabs = [
    widget.role == 'faculty'
        ? const FacultyDashboardPage()
        : const StudentDashboardPage(),
    const CalendarPage(),
    const MessagesTab(),
    const BusRoutePage(),
    const CampusMapPage(),
    const SizedBox.shrink(), // switch role placeholder
  ];

  void _showRoleSelector() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => RoleSelectionPage(currentRole: widget.role),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color navy = Color(0xFF002147);
    const Color gold = Color(0xFFFFD700);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: navy,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.amber),
            tooltip: 'Logout',
            onPressed: () async {
              await _auth.signOut();
              if (context.mounted) {
                Navigator.pushReplacementNamed(context, '/login');
              }
            },
          )
        ],
      ),
      body: _tabs[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          if (index == 5) {
            _showRoleSelector();
          } else {
            setState(() => _selectedIndex = index);
          }
        },
        selectedItemColor: gold,
        unselectedItemColor: Colors.white,
        backgroundColor: navy,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.dashboard),
            label: widget.role == 'faculty' ? 'Faculty' : 'Student',
          ),
          const BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Calendar'),
          const BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Messages'),
          const BottomNavigationBarItem(icon: Icon(Icons.directions_bus), label: 'Bus'),
          const BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Map'),
          const BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Role'),
        ],
      ),
    );
  }
}
