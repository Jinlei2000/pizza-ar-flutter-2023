// // bottom_navigation.dart
// import 'package:flutter/material.dart';
// import '../theme/colors.dart';
// import 'package:lucide_icons/lucide_icons.dart';

// class BottomNavigation extends StatefulWidget {
//   const BottomNavigation({Key? key}) : super(key: key);

//   @override
//   State<BottomNavigation> createState() => _BottomNavigationState();
// }

// class _BottomNavigationState extends State<BottomNavigation> {
//   int currentPageIndex = 0;

//   final List<Widget> pages = [
//     const HomePage(),
//     const PizzaPage(),
//     const OrderPage(),
//     const ProfilePage(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: Container(
//         decoration: const BoxDecoration(
//           border: Border(
//             top: BorderSide(
//               color: MyColors.gray200,
//               width: 1.0,
//             ),
//           ),
//         ),
//         child: NavigationBar(
//           onDestinationSelected: (int index) {
//             setState(() {
//               currentPageIndex = index;
//             });
//           },
//           indicatorColor: MyColors.button,
//           backgroundColor: MyColors.background,
//           elevation: 0,
//           selectedIndex: currentPageIndex,
//           labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
//           destinations: const <Widget>[
//             NavigationDestination(
//               icon: Icon(LucideIcons.home),
//               label: 'Home',
//             ),
//             NavigationDestination(
//               icon: Icon(LucideIcons.pizza),
//               label: 'Pizza',
//             ),
//             NavigationDestination(
//               icon: Icon(LucideIcons.shoppingBag),
//               label: 'Order',
//             ),
//             NavigationDestination(
//               icon: Icon(LucideIcons.user2),
//               label: 'You',
//             ),
//           ],
//         ),
//       ),
//       body: pages[currentPageIndex],
//     );
//   }
// }

// bottomNavigation.dart
import 'package:flutter/material.dart';
import '../utils/colors.dart';
import 'package:lucide_icons/lucide_icons.dart';

class BottomNavigation extends StatefulWidget {
  final List<Widget> pages;
  final List<IconData> icons;
  final List<String> labels;

  const BottomNavigation({
    Key? key,
    required this.pages,
    required this.icons,
    required this.labels,
  }) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: MyColors.gray200,
              width: 1.0,
            ),
          ),
        ),
        child: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          indicatorColor: MyColors.button,
          backgroundColor: MyColors.background,
          elevation: 0,
          selectedIndex: currentPageIndex,
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          destinations: List.generate(
            widget.icons.length,
            (index) => NavigationDestination(
              icon: Icon(widget.icons[index]),
              label: widget.labels[index],
            ),
          ),
        ),
      ),
      body: widget.pages[currentPageIndex],
    );
  }
}
