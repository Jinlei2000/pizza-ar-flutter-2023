// order.dart
import 'package:bitz/components/custom_safe_area.dart';
import 'package:bitz/data/pizza_sf.dart';
import 'package:bitz/types/pizza_order.dart';
import 'package:bitz/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  List<PizzaOrder> orders = [];

  @override
  void initState() {
    super.initState();
    _getInitialData();
  }

  Future<void> _getInitialData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final order = PizzaOrder(
      id: 1,
      size: Pizza.sizes[0],
      sauce: Pizza.sauces[0],
      cheese: Pizza.cheeses[0],
      toppings: [Pizza.vegetable[0], Pizza.meat[0], Pizza.meat[1]],
      quantity: 1,
      totalPrice: 20,
      price: 20,
    );

    prefs.setStringList(Pizza.ordersKey, [json.encode(order.toJson())]);

    final res = prefs.getStringList(Pizza.ordersKey);
    if (res != null) {
      setState(() {
        orders = res.map((e) => PizzaOrder.fromJson(json.decode(e))).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomSafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const Text('Order Page'),
            Text('Test: $orders'),
          ],
        ),
      ),
    );
  }
}
