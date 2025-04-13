import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'role_picker.dart'; // ✅ Ensure correct import

class SettingsPage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isLoggedIn = _auth.currentUser != null;

    return Scaffold(
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Switch Role'),
            subtitle: const Text('Student / Faculty'),
            onTap: () => showModalBottomSheet(
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              builder: (_) => const RolePicker(),
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.dark_mode),
            title: const Text('Dark Mode'),
            subtitle: const Text('Coming soon!'),
            trailing: Switch(value: false, onChanged: (val) {
              // TODO: Implement dark mode
            }),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.feedback),
            title: const Text('Submit Feedback'),
            onTap: () {
              // TODO: Implement feedback route
            },
          ),
          if (isLoggedIn) const Divider(),
          if (isLoggedIn)
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () async {
                await _auth.signOut();
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
        ],
      ),
    );
  }
}
