// home.dart
import 'package:bitz/components/button.dart';
import 'package:bitz/utils/colors.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.background,
      // add a button
      body: Container(
        padding: const EdgeInsets.all(16),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40),
            Text(
              'Welcome to Bitz',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Order your favorite pizza',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 40),
          ],
        ),
      ),

      // add a button
      floatingActionButton: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: Button(
          text: 'Order Now',
          onPressed: () {
            // navigate to the order page
            Navigator.pushNamed(context, '/order');
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
