// shared_prefs.dart

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  late SharedPreferences prefs;

  SharedPrefs() {
    // Call the asynchronous method for initialization
    _initPrefs();
  }

  Future<void> _initPrefs() async {
    // Use the 'await' keyword to wait for the result of the asynchronous call
    prefs = await SharedPreferences.getInstance();
  }

  // Set List<String>
  Future<void> _setStringList(String key, List<String> value) async {
    await prefs.setStringList(key, value);
  }

  // Get List<String>
  Future<List<String>> _getStringList(String key) async {
    return prefs.getStringList(key) ?? [];
  }

  // Clear all data
  // TODO: add a clear button in the app (delete cache data)
  Future<void> clear() async {
    await prefs.clear();
  }

  // PIZZA ORDER
  String pizzaOrderKey = 'pizza_orders';
  // Add pizza to orders
  Future<void> addPizzaOrder(List<String> pizzaOrders) async {
    await _setStringList(pizzaOrderKey, pizzaOrders);
  }

  // Get pizza orders
  Future<List<String>> getPizzaOrders() async {
    return await _getStringList(pizzaOrderKey);
  }
}
