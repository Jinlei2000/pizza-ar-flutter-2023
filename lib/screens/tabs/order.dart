// order.dart
import 'package:bitz/components/custom_safe_area.dart';
import 'package:bitz/components/order_card.dart';
import 'package:bitz/providers/pizza_sf_model.dart';
import 'package:bitz/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return CustomSafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Orders',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                  color: MyColors.textPrimary,
                ),
              ),
              // list of orders
              const SizedBox(height: 24),
              Consumer<PizzaSFModel>(builder: (
                context,
                pizzaSFModel,
                child,
              ) {
                return Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: pizzaSFModel.orders.length,
                    itemBuilder: (context, index) {
                      // Order card
                      return OrderCard(order: pizzaSFModel.orders[index]);
                    },
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
