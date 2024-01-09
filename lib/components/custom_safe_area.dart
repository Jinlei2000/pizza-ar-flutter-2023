// custom_safe_area.dart
import 'package:bitz/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomSafeArea extends StatelessWidget {
  const CustomSafeArea({
    Key? key,
    required this.child,
    this.top = true,
  }) : super(key: key);

  final Widget child;
  final bool top;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyColors.background,
      child: SafeArea(
        top: top,
        bottom: false,
        child: child,
      ),
    );
  }
}
