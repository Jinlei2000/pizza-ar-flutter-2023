// home.dart
import 'package:bitz/components/button.dart';
import 'package:bitz/models/tab_navigation_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
      floatingActionButton: _floatingActionButton(context),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
    );
  }

  Container _body() {
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
        ],
      ),
    );
  }

  Container _floatingActionButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24, left: 16, right: 16),
      child: Button(
        text: 'Order Now',
        onPressed: () {
          // Navigate to the Pizza tab
          // Use Provider to get the TabNavigationModel
          final tabNavigationModel =
              Provider.of<TabNavigationModel>(context, listen: false);
          // Call the navigateToTab function from the TabNavigationModel
          tabNavigationModel.navigateToTab(1);
        },
      ),
    );
  }
}
