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
    const Color gold = Color(0xFFFFD700);
    const Color lightGray = Color(0xFFF1F1F1);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: navyBlue,
        title: const Text(
          'ETAMU Guest Portal',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'BreeSerif',
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 🌐 Embedded WebView
            SizedBox(
              height: 300,
              child: WebViewWidget(controller: _controller),
            ),
            const SizedBox(height: 16),

            // 🎥 Discover ETAMU Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                ],
              ),
            ),

            // 📰 Awards & Recognition Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ExpansionTile(
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
            ),
            const SizedBox(height: 24),
          ],
        ),
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
