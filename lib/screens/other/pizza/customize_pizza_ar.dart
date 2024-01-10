import 'package:bitz/components/button.dart';
import 'package:bitz/components/custom_app_bar.dart';
import 'package:bitz/screens/other/pizza/overview_order.dart';
import 'package:bitz/utils/colors.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class CustomizePizzaArPage extends StatefulWidget {
  const CustomizePizzaArPage({Key? key}) : super(key: key);

  @override
  State<CustomizePizzaArPage> createState() => _CustomizePizzaArPageState();
}

class _CustomizePizzaArPageState extends State<CustomizePizzaArPage> {
  String selectedSize = "S";
  double totalPrice = 5;
  int pageIndex = 0;

  // Pages
  final List<Map<String, dynamic>> pages = [
    {'index': 0, 'title': 'Size'},
    {'index': 1, 'title': 'Sauce'},
    {'index': 2, 'title': 'Cheese'},
    {'index': 3, 'title': 'Toppings'},
  ];

  // Pizza Sizes
  final List<Map<String, dynamic>> pizzaSizes = [
    {'size': 'S', 'price': 5, 'scale': 0.3},
    {'size': 'M', 'price': 10, 'scale': 0.4},
    {'size': 'L', 'price': 15, 'scale': 0.6},
  ];

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
      appBar: CustomAppBar(
        transparent: true,
        title: pages[pageIndex]['title'],
        onBackTap: () => _handleBackButton(),
      ),
      body: Stack(
        children: [
          // ARKitSceneView
          ARKitSceneView(
            // showFeaturePoints: true,
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
                  if (pageIndex == 0) _buildPizzaSize(),

                  // Price & Next Button
                  const SizedBox(height: 24),
                  _buildPriceAndNextButton(
                    '€ $totalPrice',
                    'Next',
                    () {
                      if (pageIndex == 3) {
                        // Navigate to Overview Order Page
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: const OverviewOrderPage(),
                          withNavBar: false,
                          pageTransitionAnimation:
                              PageTransitionAnimation.cupertino,
                        );
                      } else {
                        // Go to next page
                        setState(() {
                          pageIndex++;
                        });
                      }
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

  // Handle Back Button
  void _handleBackButton() {
    if (pageIndex > 0) {
      setState(() {
        if (pageIndex == 1) {
          // TODO: remove sauce
        } else if (pageIndex == 2) {
          // TODO: remove cheese
        } else if (pageIndex == 3) {
          // TODO: remove toppings
        }
        pageIndex--;
      });
    } else {
      // Go back to the previous screen
      Navigator.pop(context);
    }
  }

  // Select Pizza Size
  Widget _buildPizzaSize() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: pizzaSizes.map((size) {
        bool isSelected = selectedSize == size['size'];

        return GestureDetector(
          onTap: () {
            if (!isSelected) {
              setState(() {
                selectedSize = size['size'].toString();
                _updatePizzaSizeAndPrice();
              });
            }
          },
          child: Container(
            height: 56,
            width: 56,
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color:
                  isSelected ? MyColors.pizzaItemSelected : MyColors.pizzaItem,
              border: Border.all(
                color: isSelected
                    ? MyColors.pizzaItemBorder
                    : MyColors.borderColor,
                width: 0.5,
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              size['size'].toString(),
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
      }).toList(),
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
            text: nextButtonTitle,
            onPressed: () {
              nextButtonOnPressed();
            },
          ),
        ),
      ],
    );
  }

  // Update Size & Price
  void _updatePizzaSizeAndPrice() {
    final pizzaSize = pizzaSizes.firstWhere(
      (size) => size['size'] == selectedSize,
      orElse: () => pizzaSizes[0],
    );

    final double scaleValue = pizzaSize['scale'];

    node?.scale = vector.Vector3.all(scaleValue);

    if (node != null) {
      arkitController
        ..remove(node!.name)
        ..add(node!);
    }

    // Update total price
    setState(() {
      totalPrice = pizzaSize['price'].toDouble();
    });
  }

  // Add object with plane anchor detected at the beginning
  // when tapping object will be moved to the new position
  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;

    // Add coaching overlay for horizontal planes
    arkitController.addCoachingOverlay(CoachingOverlayGoal.horizontalPlane);

    // Set up the initial placement when a plane anchor is detected
    this.arkitController.onAddNodeForAnchor = (ARKitAnchor anchor) {
      if (anchor is ARKitPlaneAnchor) {
        _addInitialObject(anchor);
      }
    };

    // Allow changing position on tap
    this.arkitController.onARTap = (ar) {
      final point = ar.firstWhereOrNull(
        (o) => o.type == ARKitHitTestResultType.featurePoint,
      );
      if (point != null) {
        _onARTapHandler(point);
      }
    };
  }

  void _addInitialObject(ARKitPlaneAnchor anchor) {
    // print("Adding initial object at position: ${anchor.center}");

    if (node != null) {
      arkitController.remove(node!.name);
    }

    node = _getNodeFromFlutterAsset(anchor.center);
    arkitController.add(node!, parentNodeName: anchor.nodeName);
  }

  void _onARTapHandler(ARKitTestResult point) {
    final position = vector.Vector3(
      point.worldTransform.getColumn(3).x,
      point.worldTransform.getColumn(3).y,
      point.worldTransform.getColumn(3).z,
    );

    // print("Tap at position: $position");

    if (node != null) {
      // Move the existing node to the new tap position
      arkitController.remove(node!.name);
    }

    node = _getNodeFromFlutterAsset(position);
    arkitController.add(node!);
  }

  ARKitGltfNode _getNodeFromFlutterAsset(vector.Vector3 position) {
    // remove coach overlay
    arkitController.removeCoachingOverlay();

    final double scaleValue = (pizzaSizes.firstWhere(
      (size) => size['size'] == selectedSize,
      orElse: () => pizzaSizes[0],
    ))['scale'];

    // Add the pizza dough with the updated scale
    return ARKitGltfNode(
      light: ARKitLight(
        type: ARKitLightType.ambient,
        color: Colors.white,
        intensity: 500,
      ),
      name: 'dough',
      assetType: AssetType.flutterAsset,
      url: 'assets/models/Dough.glb',
      scale: vector.Vector3.all(scaleValue),
      position: position,
    );
  }
}
