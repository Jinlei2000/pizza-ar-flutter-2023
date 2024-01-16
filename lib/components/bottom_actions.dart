// bottom_actions.dart
import 'package:bitz/components/button.dart';
import 'package:bitz/utils/colors.dart';
import 'package:flutter/material.dart';

class BottomActions extends StatelessWidget {
  final String price;
  final String nextButtonTitle;
  final Function nextButtonOnPressed;

  const BottomActions({
    Key? key,
    required this.price,
    required this.nextButtonTitle,
    required this.nextButtonOnPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Price
        Expanded(
            child: Container(
          height: 56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: MyColors.blur,
          ),
          alignment: Alignment.center,
          child: Text(
            price,
            style: const TextStyle(
              color: MyColors.buttonText,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        )),
        const SizedBox(width: 16),
        // Next Button
        Expanded(
          child: Button(
            text: nextButtonTitle,
            onPressed: () {
              nextButtonOnPressed();
            },
          ),
        ),
      ],
    );
  }
}
