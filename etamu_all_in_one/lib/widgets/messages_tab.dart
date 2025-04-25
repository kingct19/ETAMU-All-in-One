import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MessagesTab extends StatefulWidget {
  const MessagesTab({super.key});

  @override
  State<MessagesTab> createState() => _MessagesTabState();
}

class _MessagesTabState extends State<MessagesTab> {
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
              onPageStarted: (_) {
                setState(() {
                  _isLoading = true;
                });
              },
              onPageFinished: (_) {
                setState(() {
                  _isLoading = false;
                });
              },
            ),
          )
          ..loadRequest(Uri.parse('https://www.tamuc.edu/News'));
  }

  @override
  Widget build(BuildContext context) {
    const Color background = Color(0xFF002147); // ETAMU Navy Blue
    const Color gold = Color(0xFFFFD700); // ETAMU Gold

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Announcements',
          style: TextStyle(
            fontFamily: 'BreeSerif',
            color: Color.fromARGB(221, 255, 255, 255),
          ),
        ),
        backgroundColor: background,
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading)
            const Center(child: CircularProgressIndicator(color: gold)),
        ],
      ),
    );
  }
}
