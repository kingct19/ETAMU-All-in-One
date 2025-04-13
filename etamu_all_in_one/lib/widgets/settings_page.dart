import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'role_picker.dart'; // ✅ Ensure correct import

class RoleSelectionPage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final String currentRole;

  RoleSelectionPage({super.key, this.currentRole = 'guest'});

  @override
  Widget build(BuildContext context) {
    final bool isLoggedIn = _auth.currentUser != null;

    return Scaffold(
      appBar: AppBar(
        leading: Navigator.canPop(context)
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              )
            : null,
        backgroundColor: const Color(0xFF002147),
        title: const Text(
          'Switch Role',
          style: TextStyle(
            fontFamily: 'BreeSerif',
            color: Colors.white,
          ),
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.school),
            title: const Text('Student Portal'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const LoginScreen(role: 'student'),
                ),
              );
            },
            enabled: currentRole != 'student',
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Faculty Portal'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const LoginScreen(role: 'faculty'),
                ),
              );
            },
            enabled: currentRole != 'faculty',
          ),
          if (currentRole != 'guest')
            ListTile(
              leading: const Icon(Icons.visibility),
              title: const Text('Continue as Guest'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/guest');
              },
            ),
        ],
      ),
    );
  }
}
