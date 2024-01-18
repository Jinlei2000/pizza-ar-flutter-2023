// order.dart
import 'package:bitz/components/custom_safe_area.dart';
import 'package:bitz/data/pizza_sf.dart';
import 'package:bitz/types/order.dart';
import 'package:bitz/types/order_item.dart';
import 'package:bitz/utils/colors.dart';
import 'package:bitz/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:uid/uid.dart';

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

    // Set some orders
    await pizzaSF.addOrder(Order(
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
    ));

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
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      final Order order = orders[index];
                      // order card
                      return Column(
                        children: [
                          Text(order.id),
                          Text(order.createdAt.toString()),
                          Text(order.isCompleted.toString()),
                          Text(order.totalPrice.toString()),
                          const Divider(),
                        ],
                      );
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
