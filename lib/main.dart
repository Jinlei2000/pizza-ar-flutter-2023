import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:google_fonts/google_fonts.dart';

import 'theme/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Hide debug banner
      debugShowCheckedModeBanner: false,
      home: const BottomNavigation(),

      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        // Default font (Inter)
        fontFamily: GoogleFonts.inter().fontFamily,
      ),
    );
  }
}

// BOTTOM NAVIGATION BAR
class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int currentPageIndex = 0;

  final List<Widget> pages = [
    const HomePage(),
    const PizzaPage(),
    const OrderPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: MyColors.gray200,
              width: 1.0,
            ),
          ),
        ),
        child: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          indicatorColor: MyColors.button,
          backgroundColor: MyColors.background,
          elevation: 0,
          selectedIndex: currentPageIndex,
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          destinations: const <Widget>[
            NavigationDestination(
              icon: Icon(LucideIcons.home),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(LucideIcons.pizza),
              label: 'Pizza',
            ),
            NavigationDestination(
              icon: Icon(LucideIcons.shoppingBag),
              label: 'Order',
            ),
            NavigationDestination(
              icon: Icon(LucideIcons.user2),
              label: 'You',
            ),
          ],
        ),
      ),
      body: pages[currentPageIndex],
    );
  }
}

// HOME
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: MyColors.background,
      body: Center(
        // Make font size bigger
        child: Text(
          'Home iii',
          style: TextStyle(fontSize: 100),
        ),
      ),
    );
  }
}

// PIZZA
class PizzaPage extends StatelessWidget {
  const PizzaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Pizza'),
      ),
    );
  }
}

// ORDER
class OrderPage extends StatelessWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Order'),
      ),
    );
  }
}

// PROFILE
class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Profile'),
      ),
    );
  }
}
