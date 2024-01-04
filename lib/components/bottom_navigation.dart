// bottom_navigation.dart
import 'package:flutter/material.dart';
import '../utils/colors.dart';
import 'package:bitz/screens/tabs/home.dart';
import 'package:bitz/screens/tabs/order.dart';
import 'package:bitz/screens/tabs/pizza.dart';
import 'package:bitz/screens/tabs/profile.dart';
import 'package:lucide_icons/lucide_icons.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({
    Key? key,
  }) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomePage(navigateToTabIndex: _navigateToTabIndex),
      const PizzaPage(),
      const OrderPage(),
      const ProfilePage(),
    ];

    const List<IconData> icons = [
      LucideIcons.home,
      LucideIcons.pizza,
      LucideIcons.shoppingBag,
      LucideIcons.user2,
    ];

    const List<String> labels = ['Home', 'Pizza', 'Order', 'You'];

    return Scaffold(
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: MyColors.gray300,
              width: 1,
            ),
          ),
        ),
        child: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              currentTabIndex = index;
            });
          },
          indicatorColor: MyColors.button,
          backgroundColor: MyColors.background,
          elevation: 0,
          selectedIndex: currentTabIndex,
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          destinations: List.generate(
            icons.length,
            (index) => NavigationDestination(
              icon: Icon(icons[index]),
              label: labels[index],
            ),
          ),
        ),
      ),
      body: pages[currentTabIndex],
    );
  }

  // Callback function to handle tab navigation (called from the child widget)
  void _navigateToTabIndex(int index) {
    setState(() {
      currentTabIndex = index;
    });
  }
}
