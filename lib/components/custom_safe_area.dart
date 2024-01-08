// custom_safe_area.dart
import 'package:bitz/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomSafeArea extends StatelessWidget {
  const CustomSafeArea({
    Key? key,
    required this.child,
    this.top = true,
    this.bottom = true,
  }) : super(key: key);

  final Widget child;
  final bool top;
  final bool bottom;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyColors.background,
      child: SafeArea(
        top: top,
        bottom: bottom,
        child: child,
      ),
    );
  }
}
