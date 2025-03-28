import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class GuestHomePage extends StatefulWidget {
  const GuestHomePage({super.key});

  @override
  State<GuestHomePage> createState() => _GuestHomePageState();
}

class _GuestHomePageState extends State<GuestHomePage> {
  late final WebViewController _controller;
  final DraggableScrollableController _draggableController = DraggableScrollableController();
  bool _bannersVisible = true;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse('https://www.tamuc.edu'));
  }

  @override
  Widget build(BuildContext context) {
    const Color navyBlue = Color(0xFF002147);
    const Color lightGray = Color(0xFFF1F1F1);

    return Scaffold(
      body: Stack(
        children: [
          // 🌐 Fullscreen school website
          Positioned.fill(child: WebViewWidget(controller: _controller)),

          // 👇 Floating banner sheet
          if (_bannersVisible)
            DraggableScrollableSheet(
              controller: _draggableController,
              initialChildSize: 0.35,
              minChildSize: 0.1,
              maxChildSize: 0.85,
              builder: (context, scrollController) {
                return Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6,
                        offset: Offset(0, -2),
                      )
                    ],
                  ),
                  child: ListView(
                    controller: scrollController,
                    padding: const EdgeInsets.all(16),
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            '🎥 Discover ETAMU',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'BreeSerif',
                              color: navyBlue,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close, color: navyBlue),
                            onPressed: () {
                              setState(() => _bannersVisible = false);
                            },
                          )
                        ],
                      ),
                      const SizedBox(height: 12),
                      _buildVideoCard(
                        title: 'Why Choose ETAMU?',
                        url: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
                        thumbnail: 'https://img.youtube.com/vi/dQw4w9WgXcQ/0.jpg',
                      ),
                      const SizedBox(height: 12),
                      _buildVideoCard(
                        title: 'Campus Life at ETAMU',
                        url: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
                        thumbnail: 'https://img.youtube.com/vi/dQw4w9WgXcQ/0.jpg',
                      ),
                      const SizedBox(height: 24),
                      ExpansionTile(
                        tilePadding: const EdgeInsets.symmetric(horizontal: 8),
                        backgroundColor: lightGray,
                        collapsedBackgroundColor: lightGray,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        title: const Text(
                          '🏆 Recent Awards & Recognition',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'BreeSerif',
                            color: navyBlue,
                          ),
                        ),
                        children: const [
                          ListTile(
                            title: Text('• ETAMU wins National Research Excellence Award'),
                          ),
                          ListTile(
                            title: Text('• Student robotics team ranked top 5 in Texas'),
                          ),
                          ListTile(
                            title: Text('• Faculty wins NSF innovation grant'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                );
              },
            ),

          // ☰ Floating Menu Button to toggle banner
          Positioned(
            bottom: 24,
            right: 24,
            child: FloatingActionButton.extended(
              backgroundColor: navyBlue,
              foregroundColor: Colors.white,
              onPressed: () {
                setState(() => _bannersVisible = !_bannersVisible);
              },
              icon: Icon(_bannersVisible ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up),
              label: Text(_bannersVisible ? 'Hide Info' : 'Show Info'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoCard({
    required String title,
    required String url,
    required String thumbnail,
  }) {
    return GestureDetector(
      onTap: () async {
        final uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xFF002147)),
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            )
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.horizontal(left: Radius.circular(12)),
              child: Image.network(
                thumbnail,
                width: 120,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontFamily: 'BreeSerif',
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
