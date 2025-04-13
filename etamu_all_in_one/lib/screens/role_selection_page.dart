import 'package:flutter/material.dart';
import 'login.dart';

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

  @override
  Widget build(BuildContext context) {
    final availableRoles = _getAvailableRoles(currentRole);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF002147),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFFFD700)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Select Role',
          style: TextStyle(
            fontFamily: 'BreeSerif',
            color: Color(0xFFFFD700),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: availableRoles.map((role) {
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
                onPressed: () {
                  if (role['value'] == 'guest') {
                    Navigator.pushReplacementNamed(context, '/guest');
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => LoginScreen(role: role['value']!),
                      ),
                    );
                  }
                },
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
