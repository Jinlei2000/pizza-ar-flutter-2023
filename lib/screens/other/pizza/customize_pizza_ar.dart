// customize_pizza_ar.dart
import 'package:flutter/material.dart';

class CustomizePizzaArPage extends StatelessWidget {
  const CustomizePizzaArPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // add appbar with back button
      appBar: AppBar(
        leading: const BackButton(),
      ),

      body: const Center(
        child: Text('Customize Pizza AR'),
      ),
    );
  }
}
