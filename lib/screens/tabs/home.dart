// home.dart
import 'package:bitz/components/button.dart';
import 'package:bitz/utils/colors.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final void Function(int) navigateToTabIndex;
  const HomePage({
    Key? key,
    required this.navigateToTabIndex, // Pass the new callback in the constructor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.background,
      body: body(),
      floatingActionButton: floatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Container body() {
    return Container(
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
    );
  }

  Container floatingActionButton() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Button(
        text: 'Order Now',
        onPressed: () {
          // go to tab pizza (index 1)
          navigateToTabIndex(1);
        },
      ),
    );
  }
}
