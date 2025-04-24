import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class GuestWebViewPage extends StatefulWidget {
  final String title;
  final String url;

  const GuestWebViewPage({super.key, required this.title, required this.url});

  @override
  State<GuestWebViewPage> createState() => _GuestWebViewPageState();
}

class _GuestWebViewPageState extends State<GuestWebViewPage> {
  bool _isLoading = true;

  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        WebViewController()
          ..setNavigationDelegate(
            NavigationDelegate(
              onPageStarted: (_) => setState(() => _isLoading = true),
              onPageFinished: (_) => setState(() => _isLoading = false),
            ),
          )
          ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
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
