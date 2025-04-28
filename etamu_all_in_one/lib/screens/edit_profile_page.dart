import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  File? _newProfileImage;
  String? _currentImageUrl;

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      final doc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (doc.exists && mounted) {
        setState(() {
          _nameController.text = doc['name'] ?? '';
          _currentImageUrl = doc['profileImageUrl'];
        });
      }
    }
  }

  Future<void> _pickNewImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        _newProfileImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _saveChanges() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    String? updatedImageUrl = _currentImageUrl;

    if (_newProfileImage != null) {
      final ref = FirebaseStorage.instance.ref().child('profilePics/$uid.jpg');
      await ref.putFile(_newProfileImage!);
      updatedImageUrl = await ref.getDownloadURL();
    }

    await FirebaseFirestore.instance.collection('users').doc(uid).set({
      'name': _nameController.text.trim(),
      'profileImageUrl': updatedImageUrl ?? '',
    }, SetOptions(merge: true));

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName_$uid', _nameController.text.trim());
    if (updatedImageUrl != null) {
      await prefs.setString('userImage_$uid', updatedImageUrl);
    }

    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.updateDisplayName(_nameController.text.trim());
    }

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Profile updated successfully!'),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );

    await Future.delayed(const Duration(milliseconds: 500));

    if (mounted) {
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color primary = Color(0xFF002147);
    const Color gold = Color(0xFFFFD700);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        title: const Text(
          'Edit Profile',
          style: TextStyle(fontFamily: 'BreeSerif', color: gold),
        ),
        iconTheme: const IconThemeData(color: gold),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickNewImage,
              child: CircleAvatar(
                radius: 60,
                backgroundImage:
                    _newProfileImage != null
                        ? FileImage(_newProfileImage!)
                        : (_currentImageUrl != null &&
                                _currentImageUrl!.isNotEmpty
                            ? NetworkImage(_currentImageUrl!) as ImageProvider
                            : const AssetImage('assets/images/etamu_logo.jpg')),
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
            const SizedBox(height: 24),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Full Name',
                labelStyle: TextStyle(fontFamily: 'BreeSerif'),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: gold,
                  foregroundColor: primary,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  textStyle: const TextStyle(
                    fontFamily: 'BreeSerif',
                    fontSize: 18,
                  ),
                ),
                onPressed: _saveChanges,
                child: const Text('Save Changes'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
