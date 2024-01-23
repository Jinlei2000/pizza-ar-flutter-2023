// main.dart
import 'package:bitz/components/bottom_navigation.dart';
import 'package:bitz/providers/cart_model.dart';
import 'package:bitz/providers/pizza_sf_model.dart';
import 'package:bitz/providers/tab_navigation_model.dart';
import 'package:bitz/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartModel()),
        ChangeNotifierProvider(create: (context) => TabNavigationModel()),
        ChangeNotifierProvider(create: (context) => PizzaSFModel()),
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
    // Set some test data for the app
    PizzaSFModel pizzaSFModel =
        Provider.of<PizzaSFModel>(context, listen: false);
    pizzaSFModel.initTestData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Hide debug banner
      debugShowCheckedModeBanner: false,

      home: const BottomNavigation(),
      initialRoute: '/',

      theme: myTheme(),
    );
  }
}
