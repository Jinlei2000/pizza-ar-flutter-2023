// custom_view.dart
// safe area with custom scroll view

import 'package:flutter/material.dart';

class CustomView extends StatelessWidget {
  final Widget body;

  const CustomView({Key? key, required this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: body,
          ),
        ],
      ),
    );
  }
}
