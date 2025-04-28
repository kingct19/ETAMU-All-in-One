import 'package:flutter/material.dart';

class AppSettingsPage extends StatelessWidget {
  const AppSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primary = Color(0xFF002147);
    const Color secondary = Color(0xFFFFD700);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'App Settings',
          style: TextStyle(fontFamily: 'BreeSerif'),
        ),
        backgroundColor: primary,
      ),
      body: Center(
        child: Text(
          'App Settings Coming Soon!',
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'BreeSerif',
            color: primary,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
