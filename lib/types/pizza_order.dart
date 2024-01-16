// pizza.dart
class PizzaOrder {
  final int id;
  final Map<String, dynamic> size;
  final Map<String, dynamic>? sauce;
  final Map<String, dynamic>? cheese;
  final List<dynamic>? toppings;
  int quantity;
  double totalPrice;
  double price;

  PizzaOrder({
    required this.id,
    required this.size,
    required this.sauce,
    required this.cheese,
    required this.toppings,
    required this.quantity,
    required this.totalPrice,
    required this.price,
  });
}
