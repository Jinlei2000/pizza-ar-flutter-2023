// overview_order.dart
import 'package:bitz/components/bottom_actions.dart';
import 'package:bitz/components/custom_app_bar.dart';
import 'package:bitz/components/custom_safe_area.dart';
import 'package:bitz/components/pizza_cart_item.dart';
import 'package:bitz/providers/pizza_order_model.dart';
import 'package:bitz/screens/other/pizza/payment.dart';
import 'package:bitz/types/pizza_order.dart';
import 'package:bitz/utils/colors.dart';
import 'package:bitz/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

class OverviewOrderPage extends StatefulWidget {
  const OverviewOrderPage({Key? key}) : super(key: key);

  @override
  State<OverviewOrderPage> createState() => _OverviewOrderPageState();
}

class _OverviewOrderPageState extends State<OverviewOrderPage> {
  // TEST DATA
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Initialize the pizzaOrder with test data
      final pizzaOrder = Provider.of<PizzaOrderModel>(context, listen: false);
      pizzaOrder.addPizza(
        PizzaOrder(
          id: 1,
          size: Pizza.sizes[0],
          sauce: Pizza.sauces[0],
          cheese: Pizza.cheeses[0],
          toppings: [Pizza.vegetable[0], Pizza.meat[0], Pizza.meat[1]],
          quantity: 1,
          totalPrice: 20,
          price: 20,
        ),
      );
      pizzaOrder.addPizza(
        PizzaOrder(
          id: 2,
          size: Pizza.sizes[0],
          sauce: Pizza.sauces[0],
          cheese: Pizza.cheeses[0],
          toppings: [Pizza.vegetable[0], Pizza.meat[0], Pizza.meat[1]],
          quantity: 1,
          totalPrice: 20,
          price: 20,
        ),
      );
      pizzaOrder.addPizza(
        PizzaOrder(
          id: 3,
          size: Pizza.sizes[0],
          sauce: Pizza.sauces[0],
          cheese: Pizza.cheeses[0],
          toppings: [Pizza.vegetable[0], Pizza.meat[0], Pizza.meat[1]],
          quantity: 1,
          totalPrice: 20,
          price: 20,
        ),
      );
      pizzaOrder.addPizza(
        PizzaOrder(
          id: 4,
          size: Pizza.sizes[0],
          sauce: Pizza.sauces[0],
          cheese: Pizza.cheeses[0],
          toppings: [Pizza.vegetable[0], Pizza.meat[0], Pizza.meat[1]],
          quantity: 1,
          totalPrice: 20,
          price: 20,
        ),
      );
      pizzaOrder.addPizza(
        PizzaOrder(
          id: 5,
          size: Pizza.sizes[0],
          sauce: Pizza.sauces[0],
          cheese: Pizza.cheeses[0],
          toppings: [Pizza.vegetable[0], Pizza.meat[0], Pizza.meat[1]],
          quantity: 1,
          totalPrice: 20,
          price: 20,
        ),
      );
    });
  }

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
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 24),
      child: Consumer<PizzaOrderModel>(
        builder: (context, pizzaOrder, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Selected Pizza's
              if (pizzaOrder.selectedPizzas.isNotEmpty)
                Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  margin: const EdgeInsets.only(bottom: 16),
                  child: ListView.builder(
                    itemCount: pizzaOrder.count,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final pizza = pizzaOrder.selectedPizzas[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Pizza Card
                          Container(
                            padding: const EdgeInsets.all(16),
                            margin: const EdgeInsets.only(bottom: 16),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: MyColors.cardBackground,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: MyColors.borderColor,
                                width: 1,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Size & Total Price
                                Row(
                                  children: [
                                    Text(
                                      pizza.size['name'],
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: MyColors.textPrimary,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      '€${pizza.totalPrice.toStringAsFixed(2)}',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: MyColors.textPrimary,
                                      ),
                                    ),
                                  ],
                                ),
                                // All the toppings
                                const SizedBox(height: 8),
                                SizedBox(
                                  width: double.infinity,
                                  child: Wrap(
                                    spacing: 8,
                                    runSpacing: 8,
                                    direction: Axis.horizontal,
                                    children: [
                                      if (pizza.sauce != null)
                                        PizzaCardItem(
                                          name: pizza.sauce!['name'],
                                          color: pizza.sauce!['color'],
                                        ),
                                      if (pizza.cheese != null)
                                        PizzaCardItem(
                                          name: pizza.cheese!['name'],
                                          imagePath: pizza.cheese!['imagePath'],
                                        ),
                                      if (pizza.toppings != null)
                                        ...pizza.toppings!.map(
                                          (topping) => PizzaCardItem(
                                            name: topping['name'],
                                            imagePath: topping['imagePath'],
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                // Quantity
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    // -
                                    GestureDetector(
                                      onTap: () {
                                        // decrease quantity
                                        pizzaOrder.updateQuantity(
                                            pizza.id, pizza.quantity - 1);
                                      },
                                      child: Container(
                                        height: 32,
                                        width: 32,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          border: Border.all(
                                            color: MyColors.borderColor,
                                            width: 0.5,
                                          ),
                                        ),
                                        alignment: Alignment.center,
                                        child: const Icon(
                                          LucideIcons.minus,
                                          size: 20,
                                          color: Colors.red, // Use red color
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    // quantity
                                    Text(
                                      pizza.quantity.toString(),
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: MyColors.textPrimary,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    // +
                                    GestureDetector(
                                      onTap: () {
                                        // increase quantity
                                        pizzaOrder.updateQuantity(
                                            pizza.id, pizza.quantity + 1);
                                      },
                                      child: Container(
                                        height: 32,
                                        width: 32,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          border: Border.all(
                                            color: MyColors.borderColor,
                                            width: 0.5,
                                          ),
                                        ),
                                        alignment: Alignment.center,
                                        child: const Icon(
                                          LucideIcons.plus,
                                          size: 20,
                                          color:
                                              Colors.green, // Use green color
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),

              // No available pizzas
              if (pizzaOrder.selectedPizzas.isEmpty)
                Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  alignment: Alignment.center,
                  padding:
                      const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: MyColors.cardBackground,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: MyColors.borderColor,
                      width: 1,
                    ),
                  ),
                  child: const Text(
                    "No pizza's ordered yet.",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: MyColors.textPrimary,
                    ),
                  ),
                ),

              const Spacer(),

              // Add More Button
              GestureDetector(
                onTap: () {
                  // TODO: navigate to custom pizza page
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: MyColors.cardBackground,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: MyColors.borderColor,
                      width: 1,
                    ),
                  ),
                  child: const Flex(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    direction: Axis.horizontal,
                    children: [
                      Icon(
                        LucideIcons.plusCircle,
                        size: 24,
                        color: MyColors.textPrimary,
                      ),
                      SizedBox(width: 16),
                      Text(
                        'Add More',
                        style: TextStyle(
                          height: 1.5,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: MyColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Bottom Actions (Price & Next Button)
              const SizedBox(height: 16),
              BottomActions(
                price: '€${pizzaOrder.totalPrice.toStringAsFixed(2)}',
                nextButtonTitle: 'Checkout',
                nextButtonOnPressed: () {
                  // Navigate to Overview Order Page
                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: const PaymentPage(),
                    withNavBar: false,
                    // TODO: change animation
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                },
                variant: 'card',
              ),
            ],
          );
        },
      ),
    );
  }
}
