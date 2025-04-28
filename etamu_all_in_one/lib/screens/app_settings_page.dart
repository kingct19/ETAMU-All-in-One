import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class AppSettingsPage extends StatefulWidget {
  const AppSettingsPage({super.key});

  @override
  State<AppSettingsPage> createState() => _AppSettingsPageState();
}

class _AppSettingsPageState extends State<AppSettingsPage> {
  bool _notificationsEnabled = true;
  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _notificationsEnabled = prefs.getBool('notificationsEnabled') ?? true;
      _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    });
  }

  Future<void> _updateNotifications(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() => _notificationsEnabled = value);
    await prefs.setBool('notificationsEnabled', value);
  }

  Future<void> _updateDarkMode(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() => _isDarkMode = value);
    await prefs.setBool('isDarkMode', value);
  }

  @override
  Widget build(BuildContext context) {
    const Color primary = Color(0xFF002147);
    const Color secondary = Color(0xFFFFD700);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'App Settings',
          style: TextStyle(
            fontFamily: 'BreeSerif',
            color: Color.fromARGB(221, 255, 255, 255),
          ),
        ),
        backgroundColor: primary,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ListTile(
            leading: const Icon(Icons.notifications, color: secondary),
            title: const Text(
              'Notifications',
              style: TextStyle(fontFamily: 'BreeSerif'),
            ),
            trailing: Switch(
              value: _notificationsEnabled,
              onChanged: _updateNotifications,
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.dark_mode, color: secondary),
            title: const Text(
              'Dark Mode',
              style: TextStyle(fontFamily: 'BreeSerif'),
            ),
            trailing: Switch(value: _isDarkMode, onChanged: _updateDarkMode),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.lock, color: secondary),
            title: const Text(
              'Privacy Settings',
              style: TextStyle(fontFamily: 'BreeSerif'),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PrivacySettingsPage()),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.language, color: secondary),
            title: const Text(
              'Language',
              style: TextStyle(fontFamily: 'BreeSerif'),
            ),
            onTap: () {
              showDialog(
                context: context,
                builder:
                    (context) => AlertDialog(
                      title: const Text('Select Language'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            title: const Text('English'),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            title: const Text('Spanish'),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    ),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.info, color: secondary),
            title: const Text(
              'About App',
              style: TextStyle(fontFamily: 'BreeSerif'),
            ),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: 'ETAMU All-in-One',
                applicationVersion: '1.0.0',
                applicationLegalese: '© 2025 East Texas A&M University',
              );
            },
          ),
        ],
      ),
    );
  }
}

// Simple placeholder for PrivacySettingsPage
class PrivacySettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Privacy Settings')),
      body: const Center(child: Text('Privacy Settings Page')),
    );
  }
}
