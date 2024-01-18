// other.dart
import 'package:bitz/components/button.dart';
import 'package:bitz/components/custom_app_bar.dart';
import 'package:bitz/components/custom_safe_area.dart';
import 'package:bitz/components/my_custom_scroll_bar.dart';
import 'package:bitz/data/pizza_sf.dart';
import 'package:bitz/data/shared_prefs.dart';
import 'package:bitz/utils/colors.dart';
import 'package:flutter/material.dart';

class OtherPage extends StatelessWidget {
  const OtherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomSafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(
          title: 'Other',
        ),
        body: MyCustomScrollBar(
          child: _body(),
        ),
      ),
    );
  }

  Widget _body() {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          const Text(
            'Clear cache',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: MyColors.textPrimary,
            ),
          ),

          const SizedBox(height: 8),

          // Description
          const SizedBox(
            width: 200,
            child: Text(
              'Clear all local data and reset the app',
              style: TextStyle(
                fontSize: 18,
                color: MyColors.textSecondary,
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Clear cache button
          Button(
            text: 'Clear cache',
            color: MyColors.button,
            onPressed: () {
              // Clear all data
              SharedPrefs.clearAllData();

              // Set some test data for the app
              final PizzaSF pizzaSF = PizzaSF();
              // Set some old orders
              pizzaSF.addOldOrders();
            },
          ),
        ],
      ),
    );
  }
}
