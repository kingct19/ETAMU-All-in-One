import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CasLoginScreen extends StatefulWidget {
  const CasLoginScreen({super.key});

  @override
  State<CasLoginScreen> createState() => _CasLoginScreenState();
}

class _CasLoginScreenState extends State<CasLoginScreen> {
  late final WebViewController _controller;

  // ✅ Replace with your actual redirect URL
  final String casLoginUrl =
      'https://idp.tamuc.edu/idp/profile/cas/login?service=https://leoportal.tamuc.edu';

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted) // ✅ Ensures typing works
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (request) {
            final url = request.url;
            if (url.contains("ticket=")) {
              Navigator.pushReplacementNamed(context, '/student_home');
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(casLoginUrl));
  }

  @override
  Widget build(BuildContext context) {
    const navyBlue = Color(0xFF002147);
    const gold = Color(0xFFFFD700);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: navyBlue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: gold),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'TAMUC Login',
          style: TextStyle(
            color: gold,
            fontFamily: 'BreeSerif',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
