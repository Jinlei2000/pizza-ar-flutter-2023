// overview_order.dart
import 'package:bitz/components/bottom_actions.dart';
import 'package:bitz/components/custom_app_bar.dart';
import 'package:bitz/components/custom_safe_area.dart';
import 'package:bitz/providers/pizza_order_model.dart';
import 'package:bitz/screens/other/pizza/payment.dart';
import 'package:bitz/types/pizza_order.dart';
import 'package:bitz/utils/colors.dart';
import 'package:bitz/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

class OverviewOrderPage extends StatelessWidget {
  const OverviewOrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomSafeArea(
      bottom: true,
      child: Consumer<PizzaOrderModel>(
        builder: (context, pizzaOrder, child) {
          return Scaffold(
            appBar: CustomAppBar(
              title: 'Overview Order',
              onBackTap: () {
                // remove last added pizza
                final pizzaOrderModel =
                    Provider.of<PizzaOrderModel>(context, listen: false);
                if (pizzaOrderModel.selectedPizzas.isNotEmpty) {
                  pizzaOrderModel
                      .removePizza(pizzaOrderModel.selectedPizzas.last.id);
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
            body: _body(context, pizzaOrder),
          );
        },
      ),
    );
  }

  Widget _body(BuildContext context, PizzaOrderModel pizzaOrder) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 24),
      child: Consumer<PizzaOrderModel>(
        builder: (context, pizzaOrder, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // pizzaOrder.selectedPizzas
              ListView.builder(
                itemCount: pizzaOrder.count,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: pizzaOrder.selectedPizzas.isEmpty
                    ? (context, index) => const SizedBox()
                    : (context, index) {
                        final pizza = pizzaOrder.selectedPizzas[index];
                        return Column(
                          children: [
                            // Pizza Card
                            Container(
                              margin: const EdgeInsets.only(bottom: 16),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Size
                                  Text(
                                    pizza.size['size'],
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  // Sauce
                                  Text(
                                    pizza.sauce!['name'],
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  // Cheese
                                  Text(
                                    pizza.cheese!['name'],
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  // Toppings
                                  Text(
                                    pizza.toppings!
                                        .map((e) => e['name'])
                                        .join(', '),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  // Quantity
                                  Text(
                                    'Quantity: ${pizza.quantity}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  // Price
                                  Text(
                                    '€${pizza.totalPrice.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Divider
                            const Divider(),
                          ],
                        );
                      },
              ),

              const Spacer(),
              // Price & Next Button
              BottomActions(
                price: '€${pizzaOrder.totalPrice.toStringAsFixed(2)}',
                nextButtonTitle: 'Checkout',
                nextButtonOnPressed: () {
                  // Navigate to Overview Order Page
                  // PersistentNavBarNavigator.pushNewScreen(
                  //   context,
                  //   screen: const PaymentPage(),
                  //   withNavBar: false,
                  //   // TODO: change animation
                  //   pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  // );

                  // TEST DATA
                  final pizzaOrder =
                      Provider.of<PizzaOrderModel>(context, listen: false);

                  pizzaOrder.addPizza(PizzaOrder(
                    id: 1,
                    size: Pizza.sizes[0],
                    sauce: Pizza.sauces[0],
                    cheese: Pizza.cheeses[0],
                    toppings: [Pizza.vegetable[0], Pizza.meat[0]],
                    quantity: 1,
                    totalPrice: 20,
                  ));
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
