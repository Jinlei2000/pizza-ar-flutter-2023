// pizza_item.dart
import 'package:flutter/material.dart';
import '../utils/colors.dart';

class PizzaItem extends StatelessWidget {
  final bool isSelected;
  final Color sauceColor;
  final String sauceName;

  const PizzaItem({
    Key? key,
    required this.isSelected,
    required this.sauceColor,
    required this.sauceName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSauceCircle(isSelected, sauceColor),
        const SizedBox(height: 4),
        _buildLabel(isSelected, sauceName),
      ],
    );
  }

  Widget _buildSauceCircle(bool isSelected, Color sauceColor) {
    return Container(
      height: 56,
      width: 56,
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: isSelected ? MyColors.pizzaItemSelected : MyColors.pizzaItem,
        border: Border.all(
          color: isSelected ? MyColors.pizzaItemBorder : MyColors.borderColor,
          width: 0.5,
        ),
      ),
      alignment: Alignment.center,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: sauceColor,
        ),
      ),
    );
  }

  Widget _buildLabel(bool isSelected, String sauceName) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: isSelected ? MyColors.pizzaItemSelected : MyColors.pizzaItem,
        border: Border.all(
          color: isSelected ? MyColors.pizzaItemBorder : MyColors.borderColor,
          width: 0.5,
        ),
      ),
      width: 56,
      alignment: Alignment.center,
      child: Text(
        sauceName,
        style: TextStyle(
          color: MyColors.pizzaItemLabelText,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
