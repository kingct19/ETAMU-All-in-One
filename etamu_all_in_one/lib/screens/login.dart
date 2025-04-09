import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  final String role; // 'student' or 'faculty'
  const LoginScreen({super.key, this.role = 'student'});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      if (!mounted) return;

      final destination =
          widget.role.toLowerCase() == 'faculty'
              ? '/faculty_home'
              : '/student_home';

      Navigator.pushReplacementNamed(context, destination);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login failed. Please check your credentials.'),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color navyBlue = Color(0xFF002147);
    const Color gold = Color(0xFFFFD700);
    const Color skyBlue = Color(0xFFCCE7FF);

    final bool isFaculty = widget.role.toLowerCase() == 'faculty';
    final String label = isFaculty ? 'Email' : 'Username (CWID)';
    final String hint = isFaculty ? 'faculty@example.edu' : '00000000';
    final TextInputType inputType =
        isFaculty ? TextInputType.emailAddress : TextInputType.number;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: gold,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: const Color(0xFF002147),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/etamu_logo.jpg', height: 140),
              const SizedBox(height: 24),
              const Text(
                'Sign in to myLEO',
                style: TextStyle(
                  fontFamily: 'BreeSerif',
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: navyBlue,
                ),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: _emailController,
                keyboardType: inputType,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: skyBlue,
                  labelText: label,
                  hintText: hint,
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: skyBlue,
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _isLoading
                  ? const CircularProgressIndicator()
                  : SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: gold,
                        foregroundColor: navyBlue,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: _login,
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'BreeSerif',
                        ),
                      ),
                    ),
                  ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () {},
                child: const Text(
                  '› Reset your password?',
                  style: TextStyle(fontFamily: 'BreeSerif'),
                ),
              ),
              if (!isFaculty)
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    '› Forgot your CWID?',
                    style: TextStyle(fontFamily: 'BreeSerif'),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
