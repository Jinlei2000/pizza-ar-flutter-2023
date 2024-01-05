// bottom_navigation.dart
import 'package:bitz/screens/other/pizza/customize_pizza_ar.dart';
import 'package:bitz/screens/other/pizza/overview_order.dart';
import 'package:bitz/screens/other/pizza/payment.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../utils/colors.dart';
import 'package:bitz/screens/tabs/home.dart';
import 'package:bitz/screens/tabs/order.dart';
import 'package:bitz/screens/tabs/pizza.dart';
import 'package:bitz/screens/tabs/profile.dart';
import 'package:lucide_icons/lucide_icons.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({
    Key? key,
  }) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  final PersistentTabController _controller = PersistentTabController();

  List<Widget> _buildScreens() => [
        const HomePage(),
        const PizzaPage(),
        const OrderPage(),
        const ProfilePage(),
      ];

  List<PersistentBottomNavBarItem> _navBarsItems() => [
        PersistentBottomNavBarItem(
          icon: const Icon(LucideIcons.home),
          title: 'Home',
          activeColorPrimary: MyColors.button,
          inactiveColorPrimary: MyColors.gray500,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(LucideIcons.pizza),
          title: 'Pizza',
          activeColorPrimary: MyColors.button,
          inactiveColorPrimary: MyColors.gray500,
          // routeAndNavigatorSettings: RouteAndNavigatorSettings(
          //   initialRoute: '/pizza',
          //   routes: {
          //     '/pizza/customize': (context) => const CustomizePizzaArPage(),
          //     '/pizza/overview-order': (context) => const OverviewOrderPage(),
          //     '/pizza/payment': (context) => const PaymentPage(),
          //   },
          // ),
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(LucideIcons.shoppingBag),
          title: 'Order',
          activeColorPrimary: MyColors.button,
          inactiveColorPrimary: MyColors.gray500,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(LucideIcons.user2),
          title: 'You',
          activeColorPrimary: MyColors.button,
          inactiveColorPrimary: MyColors.gray500,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: MyColors.background,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style1,
    );
  }
}
