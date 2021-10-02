import 'package:flutter/material.dart';
import 'package:parks/list/events_list_page.dart';
import 'package:parks/list/favorites_list_page.dart';
import 'package:parks/list/parks_list_page.dart';
import 'package:parks/util/app_colors.dart';

class TabPage extends StatefulWidget {
  const TabPage({Key? key}) : super(key: key);

  @override
  State<TabPage> createState() => TabPageState();
}

class TabPageState extends State<TabPage> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = [
    EventsListPage(),
    ParksListPage(),
    FavoritesListPage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.park_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.defaultColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
