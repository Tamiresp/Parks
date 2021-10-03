import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
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
  int _selectedIndex = 1;

  final List<Widget> _widgetOptions = [
    EventsListPage(),
    ParksListPage(),
    FavoritesListPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: FancyBottomNavigation(
        circleColor: AppColors.defaultColor,
        inactiveIconColor: AppColors.defaultColor,
        initialSelection: 1,
          tabs: [
            TabData(
              iconData: Icons.calendar_today,
              title: '',
            ),
            TabData(
              iconData: Icons.park_outlined,
              title: '',
            ),
            TabData(
              iconData: Icons.favorite_border,
              title: '',
            ),
          ],
          onTabChangedListener: (position) {
            setState(() {
              _selectedIndex = position;
            });
          }),
    );
  }
}
