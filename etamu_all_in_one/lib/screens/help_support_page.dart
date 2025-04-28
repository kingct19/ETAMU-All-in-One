import 'package:flutter/material.dart';

class HelpSupportPage extends StatelessWidget {
  const HelpSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primary = Color(0xFF002147);
    const Color secondary = Color(0xFFFFD700);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Help & Support',
          style: TextStyle(fontFamily: 'BreeSerif'),
        ),
        backgroundColor: primary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'How can we help you?',
              style: TextStyle(
                fontFamily: 'BreeSerif',
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: primary,
              ),
            ),
            const SizedBox(height: 16),
            Card(
              color: Color(0xFFF8F9FB),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: Icon(Icons.email, color: primary),
                title: Text(
                  'Contact Support',
                  style: TextStyle(fontFamily: 'BreeSerif'),
                ),
                subtitle: Text(
                  'Cking32@leomail.tamuc.edu',
                  style: TextStyle(color: Colors.black54),
                ),
                onTap: () {
                  // Later: Implement email launcher
                },
              ),
            ),
            const SizedBox(height: 16),
            Card(
              color: Color(0xFFF8F9FB),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: Icon(Icons.question_answer, color: primary),
                title: Text('FAQs', style: TextStyle(fontFamily: 'BreeSerif')),
                subtitle: Text('View Frequently Asked Questions'),
                onTap: () {
                  // Later: Navigate to FAQ page
                },
              ),
            ),
            const SizedBox(height: 16),
            Card(
              color: Color(0xFFF8F9FB),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: Icon(Icons.feedback, color: primary),
                title: Text(
                  'Submit Feedback',
                  style: TextStyle(fontFamily: 'BreeSerif'),
                ),
                subtitle: Text('Tell us how we can improve'),
                onTap: () {
                  // Later: Implement feedback form
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
