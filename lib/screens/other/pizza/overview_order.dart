// overview_order.dart
import 'package:bitz/components/custom_app_bar.dart';
import 'package:bitz/providers/pizza_order_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OverviewOrderPage extends StatelessWidget {
  const OverviewOrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PizzaOrderModel>(
      builder: (context, pizzaOrder, child) {
        return Scaffold(
          appBar: CustomAppBar(
            title: 'Overview Order',
            onBackTap: () {
              // remove last added pizza
              final pizzaOrderModel =
                  Provider.of<PizzaOrderModel>(context, listen: false);
              if (pizzaOrderModel.selectedPizza.isNotEmpty) {
                pizzaOrderModel
                    .removePizza(pizzaOrderModel.selectedPizza.last.id);
              }

              Navigator.pop(context);
            },
            onDeleteTap: () {
              // remove all pizza
              final pizzaOrderModel =
                  Provider.of<PizzaOrderModel>(context, listen: false);
              pizzaOrderModel.removeAllPizzas();

              // go to first page
              Navigator.popUntil(context, (route) => route.isFirst);
            },
          ),
          body: SingleChildScrollView(
            child: _body(context, pizzaOrder),
          ),
        );
      },
    );
  }

  Widget _body(BuildContext context, PizzaOrderModel pizzaOrder) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
      child: Column(
        children: [
          const Text('Overview Order'),
          Consumer<PizzaOrderModel>(
            builder: (context, pizzaOrder, child) {
              return Text(
                'Total: €${pizzaOrder.totalPrice.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
