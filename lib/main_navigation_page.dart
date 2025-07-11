import 'package:flutter/material.dart';
import 'main.dart';
import 'events_list_page.dart';

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _currentIndex = 0;
  
  final List<Widget> _pages = [
    const MyHomePage(title: 'Calendar'),
    const EventsListPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: Color(0xFF004D40), // Deep green background
        selectedItemColor: Colors.white, // White color for selected item
        unselectedItemColor: Colors.white70, // Slightly transparent white for unselected items
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Calendar',
            backgroundColor: Color(0xFF004D40), // Deep green background
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Events',
            backgroundColor: Color(0xFF004D40), // Deep green background
          ),
        ],
      ),
    );
  }
}
