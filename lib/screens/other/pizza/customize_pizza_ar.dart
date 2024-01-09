// customize_pizza_ar.dart
import 'package:bitz/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:vector_math/vector_math_64.dart' as vector_math;

class CustomizePizzaArPage extends StatelessWidget {
  const CustomizePizzaArPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Size',
      ),
      body: Column(
        children: [
          Expanded(
            child: ARKitSceneView(onARKitViewCreated: onARKitViewCreated),
          ),
          _buildButtons(context),
        ],
      ),
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: () {
              // Handle button press
            },
            child: const Text('Button 1'),
          ),
          ElevatedButton(
            onPressed: () {
              // Handle button press
            },
            child: const Text('Button 2'),
          ),
        ],
      ),
    );
  }

  void onARKitViewCreated(ARKitController arkitController) {
    final node = ARKitNode(
      geometry: ARKitSphere(radius: 0.1),
      position: vector_math.Vector3(0, 0, -0.5),
    );
    arkitController.add(node);
  }
}
