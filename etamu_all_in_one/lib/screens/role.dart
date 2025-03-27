import 'package:flutter/material.dart';

class RolePage extends StatelessWidget {
  const RolePage({super.key});

  void navigateToNext(BuildContext context, String role) {
    if (role == 'Guest') {
      Navigator.pushNamed(context, '/guest');
    } else {
      Navigator.pushNamed(context, '/login', arguments: role);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Define your school colors
    const Color purple = Color(0xFF4B0082); // Deep purple
    const Color gold = Color(0xFFFFD700);   // Gold

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: purple,
        title: const Text('Select Your Role'),
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: gold,
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome to TAMUC!',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: purple,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Please select your role:',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 40),
              _buildRoleButton(context, 'Student', purple, gold),
              const SizedBox(height: 20),
              _buildRoleButton(context, 'Faculty', purple, gold),
              const SizedBox(height: 20),
              _buildRoleButton(context, 'Guest', purple, gold),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoleButton(BuildContext context, String role, Color bgColor, Color textColor) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => navigateToNext(context, role),
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 6,
        ),
        child: Text(
          role,
          style: TextStyle(
            color: textColor,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
