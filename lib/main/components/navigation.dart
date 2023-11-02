import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../screens/bookmarked.dart';
import '../screens/home.dart';
import '../screens/profile.dart';

class NavigationManager extends StatefulWidget {
  const NavigationManager({super.key});

  @override
  State<NavigationManager> createState() => _NavigationManagerState();
}

class _NavigationManagerState extends State<NavigationManager> {
  // map current page
  int currentIndex = 0;
  // page list
  final screens = const [
    HomeScreen(),
    BookmarkedScreen(),
    ProfileScreen(),
  ];
  // initialize State
  @override
  void initState() {
    currentIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          backgroundColor: Colors.grey.shade200,
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          indicatorColor: AppColors.accentColorTwo,
        ),
        child: NavigationBar(
          height: 70,
          selectedIndex: currentIndex,
          onDestinationSelected: (index) =>
              setState(() => currentIndex = index),
          destinations: const [
            NavigationDestination(
              icon: Icon(
                Icons.home_outlined,
                color: Colors.grey,
              ),
              label: 'Home',
              selectedIcon: Icon(Icons.home),
            ),
            NavigationDestination(
              icon: Icon(
                Icons.bookmark_border_outlined,
                color: Colors.grey,
              ),
              label: 'Saved',
              selectedIcon: Icon(Icons.bookmark),
            ),
            NavigationDestination(
              icon: Icon(
                Icons.account_circle_outlined,
                color: Colors.grey,
              ),
              label: 'Profile',
              selectedIcon: Icon(Icons.account_circle),
            ),
          ],
        ),
      ),
    );
  }
}
