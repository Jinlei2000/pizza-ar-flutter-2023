// main.dart
import 'package:bitz/providers/pizza_order_model.dart';
import 'package:bitz/screens/other/pizza/overview_order.dart';
import 'package:bitz/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => PizzaOrderModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Hide debug banner
      debugShowCheckedModeBanner: false,

      // home: const BottomNavigation(),
      home: const OverviewOrderPage(),
      initialRoute: '/',

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
}
