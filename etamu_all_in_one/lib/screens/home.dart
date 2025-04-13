import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:etamu_all_in_one/widgets/bus_route.dart';
import 'package:etamu_all_in_one/widgets/campus_map.dart';
import 'package:etamu_all_in_one/widgets/hub_page.dart';
import 'package:etamu_all_in_one/widgets/calender_page.dart';
import 'package:etamu_all_in_one/widgets/role_picker.dart'; // 👈 New import

class Home extends StatefulWidget {
  final String role; // 'student' or 'faculty'

  const Home({super.key, required this.role});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  int _selectedIndex = 0;

  Future<void> _logout(BuildContext context) async {
    await _auth.signOut();
    if (context.mounted) {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  final List<Widget> _pages = [
    const HubPage(),
    const CalendarPage(),
    const Center(child: Text('Grades Page')),
    const BusRoutePage(),
    const CampusMapPage(),
    const SizedBox(), // Switch Role (placeholder)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF002147),
        title: const Text(
          'ETAMU Hub',
          style: TextStyle(fontFamily: 'BreeSerif', color: Colors.white),
        ),
        actions: [
          IconButton(
            color: Colors.amberAccent,
            icon: const Icon(Icons.logout),
            onPressed: () => _logout(context),
            tooltip: 'Logout',
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 15, 21, 32),
        currentIndex: _selectedIndex,
        onTap: (int index) {
          if (index == 5) {
            showModalBottomSheet(
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              builder: (_) => const RolePicker(),
            );
          } else {
            setState(() {
              _selectedIndex = index;
            });
          }
        },
        selectedItemColor: Colors.blue[800],
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.grade), label: 'Grades'),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_transportation),
            label: 'Bus Route',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Campus Map'),
          BottomNavigationBarItem(
            icon: Icon(Icons.switch_account),
            label: 'Switch Role',
          ),
        ],
      ),
    );
  }
}
