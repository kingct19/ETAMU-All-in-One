import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../widgets/dashboard_page.dart';
import '../widgets/calender_page.dart';
import '../widgets/messages_tab.dart';
import '../widgets/bus_route.dart';
import '../widgets/campus_map.dart';
import '../widgets/role_picker.dart';

class Home extends StatefulWidget {
  final String role; // 'student' or 'faculty'
  const Home({super.key, required this.role});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  int _selectedIndex = 0;

  final List<Widget> _tabs = const [
    DashboardPage(),     // Replaces Home
    CalendarPage(),
    MessagesTab(),
    BusRoutePage(),
    CampusMapPage(),
    SizedBox(), // Placeholder for switch role
  ];

  void _logout() async {
    await _auth.signOut();
    if (mounted) {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  void _showRolePicker() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => const RolePicker(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF002147),
        title: const Text(
          'ETAMU Dashboard',
          style: TextStyle(fontFamily: 'BreeSerif', color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.amber),
            onPressed: _logout,
            tooltip: 'Logout',
          ),
        ],
      ),
      body: _selectedIndex == 5
          ? _showRolePicker() // show modal if on "Switch Role"
          : _tabs[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          if (index == 5) {
            _showRolePicker();
          } else {
            setState(() => _selectedIndex = index);
          }
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFFFFD700),
        unselectedItemColor: Colors.white,
        backgroundColor: const Color(0xFF002147),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Calendar'),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Messages'),
          BottomNavigationBarItem(icon: Icon(Icons.directions_bus), label: 'Bus'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Map'),
          BottomNavigationBarItem(icon: Icon(Icons.swap_horiz), label: 'Switch Role'),
        ],
      ),
    );
  }
}
