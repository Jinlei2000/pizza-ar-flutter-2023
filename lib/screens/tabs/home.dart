// home.dart
import 'package:bitz/components/avatar_image.dart';
import 'package:bitz/components/button.dart';
import 'package:bitz/components/custom_safe_area.dart';
import 'package:bitz/components/my_custom_scroll_bar.dart';
import 'package:bitz/models/tab_navigation_model.dart';
import 'package:bitz/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomSafeArea(
      child: Scaffold(
        body: MyCustomScrollBar(
          bottomPadding: 112,
          child: Column(
            children: [
              _appBar(context),
              _body(),
            ],
          ),
        ),
        floatingActionButton: _floatingActionButton(context),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterDocked,
      ),
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
                imageUrl: 'https://i.pravatar.cc/300?img=52',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _body() {
    List<Map<String, dynamic>> schedule = [
      {
        'day': 'Monday',
        'hours': 'Closed',
        'days': ['Monday']
      },
      {
        'day': 'Tuesday - Wednesday',
        'hours': '10:00 - 18:00',
        'days': ['Tuesday', 'Wednesday']
      },
      {
        'day': 'Thursday',
        'hours': '10:00 - 20:00',
        'days': ['Thursday']
      },
      {
        'day': 'Friday - Sunday',
        'hours': '10:00 - 18:00',
        'days': ['Friday', 'Saturday', 'Sunday']
      },
    ];

    bool isOpen = false;
    DateTime currentDate = DateTime.now();

    void setStoreStatus() {
      for (var daySchedule in schedule) {
        List<String> days = daySchedule['days'] ?? [];
        String openingHours = daySchedule['hours'] ?? 'Closed';

        // Check if today is one of the scheduled days
        if (days.contains(DateFormat('EEEE').format(currentDate))) {
          // Check if the store is open based on the opening hours
          if (openingHours == 'Closed') {
            isOpen = false;
          } else {
            // Check if the current time is within the opening hours
            int currentTime = int.parse(DateFormat('kkmm').format(currentDate));
            List<String> openingHoursSplit = openingHours.split(' - ');
            int openingTime =
                int.parse(openingHoursSplit[0].replaceAll(':', ''));
            int closingTime =
                int.parse(openingHoursSplit[1].replaceAll(':', ''));

            isOpen = currentTime >= openingTime && currentTime <= closingTime;
          }

          break;
        }
      }
    }

    void checkStoreStatus() {
      Timer.periodic(const Duration(minutes: 5), (Timer timer) {
        // Perform the logic to check the store status here
        // Update the 'isOpen' variable based on the current day and time

        currentDate = DateTime.now();
        setStoreStatus();
      });
    }

    // Call this function to start the periodic checks
    setStoreStatus();
    checkStoreStatus();

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
                  border: Border.all(
                    color: MyColors.cardBorder,
                    width: 0.5,
                  ),
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
                      color: isOpen ? Colors.green : MyColors.red,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      isOpen ? 'Open' : 'Closed',
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: MyColors.tagText,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _cardWithDays(
                schedule: schedule,
                currentDate: currentDate,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container _cardWithDays(
      {required List<Map<String, dynamic>> schedule,
      required DateTime currentDate}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: MyColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: MyColors.cardBorder,
          width: 0.5,
        ),
      ),
      child: Column(
        children: [
          for (var daySchedule in schedule)
            _dayContainer(
              daySchedule['day'] ?? 'Unknown',
              daySchedule['hours'] ?? 'Closed',
              isActive: daySchedule['days']
                      ?.contains(DateFormat('EEEE').format(currentDate)) ??
                  false,
            ),
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
