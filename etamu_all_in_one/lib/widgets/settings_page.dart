import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  File? _profileImage;
  String _userName = '';
  final TextEditingController _nameController = TextEditingController();
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final uid = FirebaseAuth.instance.currentUser?.uid;
    final storedName = prefs.getString('userName_$uid') ?? 'Lion';
    setState(() {
      _userName = storedName;
      _nameController.text = _userName;
    });
    final imagePath = prefs.getString('userImage_$uid');
    if (imagePath != null && File(imagePath).existsSync()) {
      setState(() {
        _profileImage = File(imagePath);
      });
    }
    final user = FirebaseAuth.instance.currentUser;
    if (user != null &&
        (user.displayName == null || user.displayName!.isEmpty)) {
      await user.updateDisplayName(_userName);
    }
  }

  Future<void> _saveName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      await prefs.setString('userName_$uid', name);
    }
    setState(() {
      _userName = name;
    });
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.updateDisplayName(name);
    }
  }

  String _getUserName() {
    final user = FirebaseAuth.instance.currentUser;
    return user?.displayName ?? _userName;
  }

  Future<void> _pickImage() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => _profileImage = File(picked.path));
      final prefs = await SharedPreferences.getInstance();
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid != null) {
        await prefs.setString('userImage_$uid', picked.path);
      }
    }
  }

  Future<void> _logout(BuildContext context) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text('Logout'),
            content: const Text('Are you sure you want to log out?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Logout'),
              ),
            ],
          ),
    );

    if (confirm == true) {
      await SharedPreferences.getInstance().then(
        (prefs) => prefs.remove('lastRole'),
      );
      await FirebaseAuth.instance.signOut();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('You have been logged out.')),
        );
        Navigator.pushNamedAndRemoveUntil(context, '/guest', (route) => false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color primary = Color(0xFF002147);
    const Color secondary = Color(0xFFFFD700);

    final TextStyle optionTextStyle = const TextStyle(
      fontFamily: 'BreeSerif',
      fontSize: 18,
      color: Colors.black87,
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 80),
          child: Column(
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 54,
                  backgroundImage:
                      _profileImage != null
                          ? FileImage(_profileImage!)
                          : const AssetImage('assets/images/etamu_logo.jpg')
                              as ImageProvider,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.edit, size: 18, color: primary),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: TextField(
                  controller: _nameController,
                  textAlign: TextAlign.center,
                  onSubmitted: _saveName,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'BreeSerif',
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Your Name',
                    hintStyle: TextStyle(color: Colors.black54),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 8),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Card(
                      color: primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 8,
                        ),
                        leading: Icon(
                          Icons.person,
                          size: 28,
                          color: Colors.white,
                        ),
                        title: Text(
                          'Edit Profile',
                          style: optionTextStyle.copyWith(color: Colors.white),
                        ),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              final controller = TextEditingController(
                                text: _userName,
                              );
                              return AlertDialog(
                                title: const Text('Edit Profile Name'),
                                content: TextField(
                                  controller: controller,
                                  decoration: const InputDecoration(
                                    labelText: 'Enter your name',
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('Cancel'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      _saveName(controller.text);
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Save'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
                    Card(
                      color: primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 8,
                        ),
                        leading: Icon(
                          Icons.settings,
                          size: 28,
                          color: Colors.white,
                        ),
                        title: Text(
                          'App Settings',
                          style: optionTextStyle.copyWith(color: Colors.white),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, '/app_settings');
                        },
                      ),
                    ),
                    Card(
                      color: primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 8,
                        ),
                        leading: Icon(
                          Icons.help_outline,
                          size: 28,
                          color: Colors.white,
                        ),
                        title: Text(
                          'Help & Support',
                          style: optionTextStyle.copyWith(color: Colors.white),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, '/help_support');
                        },
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Divider(thickness: 1),
                    const SizedBox(height: 12),
                    Card(
                      color: primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 8,
                        ),
                        leading: Icon(
                          Icons.info_outline,
                          size: 28,
                          color: secondary,
                        ),
                        title: Text(
                          'About ETAMU',
                          style: optionTextStyle.copyWith(color: Colors.white),
                        ),
                        onTap: () {
                          showAboutDialog(
                            context: context,
                            applicationName: 'ETAMU All-in-One',
                            applicationVersion: '1.0.0',
                            applicationLegalese:
                                '© 2025 East Texas A&M University',
                          );
                        },
                      ),
                    ),
                    Card(
                      color: primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 8,
                        ),
                        leading: const Icon(
                          Icons.logout,
                          size: 28,
                          color: Colors.red,
                        ),
                        title: Text(
                          'Logout',
                          style: optionTextStyle.copyWith(color: Colors.white),
                        ),
                        onTap: () => _logout(context),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
