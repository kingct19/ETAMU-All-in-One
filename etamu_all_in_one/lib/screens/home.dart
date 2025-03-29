import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  @override
  Widget build(BuildContext context) {
    final user = _auth.currentUser;
    final email = user?.email ?? "User";

    final String welcomeMessage =
        widget.role == 'faculty'
            ? 'Welcome, Professor $email!'
            : 'Welcome, $email!';

    final List<Widget> _pages = [
      Center(
        child: Text(
          welcomeMessage,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'BreeSerif',
          ),
          textAlign: TextAlign.center,
        ),
      ),
      const Center(child: Text('Calendar Page')),
      const Center(child: Text('Grades Page')),
      const Center(child: Text('Settings Page')),
      const Center(child: Text('Bus Route')),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF002147), // Navy blue
        title: const Text(
          'ETAMU Dashboard',
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
        backgroundColor: Colors.blueAccent,
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
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
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_transportation),
            label: 'Bus Route',
          ),
        ],
      ),
    );
  }
}
