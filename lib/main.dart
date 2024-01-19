// main.dart
import 'package:bitz/components/bottom_navigation.dart';
import 'package:bitz/data/pizza_sf.dart';
import 'package:bitz/data/shared_prefs.dart';
import 'package:bitz/providers/pizza_order_model.dart';
import 'package:bitz/providers/tab_navigation_model.dart';
import 'package:bitz/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => PizzaOrderModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => TabNavigationModel(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _initTestData();
  }

  // Set some test data for the app
  Future<void> _initTestData() async {
    // Clear all data
    await SharedPrefs.clearAllData();

    // Set some old orders
    final PizzaSF pizzaSF = PizzaSF();
    await pizzaSF.addOldOrders();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Hide debug banner
      debugShowCheckedModeBanner: false,

      home: const BottomNavigation(),
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
