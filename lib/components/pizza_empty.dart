// pizza_empty.dart

import 'package:bitz/utils/colors.dart';
import 'package:flutter/material.dart';

class PizzaEmpty extends StatelessWidget {
  const PizzaEmpty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: MyColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: MyColors.borderColor,
          width: 1,
        ),
      ),
      child: const Text(
        "No pizza's ordered yet.",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: MyColors.textPrimary,
        ),
      ),
    );
  }
}
