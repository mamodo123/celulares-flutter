import 'package:flutter/material.dart';
import 'package:phones/widgets/scaffold.dart';

import '../../values/routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MyAppScaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: homeItems.map((item) => item.screen).toList(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: homeItems
            .map<BottomNavigationBarItem>(
              (item) => BottomNavigationBarItem(
                icon: Icon(item.icon),
                label: item.title,
              ),
            )
            .toList(),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
