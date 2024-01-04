// main.dart
import 'package:bitz/components/bottom_navigation.dart';
import 'package:flutter/material.dart';
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

      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        // Default font (Inter)
        fontFamily: GoogleFonts.inter().fontFamily,
      ),
    );
  }
}
