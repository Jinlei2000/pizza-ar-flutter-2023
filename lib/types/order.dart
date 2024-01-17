// order.dart
import 'package:bitz/types/order_item.dart';

class Order {
  final String id;
  final List<OrderItem> orderItems;
  final DateTime createdAt;
  bool isCompleted = false;
  final double totalPrice;

  Order({
    required this.id,
    required this.orderItems,
    required this.createdAt,
    required this.totalPrice,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'orderItems': orderItems.map((e) => e.toJson()).toList(),
        'createdAt': createdAt.toIso8601String(),
        'isCompleted': isCompleted,
        'totalPrice': totalPrice,
      };

  Order.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        orderItems = (json['orderItems'] as List<dynamic>)
            .map((e) => OrderItem.fromJson(e))
            .toList(),
        createdAt = DateTime.parse(json['createdAt']),
        isCompleted = json['isCompleted'],
        totalPrice = json['totalPrice'];
}
