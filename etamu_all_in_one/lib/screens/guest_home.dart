import 'package:flutter/material.dart';
import 'guest_home_tab.dart';
import 'guest_menu.dart';
import '../widgets/bus_route.dart';
import '../widgets/campus_map.dart';
import '../widgets/messages_tab.dart';
import 'role_selection_page.dart';

class GuestHomePage extends StatefulWidget {
  const GuestHomePage({super.key});

  @override
  State<GuestHomePage> createState() => _GuestHomePageState();
}

class _GuestHomePageState extends State<GuestHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _tabs = [
    const GuestHomeTab(),
    const GuestMenuTab(),
    const BusRoutePage(),
    const MessagesTab(),
    const CampusMapPage(),
    const RoleSelectionPage(currentRole: 'guest'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFFFFD700),
        unselectedItemColor: Colors.white,
        backgroundColor: const Color(0xFF002147),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Menu'),
          BottomNavigationBarItem(icon: Icon(Icons.directions_bus), label: 'Bus'),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Messages'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Map'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Role'),
        ],
      ),
    );
  }
}
