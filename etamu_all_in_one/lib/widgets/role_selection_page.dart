import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/login.dart';

class RoleSelectionPage extends StatelessWidget {
  final String currentRole;

  const RoleSelectionPage({super.key, required this.currentRole});

  List<Map<String, String>> _getAvailableRoles(String role) {
    if (role == 'guest') {
      return [
        {'label': 'Student', 'value': 'student'},
        {'label': 'Faculty', 'value': 'faculty'},
      ];
    } else if (role == 'student') {
      return [
        {'label': 'Faculty', 'value': 'faculty'},
        {'label': 'Guest', 'value': 'guest'},
      ];
    } else {
      return [
        {'label': 'Student', 'value': 'student'},
        {'label': 'Guest', 'value': 'guest'},
      ];
    }
  }

  Future<void> _handleRoleTap(BuildContext context, String selectedRole) async {
    if (selectedRole == 'guest') {
      Navigator.pushReplacementNamed(context, '/guest');
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    final lastRole = prefs.getString('lastRole');
    final user = FirebaseAuth.instance.currentUser;

    if (user != null && lastRole == selectedRole) {
      Navigator.pushReplacementNamed(context, '/${selectedRole}_home');
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => LoginScreen(role: selectedRole)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableRoles = _getAvailableRoles(currentRole);

    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        backgroundColor: const Color(0xFF002147),
        title: const Text(
          'Select Role',
          style: TextStyle(fontFamily: 'BreeSerif', color: Color(0xFFFFD700)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:
              availableRoles.map((role) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF002147),
                      foregroundColor: const Color(0xFFFFD700),
                      minimumSize: const Size.fromHeight(56),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () => _handleRoleTap(context, role['value']!),
                    child: Text(
                      role['label']!,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'BreeSerif',
                      ),
                    ),
                  ),
                );
              }).toList(),
        ),
      ),
    );
  }
}
