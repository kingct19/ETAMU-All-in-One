import 'package:flutter/material.dart';
import 'package:etamu_all_in_one/screens/login.dart';

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
              colorFilter: ColorFilter.mode(
                const Color.fromARGB(153, 0, 0, 0), // 0.6 opacity
                BlendMode.darken,
              ),
              child: Image.asset(
                'assets/images/login_bg.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),

          // 🔘 Central content
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // 🖋️ myLEO title
                    const Text(
                      'myLEO',
                      style: TextStyle(
                        fontFamily: 'BreeSerif',
                        fontSize: 36,
                        fontWeight: FontWeight.w900,
                        color: gold,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // 🦁 ETAMU Logo
                    Image.asset(
                      'assets/images/etamu_logo.jpg',
                      width: logoWidth,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 32),

                    // 🎓 Role Buttons
                    _buildRoleButton(context, 'Student', navyBlue, gold, 'student', buttonFontSize),
                    const SizedBox(height: 16),
                    _buildRoleButton(context, 'Faculty', navyBlue, gold, 'faculty', buttonFontSize),
                    const SizedBox(height: 16),
                    _buildRoleButton(context, 'Guest', gold, navyBlue, 'guest', buttonFontSize),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoleButton(
    BuildContext context,
    String label,
    Color bgColor,
    Color textColor,
    String role,
    double fontSize,
  ) {
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
          if (role == 'guest') {
            Navigator.pushNamed(context, '/guest');
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => LoginScreen(role: role),
              ),
            );
          }
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
