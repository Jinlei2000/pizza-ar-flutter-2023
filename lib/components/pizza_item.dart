// pizza_item.dart
import 'package:flutter/material.dart';
import '../utils/colors.dart';

class PizzaItem extends StatelessWidget {
  final bool isSelected;
  final String? imagePath;
  final String name;

  const PizzaItem({
    Key? key,
    required this.isSelected,
    required this.name,
    this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildCircleWithImage(isSelected, imagePath!),
          const SizedBox(height: 4),
          _buildLabel(isSelected, name),
        ],
      ),
    );
  }

  Widget _buildCircleWithImage(bool isSelected, String imagePath) {
    return Container(
      height: 56,
      width: 56,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: isSelected ? MyColors.pizzaItemSelected : MyColors.pizzaItem,
        border: Border.all(
          color: isSelected ? MyColors.pizzaItemBorder : MyColors.borderColor,
          width: 0.5,
        ),
      ),
      alignment: Alignment.center,
      child: Image(
        image: AssetImage(imagePath),
        height: 48,
        width: 48,
      ),
    );
  }

  Widget _buildLabel(bool isSelected, String name) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: isSelected ? MyColors.pizzaItemSelected : MyColors.pizzaItem,
        border: Border.all(
          color: isSelected ? MyColors.pizzaItemBorder : MyColors.borderColor,
          width: 0.5,
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        name,
        style: TextStyle(
          color: MyColors.pizzaItemLabelText,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
