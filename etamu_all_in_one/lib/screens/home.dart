import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Home> {
  int _selectedIndex = 0;

  // List of widgets to display for each tab.
  static const List<Widget> _widgetOptions = <Widget>[
    Center(child: Text('Home Page', style: TextStyle(fontSize: 24))),
    Center(child: Text('Bus Routes', style: TextStyle(fontSize: 24))),
    Center(child: Text('Dining', style: TextStyle(fontSize: 24))),
  ];

  // Handle tab selection.
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ETAMU All-in-One')),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_bus),
            label: 'Bus Routes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant),
            label: 'Dining',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
