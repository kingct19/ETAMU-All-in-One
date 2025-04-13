import 'package:flutter/material.dart';
import '../screens/login.dart';

class RolePicker extends StatelessWidget {
  final String currentRole; // 'guest', 'student', or 'faculty'

  const RolePicker({super.key, required this.currentRole});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> roles = _getRolesFor(currentRole);

    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: roles.map((role) {
          return ListTile(
            leading: Icon(role['icon']),
            title: Text('Login as ${role['label']}'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => LoginScreen(role: role['key']),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }

  List<Map<String, dynamic>> _getRolesFor(String role) {
    switch (role) {
      case 'student':
        return [
          {'label': 'Faculty', 'key': 'faculty', 'icon': Icons.person},
          {'label': 'Guest', 'key': 'guest', 'icon': Icons.group},
        ];
      case 'faculty':
        return [
          {'label': 'Student', 'key': 'student', 'icon': Icons.school},
          {'label': 'Guest', 'key': 'guest', 'icon': Icons.group},
        ];
      case 'guest':
      default:
        return [
          {'label': 'Student', 'key': 'student', 'icon': Icons.school},
          {'label': 'Faculty', 'key': 'faculty', 'icon': Icons.person},
        ];
    }
  }
}
