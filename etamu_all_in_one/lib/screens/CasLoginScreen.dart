import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CasLoginScreen extends StatefulWidget {
  const CasLoginScreen({super.key});

  @override
  State<CasLoginScreen> createState() => _CasLoginScreenState();
}

class _CasLoginScreenState extends State<CasLoginScreen> {
  late final WebViewController _controller;
  final String casLoginUrl =
      'https://idp.tamuc.edu/idp/profile/cas/login?service=https://your-app-url.com';

  @override
  void initState() {
    super.initState();

    _controller =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("TAMUC Login"),
        backgroundColor: const Color(0xFF002147),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
