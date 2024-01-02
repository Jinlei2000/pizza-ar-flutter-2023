import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:google_fonts/google_fonts.dart';

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
      // // #FCFDFD
      // backgroundColor: Color(0xFFE5E5E5),
      theme: _buildTheme(Brightness.light),
    );
  }

  ThemeData _buildTheme(brightness) {
    var baseTheme = ThemeData(brightness: brightness);

    return baseTheme.copyWith(
      textTheme: GoogleFonts.interTextTheme(baseTheme.textTheme),
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
        // #3A3A37
        indicatorColor: const Color(0xFF3A3A37),
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
    return const Scaffold(
      body: Center(
        // Make font size bigger
        child: Text(
          'Home iii',
          style: TextStyle(fontSize: 30),
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
