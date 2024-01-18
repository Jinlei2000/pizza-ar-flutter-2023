// pizza_sf.dart
import 'dart:convert';
import 'package:bitz/types/order.dart';
import 'package:bitz/types/order_item.dart';
import 'package:bitz/utils/constants.dart';
import 'package:uid/uid.dart';
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

  // add test data (old orders)
  Future<void> addOldOrders() async {
    // Check if there are existing orders
    final List<Order> existingOrders = await getOrders();
    if (existingOrders.isNotEmpty) return;

    // Set some orders
    await addOrder(
      Order(
        id: UId.getId(),
        // Set a old date
        createdAt: DateTime.now().subtract(const Duration(days: 20)),
        isCompleted: true,
        totalPrice: 9,
        orderItems: [
          OrderItem(
            id: 1,
            size: Pizza.sizes[0],
            sauce: Pizza.sauces[0],
            cheese: Pizza.cheeses[0],
            toppings: [Pizza.vegetable[0], Pizza.meat[0]],
            quantity: 1,
            price: 9,
            totalPrice: 9,
          ),
        ],
      ),
    );

    await addOrder(
      Order(
        id: UId.getId(),
        // Set a old date
        createdAt: DateTime.now().subtract(const Duration(days: 15)),
        isCompleted: true,
        totalPrice: 36,
        orderItems: [
          OrderItem(
            id: 1,
            size: Pizza.sizes[2],
            sauce: Pizza.sauces[1],
            cheese: Pizza.cheeses[0],
            toppings: [Pizza.vegetable[3], Pizza.meat[1], Pizza.meat[2]],
            quantity: 1,
            price: 21,
            totalPrice: 21,
          ),
          OrderItem(
            id: 1,
            size: Pizza.sizes[1],
            sauce: Pizza.sauces[2],
            cheese: Pizza.cheeses[2],
            toppings: [Pizza.vegetable[1], Pizza.meat[1], Pizza.vegetable[3]],
            quantity: 1,
            price: 15,
            totalPrice: 15,
          ),
        ],
      ),
    );

    await addOrder(
      Order(
        id: UId.getId(),
        // Set a old date
        createdAt: DateTime.now().subtract(const Duration(days: 10)),
        isCompleted: true,
        totalPrice: 46,
        orderItems: [
          OrderItem(
            id: 1,
            size: Pizza.sizes[2],
            sauce: Pizza.sauces[1],
            cheese: Pizza.cheeses[2],
            toppings: [
              Pizza.vegetable[1],
              Pizza.vegetable[2],
              Pizza.vegetable[3],
              Pizza.meat[0],
              Pizza.meat[1]
            ],
            quantity: 2,
            price: 23,
            totalPrice: 46,
          ),
        ],
      ),
    );
  }
}
