import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class GuestWebViewPage extends StatelessWidget {
  final String title;
  final String url;

  const GuestWebViewPage({super.key, required this.title, required this.url});

  @override
  Widget build(BuildContext context) {
    final WebViewController controller =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..loadRequest(Uri.parse(url));

    const Color navyBlue = Color(0xFF002147);
    const Color gold = Color(0xFFFFD700);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: navyBlue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: gold, size: 28),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontFamily: 'BreeSerif',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: gold,
          ),
        ),
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: controller),
          // 🟡 Optional floating back button at bottom right
          if (Navigator.canPop(context))
            Positioned(
              bottom: 20,
              right: 20,
              child: FloatingActionButton(
                onPressed: () => Navigator.of(context).pop(),
                backgroundColor: navyBlue,
                child: const Icon(Icons.arrow_back, color: gold),
              ),
            ),
        ],
      ),
    );
  }
}
