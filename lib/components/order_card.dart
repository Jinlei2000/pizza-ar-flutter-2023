// order_card.dart
import 'package:bitz/screens/other/order/order_detail.dart';
import 'package:bitz/types/order.dart';
import 'package:bitz/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({
    Key? key,
    required this.order,
  }) : super(key: key);

  final Order order;

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} - ${date.hour}:${date.minute < 10 ? '0' : ''}${date.minute}';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to the order detail page
        PersistentNavBarNavigator.pushNewScreen(
          context,
          screen: OrderDetailPage(
            order: order,
          ),
          withNavBar: false,
          pageTransitionAnimation: PageTransitionAnimation.cupertino,
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
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
            // Is completed and total price
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color:
                          order.isCompleted ? MyColors.green : MyColors.yellow,
                      width: 0.5,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        order.isCompleted ? Icons.check : Icons.access_time,
                        size: 16,
                        color: order.isCompleted
                            ? MyColors.green
                            : MyColors.yellow,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        order.isCompleted ? 'Served' : 'Being prepared',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: order.isCompleted
                              ? MyColors.green
                              : MyColors.yellow,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Text(
                  '€${order.totalPrice.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: MyColors.textPrimary,
                  ),
                ),
              ],
            ),
            // Number of pizzas
            if (!order.isCompleted)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Text(
                    '${order.orderItems.length} pizza(s)',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: MyColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.only(
                      top: 8,
                    ),
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: MyColors.borderColor,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Estimated time',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: MyColors.textSecondary,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '${order.createdAt.add(const Duration(minutes: 20)).hour}:${order.createdAt.add(const Duration(minutes: 20)).minute}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: MyColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            // Date of order
            if (order.isCompleted)
              Column(
                children: [
                  const SizedBox(height: 16),
                  Text(
                    _formatDate(order.createdAt),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: MyColors.textSecondary,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
