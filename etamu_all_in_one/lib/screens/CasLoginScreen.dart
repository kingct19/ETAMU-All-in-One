import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class CasLoginScreen extends StatefulWidget {
  const CasLoginScreen({super.key});

  @override
  State<CasLoginScreen> createState() => _CasLoginScreenState();
}

class _CasLoginScreenState extends State<CasLoginScreen> {
  late FlutterWebviewPlugin _webviewPlugin;
  final String casLoginUrl =
      'https://idp.tamuc.edu/idp/profile/cas/login?service=https://your-app-url.com';

  @override
  void initState() {
    super.initState();
    _webviewPlugin = FlutterWebviewPlugin();

    _webviewPlugin.onUrlChanged.listen((String url) {
      if (url.contains("ticket=")) {
        final ticket = Uri.parse(url).queryParameters['ticket'];
        _webviewPlugin.close();

        // TODO: Verify ticket with your backend, then navigate
        Navigator.pushReplacementNamed(context, '/student_home');
      }
    });
  }

  @override
  void dispose() {
    _webviewPlugin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: casLoginUrl,
      appBar: AppBar(
        title: const Text("TAMUC Login"),
        backgroundColor: const Color(0xFF002147),
      ),
    );
  }
}
