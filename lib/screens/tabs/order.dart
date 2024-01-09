// order.dart
import 'package:bitz/components/custom_safe_area.dart';
import 'package:flutter/material.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({Key? key}) : super(key: key);

  // List<OrderModel> orders = [];

  void _getinitialData() {
    // orders = OrderService().getOrders();

    // OR

    // orders = OrderModel().getOrders();

    // activeOrders = OrderModel().getActiveOrders();
  }

  @override
  Widget build(BuildContext context) {
    return const CustomSafeArea(
      child: Scaffold(
        body: Center(child: Text('Order Page')),
      ),
    );
  }
}
