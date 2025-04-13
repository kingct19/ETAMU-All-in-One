import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:etamu_all_in_one/widgets/hub_page.dart';
import 'package:etamu_all_in_one/widgets/calender_page.dart';
import 'package:etamu_all_in_one/widgets/bus_route.dart';
import 'package:etamu_all_in_one/widgets/campus_map.dart';
import 'package:etamu_all_in_one/widgets/messages_tab.dart';
import 'package:etamu_all_in_one/screens/role_selection_page.dart';

class Home extends StatefulWidget {
  final String role; // 'student' or 'faculty'

  const Home({super.key, required this.role});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  int _selectedIndex = 0;

  final List<Widget> _tabs = [
    const HubPage(),
    const CalendarPage(),
    const MessagesTab(),
    const BusRoutePage(),
    const CampusMapPage(),
    const SizedBox.shrink(), // Placeholder for role switch
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF002147),
        title: const Text('ETAMU Dashboard', style: TextStyle(fontFamily: 'BreeSerif', color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.amber),
            tooltip: 'Logout',
            onPressed: () async {
              await _auth.signOut();
              if (context.mounted) Navigator.pushReplacementNamed(context, '/login');
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
        selectedItemColor: const Color(0xFFFFD700),
        unselectedItemColor: Colors.white,
        backgroundColor: const Color(0xFF002147),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Calendar'),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Messages'),
          BottomNavigationBarItem(icon: Icon(Icons.directions_bus), label: 'Bus'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Map'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Role'),
        ],
      ),
    );
  }
}
