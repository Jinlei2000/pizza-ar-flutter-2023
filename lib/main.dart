// main.dart
import 'package:bitz/components/bottom_navigation.dart';
import 'package:bitz/screens/other/order/order_detail.dart';
import 'package:bitz/screens/other/pizza/customize_pizza_ar.dart';
import 'package:bitz/screens/other/pizza/overview_order.dart';
import 'package:bitz/screens/other/pizza/payment.dart';
import 'package:bitz/screens/tabs/home.dart';
import 'package:bitz/screens/tabs/order.dart';
import 'package:bitz/screens/tabs/pizza.dart';
import 'package:bitz/screens/tabs/profile.dart';
import 'package:bitz/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Hide debug banner
      debugShowCheckedModeBanner: false,

      home: const BottomNavigation(),
      // home: const CustomizePizzaArPage(),
      initialRoute: '/',
      routes: _routes,

      theme: _theme(),
    );
  }

  ThemeData _theme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(background: MyColors.background),
      // set Inter as the default font
      fontFamily: 'Inter',
      appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
    );
  }

  // All routes in the app
  Map<String, WidgetBuilder> get _routes {
    return {
      '/home': (context) => const HomePage(),
      '/order': (context) => const OrderPage(),
      '/pizza': (context) => const PizzaPage(),
      '/profile': (context) => const ProfilePage(),
      '/pizza/customize': (context) => const CustomizePizzaArPage(),
      '/pizza/overview-order': (context) => const OverviewOrderPage(),
      '/pizza/payment': (context) => const PaymentPage(),
      '/order/detail': (context) => const OrderDetailPage(),
    };
  }
}