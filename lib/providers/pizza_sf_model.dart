// pizza_sf_model.dart
import 'package:bitz/data/pizza_sf.dart';
import 'package:bitz/data/shared_prefs.dart';
import 'package:bitz/types/order.dart';
import 'package:flutter/material.dart';

class PizzaSFModel extends ChangeNotifier {
  List<Order> _orders = [];

  List<Order> get orders => _orders;
  final PizzaSF _pizzaSF = PizzaSF();

  // Set some test data for the app
  Future<void> initTestData() async {
    // Clear all data
    await SharedPrefs.clearAllData();

    // Clear orders
    _orders.clear();

    // Set some old orders
    await _pizzaSF.addOldOrders();

    getOrders();
    notifyListeners();
  }

  // add order
  void addOrder(Order order) async {
    // save to database
    await _pizzaSF.addOrder(order);
    getOrders();
    notifyListeners();
  }

  // get all orders
  void getOrders() async {
    // get from database
    final List<Order> orders = await _pizzaSF.getOrders();
    _orders = orders;
    notifyListeners();
  }

  // update order isCompleted to true
  void updateOrderIsCompleted(String orderId) async {
    // save to database
    await _pizzaSF.updateOrderIsCompleted(orderId);
    getOrders();
    notifyListeners();
  }
}
