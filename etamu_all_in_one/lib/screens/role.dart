import 'package:flutter/material.dart';

class RoleSelectionPage extends StatelessWidget {
  const RoleSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    const Color navyBlue = Color(0xFF002147); // ETAMU Navy Blue
    const Color gold = Color(0xFFFFD700);     // ETAMU Gold

    final Size screenSize = MediaQuery.of(context).size;
    final double logoWidth = screenSize.width * 0.4;
    final double buttonFontSize = screenSize.width < 400 ? 16 : 18;

    return Scaffold(
      body: Stack(
        children: [
          // 🎨 Background image with dark overlay
          Positioned.fill(
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.darken),
              child: Image.asset(
                'assets/images/login_bg.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/etamu_logo.jpg',
                      width: logoWidth,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 32),
                    _buildRoleButton(context, 'Student', navyBlue, gold, '/login', buttonFontSize),
                    const SizedBox(height: 16),
                    _buildRoleButton(context, 'Faculty', navyBlue, gold, '/login', buttonFontSize),
                    const SizedBox(height: 16),
                    _buildRoleButton(context, 'Guest', gold, navyBlue, '/guest', buttonFontSize),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoleButton(BuildContext context, String label, Color bgColor, Color textColor, String route, double fontSize) {
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
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
            fontFamily: 'BreeSerif',
            color: textColor,
          ),
        ),
      ),
    );
  }
}
