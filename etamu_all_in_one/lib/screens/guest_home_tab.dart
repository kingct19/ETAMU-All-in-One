import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class GuestHomeTab extends StatefulWidget {
  const GuestHomeTab({super.key});

  @override
  State<GuestHomeTab> createState() => _GuestHomeTabState();
}

class _GuestHomeTabState extends State<GuestHomeTab> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setNavigationDelegate(
            NavigationDelegate(
              onPageStarted: (_) => setState(() => _isLoading = true),
              onPageFinished: (_) => setState(() => _isLoading = false),
            ),
          )
          ..loadRequest(Uri.parse('https://www.tamuc.edu'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading)
            const Center(child: CircularProgressIndicator(color: Colors.amber)),
        ],
      ),
    );
  }
}
