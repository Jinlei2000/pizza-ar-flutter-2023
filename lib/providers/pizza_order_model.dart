// pizza_order_model.dart
import 'package:flutter/material.dart';
import '../types/pizza_order.dart';

class PizzaOrderModel extends ChangeNotifier {
  final List<PizzaOrder> _selectedPizzas = [];

  List<PizzaOrder> get selectedPizzas => _selectedPizzas;

  void addPizza(PizzaOrder pizza) {
    _selectedPizzas.add(pizza);
    notifyListeners();
  }

  void removePizza(int id) {
    _selectedPizzas.removeWhere((pizza) => pizza.id == id);
    notifyListeners();
  }

  void removeAllPizzas() {
    _selectedPizzas.clear();
    notifyListeners();
  }

  void updateQuantity(int id, int quantity) {
    final pizzaToUpdate = _selectedPizzas.firstWhere((pizza) => pizza.id == id);

    // Update quantity
    pizzaToUpdate.quantity = quantity;

    // Update total price
    pizzaToUpdate.totalPrice = pizzaToUpdate.totalPrice * quantity;

    // If the quantity is 0, remove the pizza from the list
    if (quantity == 0) {
      removePizza(id);
    }

    notifyListeners();
  }

  int get count {
    return _selectedPizzas.length;
  }

  double get totalPrice {
    double total = 0;
    for (var pizza in _selectedPizzas) {
      total += pizza.totalPrice * pizza.quantity;
    }
    return total;
  }
}
