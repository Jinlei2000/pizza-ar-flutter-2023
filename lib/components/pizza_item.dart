// pizza_item.dart
import 'package:flutter/material.dart';
import '../utils/colors.dart';

class PizzaItem extends StatelessWidget {
  final bool isSelected;
  final Color? color;
  final String? imagePath;
  final String name;

  // Updated constructor to ensure only color or imagePath is provided, not both.
  const PizzaItem({
    Key? key,
    required this.isSelected,
    required this.name,
    this.color,
    this.imagePath,
  })  : assert(
            (color == null && imagePath != null) ||
                (color != null && imagePath == null),
            'Provide either color or imagePath, but not both.'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          color != null
              ? _buildCircleWithColor(isSelected, color!)
              : _buildCircleWithImage(isSelected, imagePath!),
          const SizedBox(height: 4),
          _buildLabel(isSelected, name),
        ],
      ),
    );
  }

  Widget _buildCircleWithColor(bool isSelected, Color color) {
    return Container(
      height: 56,
      width: 56,
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
          color: color,
        ),
      ),
    );
  }

  Widget _buildCircleWithImage(bool isSelected, String imagePath) {
    return Container(
      height: 56,
      width: 56,
      padding: const EdgeInsets.all(4),
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