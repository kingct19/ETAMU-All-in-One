import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // ⏳ Navigate after 3 seconds
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/guest');
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
