import 'package:flutter/material.dart';

class HelpSupportPage extends StatelessWidget {
  const HelpSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primary = Color(0xFF002147);
    const Color secondary = Color(0xFFFFD700);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Help & Support',
          style: TextStyle(fontFamily: 'BreeSerif'),
        ),
        backgroundColor: primary,
      ),
      body: Center(
        child: Text(
          'Help & Support Coming Soon!',
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
