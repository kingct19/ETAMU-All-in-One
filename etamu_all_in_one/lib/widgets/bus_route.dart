import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BusRoutePage extends StatefulWidget {
  const BusRoutePage({super.key});

  @override
  State<BusRoutePage> createState() => _BusRoutePageState();
}

class _BusRoutePageState extends State<BusRoutePage> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse("https://www.tamuc.edu/transportation-services/")); // ✅ Initial content
  }

  void _openLiveMap() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const LiveMapPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          WebViewWidget(controller: _controller),
          Positioned(
            bottom: 16,
            right: 16,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF002147),
                foregroundColor: Colors.amber,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              icon: const Icon(Icons.map),
              label: const Text('Live Map'),
              onPressed: _openLiveMap,
            ),
          ),
        ],
      ),
    );
  }
}

class LiveMapPage extends StatelessWidget {
  const LiveMapPage({super.key});

  @override
  Widget build(BuildContext context) {
    final WebViewController controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse("https://prideride.app")); // ✅ Live map

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF002147),
        title: const Text('Live Map'),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
