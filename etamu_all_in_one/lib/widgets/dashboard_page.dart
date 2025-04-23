import 'package:flutter/material.dart';
import 'guest_webview.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  final List<Map<String, dynamic>> _studentTools = const [
    {
      'title': 'myLEO',
      'url':
          'https://leoportal.tamuc.edu/uPortal/f/welcome/normal/render.uP?u__gl=1*8ad0r5*_gcl_aw*R0NMLjE3Mzk1NzM5OTYuQ2p3S0NBaUE4THU5QmhBOEVpd0FhZzE2YjhteHEyRGNsaXQyMWpsTnV6QU5NNFB2MTRaRnpwYWpLYlI0Z1dHUVFKQW5GaURaaW4zbllob0NkUkVRQXZEX0J3RQ..*_gcl_au*MTM4MTYwOTQxOC4xNzQzMDcwNTQ5*_ga*MTkzNTU2Nzg5Mi4xNzI0NzI2MDc3*_ga_WMPJF2FXDN*MTc0NDU2NDA2NS42Ny4xLjE3NDQ1NjQwODAuNDUuMC4w',
      'icon': Icons.school,
    },
    {
      'title': 'My Classes (D2L)',
      'url': 'https://myleoonline.tamuc.edu/d2l/login',
      'icon': Icons.laptop_chromebook,
    },
    {
      'title': 'Library Resources',
      'url': 'https://idp.tamuc.edu/idp/profile/cas/login?execution=e8s1',
      'icon': Icons.menu_book,
    },
    {
      'title': 'Graduate DegreeWorks',
      'url':
          'https://leoportal.tamuc.edu/uPortal/f/welcome/normal/render.uP?u__gl=1*api7fl*_gcl_aw*R0NMLjE3Mzk1NzM5OTYuQ2p3S0NBaUE4THU5QmhBOEVpd0FhZzE2YjhteHEyRGNsaXQyMWpsTnV6QU5NNFB2MTRaRnpwYWpLYlI0Z1dHUVFKQW5GaURaaW4zbllob0NkUkVRQXZEX0J3RQ..*_gcl_au*MTM4MTYwOTQxOC4xNzQzMDcwNTQ5*_ga*MTkzNTU2Nzg5Mi4xNzI0NzI2MDc3*_ga_WMPJF2FXDN*MTc0NDU2NDA2NS42Ny4xLjE3NDQ1NjUwMjUuNjAuMC4w',
      'icon': Icons.account_balance,
    },
    {
      'title': 'Undergraduate DegreeWorks',
      'url':
          'https://leoportal.tamuc.edu/uPortal/f/welcome/normal/render.uP?u__gl=1*api7fl*_gcl_aw*R0NMLjE3Mzk1NzM5OTYuQ2p3S0NBaUE4THU5QmhBOEVpd0FhZzE2YjhteHEyRGNsaXQyMWpsTnV6QU5NNFB2MTRaRnpwYWpLYlI0Z1dHUVFKQW5GaURaaW4zbllob0NkUkVRQXZEX0J3RQ..*_gcl_au*MTM4MTYwOTQxOC4xNzQzMDcwNTQ5*_ga*MTkzNTU2Nzg5Mi4xNzI0NzI2MDc3*_ga_WMPJF2FXDN*MTc0NDU2NDA2NS42Ny4xLjE3NDQ1NjUwMjUuNjAuMC4w',
      'icon': Icons.school_outlined,
    },
    {
      'title': 'Email (Outlook)',
      'url':
          'https://outlook.tamuc.edu/owa/auth/logon.aspx?replaceCurrent=1&url=https%3a%2f%2foutlook.tamuc.edu%2fowa%2f%23_gl%3d1*c33jd0*_gcl_aw*R0NMLjE3Mzk1NzM5OTYuQ2p3S0NBaUE4THU5QmhBOEVpd0FhZzE2YjhteHEyRGNsaXQyMWpsTnV6QU5NNFB2MTRaRnpwYWpLYlI0Z1dHUVFKQW5GaURaaW4zbllob0NkUkVRQXZEX0J3RQ..*_gcl_au*MTM4MTYwOTQxOC4xNzQzMDcwNTQ5*_ga*MTkzNTU2Nzg5Mi4xNzI0NzI2MDc3*_ga_WMPJF2FXDN*MTc0NDU2NDA2NS42Ny4xLjE3NDQ1NjUwMjUuNjAuMC4w',
      'icon': Icons.email,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF002147),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            children:
                _studentTools.map((item) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) => GuestWebViewPage(
                                title: item['title'],
                                url: item['url'],
                              ),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF08335B),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xFFFFD700),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(item['icon'], color: Colors.white, size: 36),
                          const SizedBox(height: 12),
                          Text(
                            item['title'],
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'BreeSerif',
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
          ),
        ),
      ),
    );
  }
}
