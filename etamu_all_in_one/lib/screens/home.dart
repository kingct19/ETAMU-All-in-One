import 'dart:async';
import 'package:etamu_all_in_one/widgets/role_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:etamu_all_in_one/widgets/calender_page.dart';
import 'package:etamu_all_in_one/widgets/campus_map.dart';
import 'package:etamu_all_in_one/widgets/messages_tab.dart';
import 'package:etamu_all_in_one/widgets/role_selection_page.dart';
import 'package:etamu_all_in_one/screens/student_dashboard_page.dart';
import 'package:etamu_all_in_one/screens/faculty_dashboard_page.dart';

class Home extends StatefulWidget {
  final String role; // 'student' or 'faculty'

  const Home({super.key, required this.role});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with WidgetsBindingObserver {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  int _selectedIndex = 0;
  Timer? _idleTimer;

  late final List<Widget> _tabs = [
    widget.role == 'faculty'
        ? const FacultyDashboardPage()
        : const StudentDashboardPage(),
    const CalendarPage(),
    const MessagesTab(),
    const CampusMapPage(),
    const RoleSelectionPage(currentRole: 'student'), // switch role placeholder
  ];

  void _showRoleSelector() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => RoleSelectionPage(currentRole: widget.role),
      ),
    );
  }

  // ✅ Auto logout after 5 minutes idle
  void _resetIdleTimer() {
    _idleTimer?.cancel();
    _idleTimer = Timer(const Duration(minutes: 5), _handleInactivityLogout);
  }

  void _handleInactivityLogout() async {
    await _auth.signOut();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('lastRole');

    if (mounted) {
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _resetIdleTimer();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _idleTimer?.cancel();
    super.dispose();
  }

  // ✅ Logout on app quit
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.detached ||
        state == AppLifecycleState.inactive) {
      _handleInactivityLogout(); // force logout when quitting
    } else if (state == AppLifecycleState.resumed) {
      _resetIdleTimer(); // resume timer when user returns
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color navy = Color(0xFF002147);
    const Color gold = Color(0xFFFFD700);

    return GestureDetector(
      onTap: _resetIdleTimer,
      onPanDown: (_) => _resetIdleTimer(),
      child: Scaffold(
        body: _tabs[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            _resetIdleTimer();
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
            const BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              label: 'Calendar',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.message),
              label: 'Messages',
            ),
            const BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Map'),
            const BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Role',
            ),
          ],
        ),
      ),
    );
  }
}
