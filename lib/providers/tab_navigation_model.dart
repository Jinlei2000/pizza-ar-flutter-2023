// tab_navigation_model.dart
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class TabNavigationModel extends ChangeNotifier {
  PersistentTabController controller = PersistentTabController();

  // Change the tab index (everywhere in the app)
  void navigateToTab(int index) {
    controller.index = index;
    notifyListeners();
  }
}
