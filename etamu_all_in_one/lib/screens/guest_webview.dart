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
        backgroundColor: const Color(0xFF002147),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFFFD700), size: 28),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Color(0xFFFFD700),
            fontFamily: 'BreeSerif',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: controller),
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              backgroundColor: const Color(0xFF002147),
              onPressed: () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
              },
              child: const Icon(Icons.arrow_back, color: Color(0xFFFFD700)),
            ),
          ),
        ],
      ),
    );
  }
}
