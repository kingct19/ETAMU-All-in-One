import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class GuestWebViewPage extends StatelessWidget {
  final String title;
  final String url;

  const GuestWebViewPage({super.key, required this.title, required this.url});

  @override
  Widget build(BuildContext context) {
    final WebViewController controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(url));

    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: const TextStyle(fontFamily: 'BreeSerif')),
        backgroundColor: const Color(0xFF002147),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
