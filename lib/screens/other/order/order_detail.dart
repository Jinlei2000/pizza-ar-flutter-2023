// order_detail.dart
import 'package:bitz/components/custom_app_bar.dart';
import 'package:bitz/types/order_item.dart';
import 'package:flutter/material.dart';

class OrderDetailPage extends StatelessWidget {
  final List<OrderItem> orderItems;

  const OrderDetailPage({
    Key? key,
    required this.orderItems,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Order Detail',
      ),
      body: SingleChildScrollView(
        child: _body(),
      ),
    );
  }

  Widget _body() {
    return const Padding(
      padding: EdgeInsets.only(left: 16, right: 16, top: 16),
      child: Column(
        children: [],
      ),
    );
  }
}
