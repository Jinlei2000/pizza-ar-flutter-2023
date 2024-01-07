// bottom_navigation.dart
import 'package:bitz/models/tab_navigation_model.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
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
          activeColorPrimary: MyColors.bottomNavBarSelectedTab,
          activeColorSecondary: MyColors.bottomNavBarSelectedText,
          inactiveColorPrimary: MyColors.bottomNavBarUnselectedTab,
          iconSize: 24,
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(LucideIcons.pizza),
          title: 'Pizza',
          activeColorPrimary: MyColors.bottomNavBarSelectedTab,
          activeColorSecondary: MyColors.bottomNavBarSelectedText,
          inactiveColorPrimary: MyColors.bottomNavBarUnselectedTab,
          iconSize: 24,
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(LucideIcons.shoppingBag),
          title: 'Order',
          activeColorPrimary: MyColors.bottomNavBarSelectedTab,
          activeColorSecondary: MyColors.bottomNavBarSelectedText,
          inactiveColorPrimary: MyColors.bottomNavBarUnselectedTab,
          iconSize: 24,
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(LucideIcons.user2),
          title: 'You',
          activeColorPrimary: MyColors.bottomNavBarSelectedTab,
          activeColorSecondary: MyColors.bottomNavBarSelectedText,
          inactiveColorPrimary: MyColors.bottomNavBarUnselectedTab,
          iconSize: 24,
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TabNavigationModel(),
      child: Consumer<TabNavigationModel>(
        builder: (context, tabNavigationModel, child) {
          return PersistentTabView(
            context,
            controller: tabNavigationModel.controller,
            screens: _buildScreens(),
            items: _navBarsItems(),
            confineInSafeArea: true,
            handleAndroidBackButtonPress: true,
            resizeToAvoidBottomInset: true,
            stateManagement: true,
            hideNavigationBarWhenKeyboardShows: true,
            popAllScreensOnTapOfSelectedTab: true,
            popActionScreens: PopActionScreensType.all,
            backgroundColor: MyColors.bottomNavBar,
            navBarHeight: 56,
            decoration: const NavBarDecoration(
              border: Border.fromBorderSide(
                BorderSide(width: 0.5, color: MyColors.gray200),
              ),
            ),
            padding: const NavBarPadding.only(
                bottom: 0, top: 0, left: 16, right: 16),
            itemAnimationProperties: const ItemAnimationProperties(
              duration: Duration(milliseconds: 200),
              curve: Curves.ease,
            ),
            screenTransitionAnimation: const ScreenTransitionAnimation(
              animateTabTransition: true,
              curve: Curves.ease,
              duration: Duration(milliseconds: 200),
            ),
            navBarStyle: NavBarStyle.style7,
          );
        },
      ),
    );
  }
}
