// lib/widgets/messages_tab.dart
import 'package:flutter/material.dart';

class MessagesTab extends StatelessWidget {
  const MessagesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF002147),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.message, size: 60, color: Colors.amber),
              SizedBox(height: 20),
              Text(
                'Messages and announcements will appear here soon.',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'BreeSerif',
                  color: Colors.white70,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
