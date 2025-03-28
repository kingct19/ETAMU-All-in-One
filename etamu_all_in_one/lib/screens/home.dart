import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final String role; // Either 'student' or 'faculty'

  Home({super.key, required this.role});

  Future<void> _logout(BuildContext context) async {
    await _auth.signOut();
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    final user = _auth.currentUser;
    final email = user?.email ?? "User";

    String welcomeMessage = role == 'faculty'
        ? 'Welcome, Professor $email!'
        : 'Welcome, $email!';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF002147),
        title: const Text(
          'ETAMU Dashboard',
          style: TextStyle(
            fontFamily: 'BreeSerif',
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _logout(context),
            tooltip: 'Logout',
          ),
        ],
      ),
      body: Center(
        child: Text(
          welcomeMessage,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'BreeSerif',
          ),
        ),
      ),
    );
  }
}
