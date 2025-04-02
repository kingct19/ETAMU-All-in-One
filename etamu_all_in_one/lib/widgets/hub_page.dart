import 'package:flutter/material.dart';

class HubPage extends StatelessWidget {
  const HubPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> hubItems = [
      {
        'icon': Icons.grade,
        'label': 'Grades',
        'onTap': () {
          // TODO: Navigate to Grades screen
        },
      },
      {
        'icon': Icons.restaurant_menu,
        'label': 'Lunch Menu',
        'onTap': () {
          // TODO: Navigate to Lunch screen
        },
      },
      {
        'icon': Icons.newspaper,
        'label': 'Campus News',
        'onTap': () {
          // TODO: Navigate to News screen
        },
      },
      {
        'icon': Icons.calendar_today,
        'label': 'Calendar',
        'onTap': () {
          // TODO: Navigate to Calendar
        },
      },
      {
        'icon': Icons.directions_bus,
        'label': 'Bus Routes',
        'onTap': () {
          Navigator.pushNamed(context, '/bus');
        },
      },
      {
        'icon': Icons.map,
        'label': 'Campus Map',
        'onTap': () {
          Navigator.pushNamed(context, '/map');
        },
      },
    ];

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          children:
              hubItems.map((item) {
                return GestureDetector(
                  onTap: item['onTap'],
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF002147),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(item['icon'], color: Colors.white, size: 40),
                        const SizedBox(height: 12),
                        Text(
                          item['label'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'BreeSerif',
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
        ),
      ),
    );
  }
}
