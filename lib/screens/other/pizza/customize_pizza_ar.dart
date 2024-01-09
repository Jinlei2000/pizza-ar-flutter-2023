import 'package:flutter/material.dart';
import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:vector_math/vector_math_64.dart';

class CustomizePizzaArPage extends StatelessWidget {
  const CustomizePizzaArPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
      ),
      body: ARKitSceneView(onARKitViewCreated: onARKitViewCreated),
    );
  }

  void onARKitViewCreated(ARKitController arkitController) {
    final node = ARKitNode(
      geometry: ARKitSphere(radius: 0.1),
      position: Vector3(0, 0, -0.5),
    );
    arkitController.add(node);
  }
}
