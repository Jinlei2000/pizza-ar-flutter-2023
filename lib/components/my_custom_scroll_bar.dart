// my_custom_scroll_bar.dart
import 'package:flutter/material.dart';

class MyCustomScrollBar extends StatelessWidget {
  const MyCustomScrollBar({
    Key? key,
    required this.child,
    this.bottomPadding = 0,
  }) : super(key: key);

  final Widget child;
  final double bottomPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottomPadding),
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: child,
          ),
        ],
      ),
    );
  }
}
