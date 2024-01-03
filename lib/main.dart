// main.dart
import 'package:bitz/components/bottom_navigation.dart';
import 'package:bitz/screens/tabs/home.dart';
import 'package:bitz/screens/tabs/order.dart';
import 'package:bitz/screens/tabs/pizza.dart';
import 'package:bitz/screens/tabs/profile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';

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
      // home: const BottomNavigation(),
      home: const BottomNavigation(
        pages: [
          HomePage(),
          PizzaPage(),
          OrderPage(),
          ProfilePage(),
        ],
        icons: [
          LucideIcons.home,
          LucideIcons.pizza,
          LucideIcons.shoppingBag,
          LucideIcons.user2,
        ],
        labels: ['Home', 'Pizza', 'Order', 'You'],
      ),

      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        // Default font (Inter)
        fontFamily: GoogleFonts.inter().fontFamily,
      ),
    );
  }
}
