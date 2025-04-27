import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  File? _profileImage;
  String _userName = '';
  String? _profileImageUrl;
  final TextEditingController _nameController = TextEditingController();
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    final prefs = await SharedPreferences.getInstance();

    if (uid != null) {
      try {
        final doc =
            await FirebaseFirestore.instance.collection('users').doc(uid).get();
        if (doc.exists) {
          setState(() {
            _userName = doc['name'] ?? 'Lion';
            final imageUrl = doc['profileImageUrl'];
            if (imageUrl != null && imageUrl.isNotEmpty) {
              _profileImageUrl = imageUrl;
            } else {
              _profileImageUrl = null;
            }
            _nameController.text = _userName;
          });
        } else {
          // Fallback to local
          setState(() {
            _userName = prefs.getString('userName_$uid') ?? 'Lion';
            _profileImageUrl = null;
            _nameController.text = _userName;
          });
        }
      } catch (e) {
        // Error fallback
        setState(() {
          _userName = prefs.getString('userName_$uid') ?? 'Lion';
          _profileImageUrl = null;
          _nameController.text = _userName;
        });
      }
    }
  }

  Future<void> _saveName(String name) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    final prefs = await SharedPreferences.getInstance();

    if (uid != null) {
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'name': name,
        'profileImageUrl': _profileImageUrl ?? '',
      }, SetOptions(merge: true));
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

  Future<void> _pickImage() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      final prefs = await SharedPreferences.getInstance();
      final file = File(picked.path);

      setState(() {
        _profileImage = file;
      });

      if (uid != null) {
        final ref = FirebaseStorage.instance.ref().child(
          'profilePics/$uid.jpg',
        );
        await ref.putFile(file);
        final downloadUrl = await ref.getDownloadURL();

        await FirebaseFirestore.instance.collection('users').doc(uid).set({
          'profileImageUrl': downloadUrl,
          'name': _userName,
        }, SetOptions(merge: true));

        await prefs.setString('userImage_$uid', downloadUrl);

        setState(() {
          _profileImageUrl = downloadUrl;
        });
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
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('lastRole');
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

    ImageProvider profileImageProvider;
    if (_profileImage != null) {
      profileImageProvider = FileImage(_profileImage!);
    } else if (_profileImageUrl != null && _profileImageUrl!.isNotEmpty) {
      profileImageProvider = NetworkImage(_profileImageUrl!);
    } else {
      profileImageProvider = const AssetImage('assets/images/etamu_logo.jpg');
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 80),
          child: Column(
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 54,
                  backgroundImage: profileImageProvider,
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
                    _buildSettingsCard(
                      icon: Icons.person,
                      title: 'Edit Profile',
                      onTap: () {},
                    ),
                    _buildSettingsCard(
                      icon: Icons.settings,
                      title: 'App Settings',
                      onTap: () {},
                    ),
                    _buildSettingsCard(
                      icon: Icons.help_outline,
                      title: 'Help & Support',
                      onTap: () {},
                    ),
                    const SizedBox(height: 12),
                    const Divider(thickness: 1),
                    const SizedBox(height: 12),
                    _buildSettingsCard(
                      icon: Icons.info_outline,
                      title: 'About ETAMU',
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
                    _buildSettingsCard(
                      icon: Icons.logout,
                      title: 'Logout',
                      onTap: () => _logout(context),
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

  Widget _buildSettingsCard({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      color: const Color(0xFF002147),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        leading: Icon(icon, size: 28, color: Colors.white),
        title: Text(
          title,
          style: const TextStyle(
            fontFamily: 'BreeSerif',
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
