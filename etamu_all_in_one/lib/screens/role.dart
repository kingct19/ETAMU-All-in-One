import 'package:flutter/material.dart';

class RoleSelectionPage extends StatefulWidget {
  const RoleSelectionPage({super.key});

  @override
  State<RoleSelectionPage> createState() => _RoleSelectionPageState();
}

class _RoleSelectionPageState extends State<RoleSelectionPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..forward();

    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color navyBlue = Color(0xFF002147); // ETAMU Navy Blue
    const Color gold = Color(0xFFFFD700);     // ETAMU Gold

    final double screenWidth = MediaQuery.of(context).size.width;
    final double logoWidth = screenWidth * 0.4; // Responsive logo size
    final double buttonFontSize = screenWidth < 400 ? 16 : 18;

    return Scaffold(
      body: Stack(
        children: [
          // 🎨 Faded background image
          Positioned.fill(
            child: Opacity(
              opacity: 0.15,
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
                    ScaleTransition(
                      scale: _scaleAnimation,
                      child: Image.asset(
                        'assets/images/etamu_logo.jpg',
                        width: logoWidth,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Welcome to ETAMU!',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: navyBlue,
                      ),
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
            color: textColor,
          ),
        ),
      ),
    );
  }
}
