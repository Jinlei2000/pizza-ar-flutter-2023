// order.dart
import 'package:bitz/components/custom_safe_area.dart';
import 'package:bitz/data/pizza_sf.dart';
import 'package:bitz/types/pizza_order.dart';
import 'package:bitz/utils/constants.dart';
import 'package:flutter/material.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  List<PizzaOrder> orders = [];

  @override
  void initState() {
    super.initState();
    _getInitialData();
  }

  Future<void> _getInitialData() async {
    final PizzaSF pizzaSF = PizzaSF();

    // add order
    // TEST DATA
    final List<PizzaOrder> testOrders = [
      PizzaOrder(
        id: 1,
        size: Pizza.sizes[0],
        sauce: Pizza.sauces[0],
        cheese: Pizza.cheeses[0],
        toppings: [Pizza.vegetable[0], Pizza.meat[0], Pizza.meat[1]],
        quantity: 1,
        totalPrice: 20,
        price: 20,
      )
    ];
    await pizzaSF.addPizzaOrders(testOrders);

    // get all orders
    final List<PizzaOrder> fetchedOrders = await pizzaSF.getPizzaOrders();
    setState(() {
      orders = fetchedOrders;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomSafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const Text('Order Page'),
            Text('Test: $orders'),
          ],
        ),
      ),
    );
  }
}
