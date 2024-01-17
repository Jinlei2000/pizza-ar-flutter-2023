// pizza_sf.dart
import 'dart:convert';
import 'package:bitz/types/order.dart';
import 'package:bitz/utils/constants.dart';
import 'shared_prefs.dart';

class PizzaSF {
  final String ordersKey = Pizza.ordersKey;

  // add order
  Future<void> addOrder(Order order) async {
    // get existing orders
    final List<Order> existingOrders = await getOrders();

    // add new order
    existingOrders.add(order);

    // convert to List<String>
    final List<String> ordersStringList =
        existingOrders.map((order) => jsonEncode(order)).toList();

    // save to shared prefs
    await SharedPrefs.setStringList(ordersKey, ordersStringList);
  }

  // get all orders
  Future<List<Order>> getOrders() async {
    // get orders from shared prefs
    final List<String> ordersStringList =
        await SharedPrefs.getStringList(ordersKey);

    // if empty, return empty list
    if (ordersStringList.isEmpty) return [];

    // convert to List<Order>
    final List<Order> orders = ordersStringList.map((o) {
      final Map<String, dynamic> orderMap = jsonDecode(o);
      return Order.fromJson(orderMap);
    }).toList();

    return orders;
  }

  // TODO: test this
  // update order isCompleted to true
  Future<void> updateOrderIsCompleted(String orderId) async {
    // get existing orders
    final List<Order> existingOrders = await getOrders();

    // find order
    final Order order = existingOrders.firstWhere((o) => o.id == orderId);

    // update isCompleted
    order.isCompleted = true;

    // convert to List<String>
    final List<String> ordersStringList =
        existingOrders.map((order) => jsonEncode(order)).toList();

    // save to shared prefs
    await SharedPrefs.setStringList(ordersKey, ordersStringList);
  }
}
