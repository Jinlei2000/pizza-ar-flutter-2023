// order_item.dart
class OrderItem {
  final int id;
  final Map<String, dynamic> size;
  final Map<String, dynamic>? sauce;
  final Map<String, dynamic>? cheese;
  final List<dynamic>? toppings;
  int quantity;
  double totalPrice;
  double price;

  OrderItem({
    required this.id,
    required this.size,
    required this.sauce,
    required this.cheese,
    required this.toppings,
    required this.quantity,
    required this.totalPrice,
    required this.price,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'size': size,
        'sauce': sauce,
        'cheese': cheese,
        'toppings': toppings,
        'quantity': quantity,
        'totalPrice': totalPrice,
        'price': price,
      };

  OrderItem.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        size = json['size'],
        sauce = json['sauce'],
        cheese = json['cheese'],
        toppings = json['toppings'],
        quantity = json['quantity'],
        totalPrice = json['totalPrice'],
        price = json['price'];
}
