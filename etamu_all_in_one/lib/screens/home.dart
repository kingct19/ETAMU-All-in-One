import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../widgets/dashboard_page.dart';
import '../widgets/bus_route.dart';
import '../screens/messages_tab.dart';
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

  final List<Widget> _pages = [
    const DashboardPage(),
    const BusRoutePage(),
    const MessagesTab(),
    const CampusMapPage(),
    const RoleSwitchTab(),
  ];

  Future<void> _logout(BuildContext context) async {
    await _auth.signOut();
    if (context.mounted) {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color navyBlue = Color(0xFF002147);
    const Color gold = Color(0xFFFFD700);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: navyBlue,
        title: const Text(
          'ETAMU Portal',
          style: TextStyle(
            fontFamily: 'BreeSerif',
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            color: gold,
            tooltip: 'Logout',
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: gold,
        unselectedItemColor: Colors.white,
        backgroundColor: navyBlue,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.directions_bus), label: 'Bus'),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Messages'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Map'),
          BottomNavigationBarItem(icon: Icon(Icons.switch_account), label: 'Switch Role'),
        ],
      ),
    );
  }
}

class RoleSwitchTab extends StatelessWidget {
  const RoleSwitchTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: ElevatedButton.icon(
          icon: const Icon(Icons.switch_account),
          label: const Text('Switch Role', style: TextStyle(fontFamily: 'BreeSerif')),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              builder: (_) => const RolePicker(),
            );
          },
        ),
      ),
    );
  }
}
