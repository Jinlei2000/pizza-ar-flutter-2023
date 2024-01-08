// my_custom_scroll_bar.dart
import 'package:flutter/material.dart';

class MyCustomScrollBar extends StatelessWidget {
  const MyCustomScrollBar({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: child,
        ),
      ],
    );
  }
}
