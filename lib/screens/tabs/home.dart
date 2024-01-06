// home.dart
import 'package:bitz/components/avatar_image.dart';
import 'package:bitz/components/button.dart';
import 'package:bitz/models/tab_navigation_model.dart';
import 'package:bitz/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: _body(),
      floatingActionButton: _floatingActionButton(context),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      flexibleSpace: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hi, John',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: MyColors.textPrimary,
                    height: 1.2,
                  ),
                ),
                Text(
                  'Discover your ideal slice!',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: MyColors.textSecondary,
                    height: 1.2,
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                // Navigate to the Profile tab
                // Use Provider to get the TabNavigationModel
                final tabNavigationModel =
                    Provider.of<TabNavigationModel>(context, listen: false);
                // Call the navigateToTab function from the TabNavigationModel
                tabNavigationModel.navigateToTab(3);
              },
              child: const AvatarImage(
                size: 48,
                imageUrl: 'https://i.pravatar.cc/300',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _body() {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Location
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Location',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                height: 155,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/map.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Openings Hours
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    'Openings Hours',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: MyColors.red,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Text(
                      'Closed',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: MyColors.tagText,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _cardWithDays(),
            ],
          ),
        ],
      ),
    );
  }

  Container _cardWithDays() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: MyColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          _dayContainer('Monday', 'Closed', isActive: true),
          _dayContainer('Tuesday - Wednesday', '10:00 - 18:00'),
          _dayContainer('Thursday', '10:00 - 20:00'),
          _dayContainer('Friday - Sunday', '10:00 - 18:00'),
        ],
      ),
    );
  }

  Container _dayContainer(String day, String status, {bool isActive = false}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isActive ? MyColors.cardSelectedDate : MyColors.cardBackground,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            day,
            style: const TextStyle(
              fontSize: 16,
              color: MyColors.cardText,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            status,
            style: const TextStyle(
              fontSize: 16,
              color: MyColors.cardText,
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
