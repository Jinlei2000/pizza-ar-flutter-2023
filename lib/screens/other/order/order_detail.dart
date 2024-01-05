// order_detail.dart
import 'package:bitz/utils/colors.dart';
import 'package:flutter/material.dart';

class OrderDetailPage extends StatelessWidget {
  const OrderDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: MyColors.background,
      body: Center(
        child: Text(
          'Order Detail',
          style: TextStyle(fontSize: 100),
        ),
      ),
    );
  }
}
