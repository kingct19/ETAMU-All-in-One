import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_fadeController);
    _fadeController.forward();

    Timer(const Duration(seconds: 3), () async {
      final user = _auth.currentUser;
      final prefs = await SharedPreferences.getInstance();
      final role = prefs.getString('lastRole');

      if (user != null && role != null) {
        final route = role == 'faculty' ? '/faculty_home' : '/student_home';
        if (mounted) Navigator.pushReplacementNamed(context, route);
      } else {
        if (mounted) Navigator.pushReplacementNamed(context, '/guest');
      }
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const navy = Color(0xFF002147);
    const gold = Color(0xFFFFD700);

    return Scaffold(
      backgroundColor: navy,
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/images/etamu_logo.jpg',
                width: 180,
                height: 180,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 20),
              const Text(
                'Home of LIONS',
                style: TextStyle(
                  fontSize: 22,
                  fontStyle: FontStyle.italic,
                  color: gold,
                  fontFamily: 'BreeSerif',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
