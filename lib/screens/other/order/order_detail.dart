// order_detail.dart
import 'package:bitz/components/button.dart';
import 'package:bitz/components/custom_app_bar.dart';
import 'package:bitz/components/custom_safe_area.dart';
import 'package:bitz/components/pizza_cart_item.dart';
import 'package:bitz/providers/pizza_sf_model.dart';
import 'package:bitz/types/order.dart';
import 'package:bitz/types/order_item.dart';
import 'package:bitz/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderDetailPage extends StatelessWidget {
  final String id;

  const OrderDetailPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} - ${date.hour}:${date.minute < 10 ? '0' : ''}${date.minute}';
  }

  @override
  Widget build(BuildContext context) {
    return CustomSafeArea(
      bottom: true,
      child: Scaffold(
        appBar: const CustomAppBar(
          title: 'Order Detail',
        ),
        body: _body(context),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 24),
      child: Consumer<PizzaSFModel>(builder: (
        context,
        pizzaSFModel,
        child,
      ) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Pizza cards
            Expanded(
              child: _pizzaCardsSection(pizzaSFModel.orders
                  .where((order) => order.id == id)
                  .toList()
                  .first
                  .orderItems),
            ),

            // Order summary & button to confirm the order
            _orderSummary(
                context,
                pizzaSFModel.orders
                    .where((order) => order.id == id)
                    .toList()
                    .first),
          ],
        );
      }),
    );
  }

  Widget _pizzaCardsSection(List<OrderItem> orderItems) {
    return Stack(
      children: [
        ListView.builder(
          itemCount: orderItems.length,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            final pizza = orderItems[index];
            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  margin: EdgeInsets.only(
                    bottom: index == orderItems.length - 1 ? 72 : 16,
                  ),
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
                                color: Color(pizza.sauce!['color'] as int),
                              ),
                            if (pizza.cheese != null)
                              PizzaCardItem(
                                name: pizza.cheese!['name'],
                                imagePath: pizza.cheese!['imagePath'],
                              ),
                            if (pizza.toppings != null)
                              for (final topping in pizza.toppings!)
                                PizzaCardItem(
                                  name: topping['name'],
                                  imagePath: topping['imagePath'],
                                ),
                          ],
                        ),
                      ),
                      // Quantity
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          const Text(
                            'Quantity:',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: MyColors.textPrimary,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            pizza.quantity.toString(),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: MyColors.textPrimary,
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
    );
  }

  Widget _orderSummary(BuildContext context, Order order) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Date
        Row(
          children: [
            const Text(
              'Date',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: MyColors.textSecondary,
              ),
            ),
            const Spacer(),
            Text(
              _formatDate(order.createdAt),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: MyColors.textSecondary,
              ),
            ),
          ],
        ),

        // Total
        const SizedBox(height: 16),
        Row(
          children: [
            const Text(
              'Total',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: MyColors.textPrimary,
              ),
            ),
            const Spacer(),
            Text(
              '€${order.totalPrice.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: MyColors.textPrimary,
              ),
            ),
          ],
        ),

        // Button to confirm the order
        if (!order.isCompleted)
          Container(
            margin: const EdgeInsets.only(top: 56),
            child: Button(
              text: 'Confirm Order',
              onPressed: () async {
                // update the order status to completed
                PizzaSFModel pizzaSFModel =
                    Provider.of<PizzaSFModel>(context, listen: false);
                pizzaSFModel.updateOrderIsCompleted(order.id);

                // go back to the previous screen
                Navigator.pop(context);
              },
            ),
          ),
      ],
    );
  }
}
