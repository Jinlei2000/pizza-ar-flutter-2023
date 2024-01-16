// pizza_cart_item.dart
import 'package:flutter/material.dart';
import '../utils/colors.dart';

class PizzaCardItem extends StatelessWidget {
  final Color? color;
  final String? imagePath;
  final String name;

  const PizzaCardItem({
    Key? key,
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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildCircle(),
        const SizedBox(width: 4),
        _buildLabel(),
      ],
    );
  }

  Widget _buildCircle() {
    return Container(
      height: 24,
      width: 24,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: MyColors.borderColor,
          width: 0.5,
        ),
      ),
      alignment: Alignment.center,
      child: _buildCircleContent(),
    );
  }

  Widget _buildCircleContent() {
    if (color != null) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: color,
        ),
      );
    } else if (imagePath != null) {
      return Image(
        image: AssetImage(imagePath!),
        height: 18,
        width: 18,
      );
    } else {
      return const SizedBox();
    }
  }

  Widget _buildLabel() {
    return Text(
      name,
      style: const TextStyle(
        color: MyColors.textPrimary,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
