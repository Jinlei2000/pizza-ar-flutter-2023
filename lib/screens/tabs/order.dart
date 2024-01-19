// order.dart
import 'package:bitz/components/custom_safe_area.dart';
import 'package:bitz/components/order_card.dart';
import 'package:bitz/data/pizza_sf.dart';
import 'package:bitz/types/order.dart';
import 'package:bitz/utils/colors.dart';
import 'package:flutter/material.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  List<Order> orders = [];

  // BUG: this method is not called when the user navigates back to this page from the payment page

  @override
  void initState() {
    super.initState();
    _getOrdersData();
  }

  Future<void> _getOrdersData() async {
    final PizzaSF pizzaSF = PizzaSF();

    // get all orders
    final List<Order> fetchedOrders = await pizzaSF.getOrders();
    setState(() {
      orders = fetchedOrders;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomSafeArea(
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: _getOrdersData,
          color: MyColors.textPrimary,
          child: Container(
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
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      // Order card
                      return OrderCard(order: orders[index]);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
