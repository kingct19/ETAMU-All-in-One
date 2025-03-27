import 'package:flutter/material.dart';

class RoleSelectionPage extends StatelessWidget {
  const RoleSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    const Color purple = Color(0xFF4B0082); // ETAMU Purple
    const Color gold = Color(0xFFFFD700);   // ETAMU Gold

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/etamu_logo.jpg',
                width: 120,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 24),
              Text(
                'Welcome to ETAMU!',
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
              const SizedBox(height: 32),
              _buildRoleButton(context, 'Student', purple, gold, '/login'),
              const SizedBox(height: 16),
              _buildRoleButton(context, 'Faculty', purple, gold, '/login'),
              const SizedBox(height: 16),
              _buildRoleButton(context, 'Guest', gold, purple, '/guest'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoleButton(BuildContext context, String label, Color bgColor, Color textColor, String route) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () {
          Navigator.pushNamed(context, route);
        },
        child: Text(
          label,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
