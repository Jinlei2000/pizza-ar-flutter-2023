// order_detail.dart
import 'package:bitz/components/button.dart';
import 'package:bitz/components/custom_app_bar.dart';
import 'package:bitz/components/custom_safe_area.dart';
import 'package:bitz/components/pizza_cart_item.dart';
import 'package:bitz/data/pizza_sf.dart';
import 'package:bitz/types/order.dart';
import 'package:bitz/utils/colors.dart';
import 'package:flutter/material.dart';

class OrderDetailPage extends StatelessWidget {
  final Order order;

  const OrderDetailPage({
    Key? key,
    required this.order,
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
        body: _body(),
      ),
    );
  }

  Widget _body() {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Pizza cards
          Expanded(
            child: _pizzaCardsSection(),
          ),
          // _pizzaCardsSection(),

          // Order summary & button to confirm the order
          _orderSummary(),
        ],
      ),
    );
  }

  Widget _pizzaCardsSection() {
    return Stack(
      children: [
        ListView.builder(
          itemCount: order.orderItems.length,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            final pizza = order.orderItems[index];
            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  margin: EdgeInsets.only(
                    bottom: index == order.orderItems.length - 1 ? 72 : 16,
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

  Widget _orderSummary() {
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
        const SizedBox(height: 56),
        Button(
          text: 'Confirm Order',
          onPressed: () async {
            // TODO: update the order status to completed
            PizzaSF pizzaSF = PizzaSF();

            // update the order status to completed
            await pizzaSF.updateOrderIsCompleted(
              order.id,
            );
          },
        ),
      ],
    );
  }
}
