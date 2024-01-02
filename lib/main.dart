import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: BottomNavigation(),
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
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.amber,
        selectedIndex: currentPageIndex,
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
      body: pages[currentPageIndex],
    );
  }
}

// HOME
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your App Name'),
      ),
      body: const Center(
        child: Text('Home'),
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
