import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

    Timer(const Duration(seconds: 2), () {
      final user = _auth.currentUser;

      if (user != null) {
        // Check user's last signed-in role if you store it — fallback to student
        Navigator.pushReplacementNamed(context, '/student_home');
      } else {
        Navigator.pushReplacementNamed(context, '/guest');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const navyBlue = Color(0xFF002147);
    const gold = Color(0xFFFFD700);

    return Scaffold(
      backgroundColor: navyBlue,
      body: Center(
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
