// overview_order.dart
import 'package:bitz/components/bottom_actions.dart';
import 'package:bitz/components/custom_app_bar.dart';
import 'package:bitz/components/custom_safe_area.dart';
import 'package:bitz/components/pizza_card.dart';
import 'package:bitz/components/pizza_cart_item.dart';
import 'package:bitz/components/pizza_empty.dart';
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
              // Pizza Cards
              _buildPizzaCardsSection(context, pizzaOrder),

              // Add More Button
              _buildAddMoreButton(context, pizzaOrder),

              // Bottom Actions (Price & Next Button)
              const SizedBox(height: 16),
              _buildBottomActions(context, pizzaOrder),
            ],
          );
        },
      ),
    );
  }

  Widget _buildPizzaCardsSection(
      BuildContext context, PizzaOrderModel pizzaOrder) {
    if (pizzaOrder.selectedPizzas.isNotEmpty) {
      // Selected Pizza's
      return Expanded(
        child: Stack(
          children: [
            ListView.builder(
              itemCount: pizzaOrder.count,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return PizzaCard(pizzaOrder: pizzaOrder, index: index);
              },
            ),
            // Bottom Gradient Overlay
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 72,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white.withOpacity(0.4),
                      MyColors.background,
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      // No available pizzas
      return const PizzaEmpty();
    }
  }

  Widget _buildAddMoreButton(BuildContext context, PizzaOrderModel pizzaOrder) {
    return GestureDetector(
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
    );
  }

  Widget _buildBottomActions(BuildContext context, PizzaOrderModel pizzaOrder) {
    return BottomActions(
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
    );
  }
}
