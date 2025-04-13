import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class GuestHomeTab extends StatelessWidget {
  const GuestHomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    final WebViewController controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse('https://www.tamuc.edu'));

    return SafeArea(child: WebViewWidget(controller: controller));
  }
}
