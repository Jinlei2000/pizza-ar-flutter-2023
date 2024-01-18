// payment.dart
import 'package:bitz/components/button.dart';
import 'package:bitz/components/custom_app_bar.dart';
import 'package:bitz/components/custom_safe_area.dart';
import 'package:bitz/components/my_custom_scroll_bar.dart';
import 'package:bitz/data/pizza_sf.dart';
import 'package:bitz/providers/pizza_order_model.dart';
import 'package:bitz/providers/tab_navigation_model.dart';
import 'package:bitz/types/order.dart';
import 'package:bitz/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:uid/uid.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  // Selected payment method
  int selectedPaymentMethod = 0;

  @override
  Widget build(BuildContext context) {
    return CustomSafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Payment',
          onDeleteTap: () {
            // remove all pizza
            final pizzaOrderModel =
                Provider.of<PizzaOrderModel>(context, listen: false);
            pizzaOrderModel.removeAllPizzas();

            // go to first page
            Navigator.popUntil(context, (route) => route.isFirst);
          },
        ),
        body: MyCustomScrollBar(
          child: _body(),
        ),
      ),
    );
  }

  Widget _body() {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Payment method
          _paymentMethod(),

          const SizedBox(height: 32),
          const Spacer(flex: 2),

          // Order summary & button to confirm the order
          _orderSummary(),
        ],
      ),
    );
  }

  Widget _orderSummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Estimated time
        const Row(
          children: [
            Text(
              'Estimated time',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: MyColors.textSecondary,
              ),
            ),
            Spacer(),
            Text(
              '20 min',
              style: TextStyle(
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
            Consumer<PizzaOrderModel>(
              builder: (
                context,
                pizzaOrder,
                child,
              ) {
                return Text(
                  '€${pizzaOrder.totalPrice.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: MyColors.textPrimary,
                  ),
                );
              },
            ),
          ],
        ),

        // Button to confirm the order
        const SizedBox(height: 56),
        Button(
          text: 'Order And Pay',
          onPressed: () async {
            final pizzaOrderModel =
                Provider.of<PizzaOrderModel>(context, listen: false);
            final tabNavigationModel =
                Provider.of<TabNavigationModel>(context, listen: false);

            // Add a pizza order to the Shared Preferences
            PizzaSF pizzaSF = PizzaSF();
            Order order = Order(
              id: UId.getId(),
              orderItems: pizzaOrderModel.selectedPizzas,
              createdAt: DateTime.now(),
              totalPrice: pizzaOrderModel.totalPrice,
            );
            await pizzaSF.addOrder(order);

            // Clear the cart after placing the order (provider)
            pizzaOrderModel.removeAllPizzas();

            // Call the navigateToTab function from the TabNavigationModel (Orders tab)
            tabNavigationModel.navigateToTab(2);

            // go to root page
            Navigator.popUntil(context, (route) => route.isFirst);
          },
        ),
      ],
    );
  }

  Widget _paymentMethod() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Payment method
        const Text(
          'Select a payment method',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: MyColors.textPrimary,
          ),
        ),
        const SizedBox(height: 16),
        _paymentMethodItem(
          index: 0,
          icon: LucideIcons.coins,
          text: 'Paying at the register',
        ),
        const SizedBox(height: 8),
        _paymentMethodItem(
          index: 1,
          icon: LucideIcons.creditCard,
          text: 'Debit or Credit Card',
        ),
      ],
    );
  }

  Widget _paymentMethodItem({
    required int index,
    required IconData icon,
    required String text,
  }) {
    bool isSelected = selectedPaymentMethod == index;

    return GestureDetector(
      onTap: () {
        // Update the selected payment method
        setState(() {
          selectedPaymentMethod = index;
        });
      },
      child: Card(
        elevation: 0,
        color: isSelected
            ? MyColors.green.withOpacity(0.1)
            : MyColors.cardBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: isSelected ? MyColors.green : MyColors.borderColor,
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: MyColors.gray900,
                size: 32,
              ),
              const SizedBox(width: 16),
              Text(
                text,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: MyColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
