import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 2), () async {
      final user = _auth.currentUser;

      if (user != null) {
        // ✅ Load last known role
        final prefs = await SharedPreferences.getInstance();
        final role = prefs.getString('lastRole') ?? 'student';

        final route = role == 'faculty' ? '/faculty_home' : '/student_home';
        if (mounted) {
          Navigator.pushReplacementNamed(context, route);
        }
      } else {
        if (mounted) {
          Navigator.pushReplacementNamed(context, '/guest');
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const navyBlue = Color(0xFF002147);
    const gold = Color(0xFFFFD700);

    return Scaffold(
      backgroundColor: navyBlue,
      body: const Center(
        child: Text(
          'ETAMU',
          style: TextStyle(
            fontSize: 48,
            fontFamily: 'BreeSerif',
            fontWeight: FontWeight.bold,
            color: gold,
            letterSpacing: 6,
          ),
        ),
      ),
    );
  }
}
