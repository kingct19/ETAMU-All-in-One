import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('lastRole');
    await FirebaseAuth.instance.signOut();
    if (context.mounted) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/guest_home', // ✅ Make sure this route exists in your app
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color primary = Color(0xFF002147);
    const Color secondary = Color(0xFFFFD700);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings'), backgroundColor: primary),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          const SizedBox(height: 24),
          const ListTile(
            leading: Icon(Icons.account_circle, color: primary),
            title: Text(
              'Logged in as',
              style: TextStyle(fontFamily: 'BreeSerif'),
            ),
            subtitle: Text('Student or Faculty'),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.info_outline, color: primary),
            title: const Text('About ETAMU'),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: 'ETAMU All-in-One',
                applicationVersion: '1.0.0',
                applicationLegalese: '© 2025 East Texas A&M University',
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.feedback, color: primary),
            title: const Text('Submit Feedback'),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Feedback page coming soon!')),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Logout'),
            onTap: () => _logout(context),
          ),
        ],
      ),
    );
  }
}
