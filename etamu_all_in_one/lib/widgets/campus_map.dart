// lib/widgets/campus_map.dart
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CampusMapPage extends StatefulWidget {
  const CampusMapPage({super.key});

  @override
  State<CampusMapPage> createState() => _CampusMapPageState();
}

class _CampusMapPageState extends State<CampusMapPage> {
  bool _isBusMap = true;
  bool _isLoading = true;

  late final WebViewController _busController;
  late final WebViewController _campusController;

  @override
  void initState() {
    super.initState();

    _busController =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setNavigationDelegate(
            NavigationDelegate(
              onPageStarted: (_) {
                if (mounted) setState(() => _isLoading = true);
              },
              onPageFinished: (_) {
                if (mounted) setState(() => _isLoading = false);
              },
            ),
          )
          ..loadRequest(Uri.parse('https://prideride.app'));

    _campusController =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setNavigationDelegate(
            NavigationDelegate(
              onPageStarted: (_) {
                if (mounted) setState(() => _isLoading = true);
              },
              onPageFinished: (_) {
                if (mounted) setState(() => _isLoading = false);
              },
            ),
          )
          ..loadRequest(Uri.parse('https://www.tamuc.edu/map/'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: const Text('Maps'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: ToggleButtons(
              isSelected: [_isBusMap, !_isBusMap],
              onPressed: (index) {
                setState(() {
                  _isBusMap = index == 0;
                  _isLoading = true;
                });
              },
              borderRadius: BorderRadius.circular(8),
              selectedColor: Colors.white,
              fillColor: Colors.blue,
              color: Colors.black87,
              borderColor: Colors.white54,
              selectedBorderColor: Colors.white,
              children: const [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text('Bus Map'),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text('Campus Map'),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          WebViewWidget(
            controller: _isBusMap ? _busController : _campusController,
          ),
          if (_isLoading)
            const Center(child: CircularProgressIndicator(color: Colors.amber)),
        ],
      ),
    );
  }
}
