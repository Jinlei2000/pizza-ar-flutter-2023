// pizza.dart
import 'package:bitz/components/button.dart';
import 'package:bitz/components/custom_safe_area.dart';
import 'package:bitz/components/my_custom_scroll_bar.dart';
import 'package:bitz/screens/other/pizza/customize_pizza_ar.dart';
import 'package:bitz/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class PizzaPage extends StatelessWidget {
  const PizzaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomSafeArea(
      child: Scaffold(
        body: MyCustomScrollBar(
          bottomPadding: 112,
          child: _body(context),
        ),
        floatingActionButton: _floatingActionButton(context),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  Container _body(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Pizza Maker Illustration
          SvgPicture.asset(
            'assets/illustrations/pizza_maker.svg',
            width: 243,
            height: 243,
          ),

          const SizedBox(height: 24),

          // Title
          const Text(
            'Create Your Pizza',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: MyColors.gray900,
            ),
          ),

          const SizedBox(height: 16),

          // Description
          Container(
            constraints: const BoxConstraints(maxWidth: 267),
            child: const Text(
              'Personalize your pizza effortlessly with AR. Choose size, sauce, and toppings for a tasty twist!',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: MyColors.gray700,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Container _floatingActionButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8, left: 16, right: 16),
      child: Button(
        text: 'Let’s Start',
        onPressed: () {
          // Navigate to Customize Pizza AR Page
          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: const CustomizePizzaArPage(),
            withNavBar: false,
            pageTransitionAnimation: PageTransitionAnimation.cupertino,
          );
        },
      ),
    );
  }
}
