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
    _controller =
        WebViewController()..loadRequest(Uri.parse("https://prideride.app"));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: WebViewWidget(controller: _controller));
  }
}
