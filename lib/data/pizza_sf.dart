// pizza_sf.dart
import 'dart:convert';
import 'package:bitz/types/pizza_order.dart';
import 'package:bitz/utils/constants.dart';
import 'shared_prefs.dart';

class PizzaSF {
  final String pizzaOrderKey = Pizza.ordersKey;

  Future<void> addPizzaOrders(List<PizzaOrder> pizzaOrders) async {
    final List<String> pizzaOrdersStringList =
        pizzaOrders.map((e) => json.encode(e.toJson())).toList().cast<String>();
    await SharedPrefs.setStringList(pizzaOrderKey, pizzaOrdersStringList);
  }

  Future<List<PizzaOrder>> getPizzaOrders() async {
    final List<String> pizzaOrdersStringList =
        await SharedPrefs.getStringList(pizzaOrderKey);
    if (pizzaOrdersStringList.isNotEmpty) {
      return pizzaOrdersStringList
          .map((e) => PizzaOrder.fromJson(json.decode(e)))
          .toList();
    } else {
      return [];
    }
  }
}
