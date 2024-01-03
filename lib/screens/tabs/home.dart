// home.dart
import 'package:bitz/utils/colors.dart';
import 'package:flutter/material.dart';

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
