import 'package:bitz/components/button.dart';
import 'package:bitz/components/custom_app_bar.dart';
import 'package:bitz/utils/colors.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class CustomizePizzaArPage extends StatefulWidget {
  const CustomizePizzaArPage({Key? key}) : super(key: key);

  @override
  State<CustomizePizzaArPage> createState() => _CustomizePizzaArPageState();
}

class _CustomizePizzaArPageState extends State<CustomizePizzaArPage> {
  String selectedSize = "S";

  // ARKit
  late ARKitController arkitController;
  ARKitGltfNode? node;

  @override
  void dispose() {
    arkitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(
        transparent: true,
        title: 'Size',
      ),
      body: Stack(
        children: [
          // ARKitSceneView
          ARKitSceneView(
            showFeaturePoints: true,
            enableTapRecognizer: true,
            planeDetection: ARPlaneDetection.horizontal,
            onARKitViewCreated: onARKitViewCreated,
          ),
          // Bottom Actions
          Positioned(
            bottom: 0,
            left: 16,
            right: 16,
            child: SafeArea(
              bottom: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Pizza Sizes
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSizeButton('S'),
                      const SizedBox(width: 16),
                      _buildSizeButton('M'),
                      const SizedBox(width: 16),
                      _buildSizeButton('L'),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Price & Next Sauce
                  _buildPriceAndNextButton(
                    '€ 9.99',
                    'Next Sauce',
                    () {
                      // TODO: Navigate to next sauce
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSizeButton(String size) {
    bool isSelected = selectedSize == size;

    return GestureDetector(
      onTap: () {
        setState(() {
          if (!isSelected) {
            selectedSize = size;
          }
        });
      },
      child: Container(
        height: 56,
        width: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: isSelected ? MyColors.pizzaItemSelected : MyColors.pizzaItem,
          border: Border.all(
            color: isSelected ? MyColors.pizzaItemBorder : MyColors.borderColor,
            width: 0.5,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          size,
          style: TextStyle(
            color: isSelected
                ? MyColors.pizzaItemTextSelected
                : MyColors.pizzaItemText,
            fontSize: 22,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Widget _buildPriceAndNextButton(
    String price,
    String nextButtonTitle,
    Function() nextButtonOnPressed,
  ) {
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
            text: 'Next Sauce',
            onPressed: () {
              nextButtonOnPressed();
            },
          ),
        ),
      ],
    );
  }

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;
    this.arkitController.onARTap = (ar) {
      final point = ar.firstWhereOrNull(
        (o) => o.type == ARKitHitTestResultType.featurePoint,
      );
      if (point != null) {
        _onARTapHandler(point);
      }
    };
    arkitController.addCoachingOverlay(CoachingOverlayGoal.horizontalPlane);
  }

  void _onARTapHandler(ARKitTestResult point) {
    final position = vector.Vector3(
      point.worldTransform.getColumn(3).x,
      point.worldTransform.getColumn(3).y,
      point.worldTransform.getColumn(3).z,
    );

    print("Tap at position: $position");

    final node = _getNodeFromFlutterAsset(position);
    arkitController.add(node);
  }

  ARKitGltfNode _getNodeFromFlutterAsset(vector.Vector3 position) {
    print("Loading node from Flutter Asset");
    return ARKitGltfNode(
      assetType: AssetType.flutterAsset,
      // Box model from
      url: 'assets/models/Box.gltf',
      scale: vector.Vector3.all(0.1),
      position: position,
    );
  }

  // void onARKitViewCreated(ARKitController arkitController) {
  //   this.arkitController = arkitController;
  //   // Add coaching overlay for horizontal planes
  //   arkitController.addCoachingOverlay(CoachingOverlayGoal.horizontalPlane);
  //   arkitController.onAddNodeForAnchor = _handleAddAnchor;
  // }

  // void _handleAddAnchor(ARKitAnchor anchor) {
  //   print("Anchor detected: $anchor");
  //   if (anchor is ARKitPlaneAnchor) {
  //     _addPlane(arkitController, anchor);
  //   }
  // }

  // void _addPlane(ARKitController controller, ARKitPlaneAnchor anchor) {
  //   print("Adding plane at position: ${anchor.center}");
  //   if (node != null) {
  //     controller.remove(node!.name);
  //   }

  //   node = ARKitGltfNode(
  //     assetType: AssetType.flutterAsset,
  //     // Box model from
  //     url: 'assets/models/Box.gltf',
  //     scale: vector.Vector3.all(0.1),
  //     position: vector.Vector3(
  //       anchor.center.x,
  //       anchor.center.y,
  //       anchor.center.z - 0.5,
  //     ),
  //   );
  //   controller.add(node!, parentNodeName: anchor.nodeName);
  // }
}
