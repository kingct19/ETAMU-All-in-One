import 'package:flutter/material.dart';

class GuestHomePage extends StatelessWidget {
  const GuestHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    const Color navyBlue = Color(0xFF002147);
    const Color gold = Color(0xFFFFD700);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: navyBlue,
        title: const Text(
          'Welcome Guest',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'BreeSerif',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(24),
        width: double.infinity,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Explore ETAMU!',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                fontFamily: 'BreeSerif',
                color: navyBlue,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'As a guest, you can view public events, explore the campus, or contact us.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 32),
            _buildCard(context, Icons.map, 'Campus Map', () {}),
            const SizedBox(height: 16),
            _buildCard(context, Icons.event, 'Upcoming Events', () {}),
            const SizedBox(height: 16),
            _buildCard(context, Icons.email, 'Contact Admissions', () {}),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, IconData icon, String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFCCE7FF), // light skyblue tone
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, size: 28, color: Color(0xFF002147)),
            const SizedBox(width: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontFamily: 'BreeSerif',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
