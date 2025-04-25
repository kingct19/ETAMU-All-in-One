import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  Future<void> _logoutConfirmed(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('lastRole');
    await FirebaseAuth.instance.signOut();

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('You have been logged out.'),
          duration: Duration(seconds: 2),
        ),
      );

      Navigator.pushNamedAndRemoveUntil(
        context,
        '/guest', // Make sure this route is defined
        (route) => false,
      );
    }
  }

  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: const Text('Confirm Logout'),
            content: const Text('Are you sure you want to logout?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(ctx); // Close dialog first
                  _logoutConfirmed(context);
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text('Logout'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color primary = Color(0xFF002147);

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
            onTap: () => _showLogoutConfirmation(context),
          ),
        ],
      ),
    );
  }
}
// This code defines a SettingsPage widget in Flutter. It includes a logout confirmation dialog and handles user logout using Firebase Authentication. The page also displays user information and provides options for feedback and about the app.