// pizza_card.dart
import 'package:bitz/components/pizza_cart_item.dart';
import 'package:bitz/providers/pizza_order_model.dart';
import 'package:bitz/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class PizzaCard extends StatelessWidget {
  final PizzaOrderModel pizzaOrder;
  final int index;

  const PizzaCard({Key? key, required this.pizzaOrder, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pizza = pizzaOrder.selectedPizzas[index];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Pizza Card
        Container(
          padding: const EdgeInsets.all(16),
          margin: EdgeInsets.only(
            bottom: index == pizzaOrder.count - 1 ? 72 : 16,
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
                        color: pizza.sauce!['color'],
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
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // -
                  GestureDetector(
                    onTap: () {
                      // decrease quantity
                      pizzaOrder.updateQuantity(pizza.id, pizza.quantity - 1);
                    },
                    child: Container(
                      height: 32,
                      width: 32,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                          color: MyColors.borderColor,
                          width: 0.5,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: const Icon(
                        LucideIcons.minus,
                        size: 20,
                        color: Colors.red,
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
                      pizzaOrder.updateQuantity(pizza.id, pizza.quantity + 1);
                    },
                    child: Container(
                      height: 32,
                      width: 32,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                          color: MyColors.borderColor,
                          width: 0.5,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: const Icon(
                        LucideIcons.plus,
                        size: 20,
                        color: Colors.green,
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
  }
}
