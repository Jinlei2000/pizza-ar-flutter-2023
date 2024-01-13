import 'package:bitz/components/button.dart';
import 'package:bitz/components/custom_app_bar.dart';
import 'package:bitz/components/pizza_item.dart';
import 'package:bitz/screens/other/pizza/overview_order.dart';
import 'package:bitz/utils/colors.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/services.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class CustomizePizzaArPage extends StatefulWidget {
  const CustomizePizzaArPage({Key? key}) : super(key: key);

  @override
  State<CustomizePizzaArPage> createState() => _CustomizePizzaArPageState();
}

class _CustomizePizzaArPageState extends State<CustomizePizzaArPage> {
  String selectedSize = "S";
  double selectedScaleValue = 0.4;
  String selectedSauce = "";
  String selectedCheese = "";
  List<String> selectedToppings = [];
  Map<String, double> currentPrices = {
    'size': 5,
    'sauce': 0,
    'cheese': 0,
    'toppings': 0
  };
  int pageIndex = 0;
  bool isSwitched = false;
  int _tabTextIndexSelected = 0;
  final List<String> _toggleList = ["Vegetable", "Meat"];
  bool showPopup = true;

  // Pages
  final List<Map<String, dynamic>> pages = [
    {'index': 0, 'title': 'Size'},
    {'index': 1, 'title': 'Sauce'},
    {'index': 2, 'title': 'Cheese'},
    {'index': 3, 'title': 'Toppings'},
  ];

  // Pizza Sizes
  final List<Map<String, dynamic>> pizzaSizes = [
    {'size': 'S', 'price': 5, 'scale': 0.4},
    {'size': 'M', 'price': 10, 'scale': 0.6},
    {'size': 'L', 'price': 15, 'scale': 0.8},
  ];

  // Pizza Sauces
  final List<Map<String, dynamic>> pizzaSauces = [
    {
      'name': 'Tomato',
      'price': 0.5,
      'color': MyColors.tomatoSauce,
      'path': 'assets/models/tomato_sauce.glb'
    },
    {
      'name': 'Bbq',
      'price': 0.5,
      'color': MyColors.bbqSauce,
      'path': 'assets/models/bbq_sauce.glb'
    },
    {
      'name': 'Cream',
      'price': 0.5,
      'color': MyColors.creamSauce,
      'path': 'assets/models/cream_sauce.glb'
    },
  ];

  // Pizza Cheeses
  final List<Map<String, dynamic>> pizzaCheeses = [
    {
      'name': 'Mozzarella',
      'price': 0.5,
      'imagePath': 'assets/images/ingredients/mozzarella.png',
      'path': 'assets/models/mozzarella.glb'
    },
    {
      'name': 'Cheddar',
      'price': 0.5,
      'imagePath': 'assets/images/ingredients/cheddar.png',
      'path': 'assets/models/cheddar.glb'
    },
    {
      'name': 'Emmental',
      'price': 0.5,
      'imagePath': 'assets/images/ingredients/emmental.png',
      'path': 'assets/models/emmental.glb'
    },
  ];

  // Pizza Toppings (Vegetable & Meat)
  final List<Map<String, dynamic>> pizzaVegetable = [
    {
      'name': 'Tomatoes',
      'price': 1,
      'path': 'assets/images/ingredients/tomato.png'
    },
    {
      'name': 'Pepper',
      'price': 1,
      'path': 'assets/images/ingredients/pepper.png'
    },
    {
      'name': 'Onion',
      'price': 1,
      'path': 'assets/images/ingredients/onion.png'
    },
    {
      'name': 'Mushroom',
      'price': 1,
      'path': 'assets/images/ingredients/mushroom.png'
    },
    {
      'name': 'Olive',
      'price': 1,
      'path': 'assets/images/ingredients/olive.png'
    },
  ];
  final List<Map<String, dynamic>> pizzaMeat = [
    {
      'name': 'Pepperoni',
      'price': 2,
      'path': 'assets/images/ingredients/pepperoni.png'
    },
    {'name': 'Ham', 'price': 2, 'path': 'assets/images/ingredients/ham.png'},
    {
      'name': 'Chicken',
      'price': 2,
      'path': 'assets/images/ingredients/chicken.png'
    },
  ];

  // ARKit
  late ARKitController arkitController;
  late Map<String, dynamic> current = {
    'tapPosition': null,
    'anchor': null,
  };
  ARKitGltfNode? doughNode;
  ARKitGltfNode? sauceNode;
  ARKitGltfNode? cheeseNode;

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
            enableTapRecognizer: true,
            planeDetection: ARPlaneDetection.horizontal,
            onARKitViewCreated: onARKitViewCreated,
          ),
          // Popup
          if (pageIndex == 0 && showPopup)
            Positioned(
              top: 0,
              left: 16,
              child: SafeArea(
                child: Container(
                  padding: const EdgeInsets.only(
                    top: 16,
                    bottom: 16,
                    left: 16,
                    right: 16,
                  ),
                  decoration: BoxDecoration(
                    color: MyColors.blur,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 136,
                        child: Text(
                          'Tap to place the pizza on the table',
                          style: TextStyle(
                            color: MyColors.buttonText,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      // close button
                      const SizedBox(width: 16),
                      GestureDetector(
                        onTap: () {
                          // close popup
                          setState(() {
                            showPopup = false;
                          });
                        },
                        child: const Icon(
                          LucideIcons.x,
                          color: MyColors.buttonText,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

          // Bottom Actions
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.only(
                top: 24,
                left: 16,
                right: 16,
              ),
              color: Colors.transparent,
              child: SafeArea(
                top: false,
                bottom: true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Pizza Sizes
                    if (pageIndex == 0) _buildPizzaSize(),
                    // Pizza Sauces
                    if (pageIndex == 1) _buildPizzaSauces(),
                    // Pizza Cheeses
                    if (pageIndex == 2) _buildPizzaCheeses(),
                    // Pizza Toppings
                    if (pageIndex == 3) _buildPizzaToppings(),

                    // Price & Next Button
                    const SizedBox(height: 24),
                    _buildPriceAndNextButton(
                      '€ ${currentPrices.values.reduce((a, b) => a + b)}',
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
          // remove sauce and reset price
          selectedSauce = "";
          currentPrices['sauce'] = 0;
          arkitController.remove(sauceNode!.name);
        } else if (pageIndex == 2) {
          // remove cheese and reset price
          selectedCheese = "";
          currentPrices['cheese'] = 0;
          arkitController.remove(cheeseNode!.name);
        } else if (pageIndex == 3) {
          // remove toppings and reset price
          selectedToppings = [];
          currentPrices['toppings'] = 0;
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

  // Select Pizza Sauces
  Widget _buildPizzaSauces() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: pizzaSauces.map((sauce) {
        bool isSelected = selectedSauce == sauce['name'];

        return GestureDetector(
          onTap: () {
            if (!isSelected) {
              setState(() {
                selectedSauce = sauce['name'].toString();
                _updateSauceAndPrice();
              });
            }
          },
          child: PizzaItem(
            isSelected: isSelected,
            name: sauce['name'].toString(),
            color: sauce['color'] as Color,
          ),
        );
      }).toList(),
    );
  }

  // Select Pizza Cheeses
  Widget _buildPizzaCheeses() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: pizzaCheeses.map((cheese) {
        bool isSelected = selectedCheese == cheese['name'];

        return GestureDetector(
          onTap: () {
            if (!isSelected) {
              setState(() {
                selectedCheese = cheese['name'].toString();
                _updateCheeseAndPrice();
              });
            }
          },
          child: PizzaItem(
            isSelected: isSelected,
            imagePath: cheese['imagePath'].toString(),
            name: cheese['name'].toString(),
          ),
        );
      }).toList(),
    );
  }

  // Select Pizza Toppings
  Widget _buildPizzaToppings() {
    return Column(
      children: [
        // Toggle
        FlutterToggleTab(
          width: 50,
          borderRadius: 30,
          height: 35,
          isShadowEnable: false,
          selectedIndex: _tabTextIndexSelected,
          selectedBackgroundColors: [MyColors.toggleUnselected],
          unSelectedBackgroundColors: [MyColors.toggleUnselected],
          marginSelected: const EdgeInsets.all(2),
          selectedTextStyle: const TextStyle(
            color: MyColors.toggleSelectedText,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          unSelectedTextStyle: TextStyle(
            color: MyColors.toggleUnselectedText,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          labels: _toggleList,
          selectedLabelIndex: (index) {
            setState(() {
              _tabTextIndexSelected = index;
            });
          },
          isScroll: false,
        ),

        // Toppings
        const SizedBox(height: 16),
        // TODO: Add toppings
      ],
    );
  }

  // Price & Next Button
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

    // Update scale of the dough
    selectedScaleValue = pizzaSize['scale'];
    doughNode!.scale = vector.Vector3.all(selectedScaleValue);

    // Update total price
    setState(() {
      currentPrices['size'] = pizzaSize['price'].toDouble();
    });
  }

  // Update Sauce & Price
  void _updateSauceAndPrice() {
    final pizzaSauce = pizzaSauces.firstWhere(
      (sauce) => sauce['name'] == selectedSauce,
      orElse: () => pizzaSauces[0],
    );

    // Add sauce or Update sauce
    if (sauceNode != null) {
      arkitController.remove(sauceNode!.name);
    }

    if (current['anchor'] != null) {
      sauceNode = _loadSauce(current['anchor'].center);
      arkitController.add(sauceNode!,
          parentNodeName: current['anchor'].nodeName);
    } else {
      sauceNode = _loadSauce(current['tapPosition']);
      arkitController.add(sauceNode!);
    }

    // Update total price
    setState(() {
      currentPrices['sauce'] = pizzaSauce['price'].toDouble();
    });
  }

  // Update Cheese & Price
  void _updateCheeseAndPrice() {
    final pizzaCheese = pizzaCheeses.firstWhere(
      (cheese) => cheese['name'] == selectedCheese,
      orElse: () => pizzaCheeses[0],
    );

    // Add cheese or Update cheese
    if (cheeseNode != null) {
      arkitController.remove(cheeseNode!.name);
    }

    if (current['anchor'] != null) {
      cheeseNode = _loadCheese(current['anchor'].center);
      arkitController.add(cheeseNode!,
          parentNodeName: current['anchor'].nodeName);
    } else {
      cheeseNode = _loadCheese(current['tapPosition']);
      arkitController.add(cheeseNode!);
    }

    // Update total price
    setState(() {
      currentPrices['cheese'] = pizzaCheese['price'].toDouble();
    });
  }

  // Update Toppings & Price
  void _updateToppingsAndPrice() {}

  // Add object with plane anchor detected at the beginning
  // when tapping object will be moved to the new position
  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;
    arkitController.addCoachingOverlay(CoachingOverlayGoal.horizontalPlane);
    arkitController.onAddNodeForAnchor = handleInitialObjectPlacement;
    arkitController.onARTap = handleARTap;
  }

  // Add object with plane anchor detected at the beginning
  void handleInitialObjectPlacement(ARKitAnchor anchor) {
    if (anchor is ARKitPlaneAnchor) {
      current['anchor'] = anchor;
      current['tapPosition'] = null;
      _updateNodes(false);
    }
  }

  // Move object to the new position when tapping
  void handleARTap(List<ARKitTestResult> arResults) {
    final point = arResults.firstWhereOrNull(
      (o) => o.type == ARKitHitTestResultType.featurePoint,
    );

    if (point != null) {
      current['anchor'] = null;
      current['tapPosition'] = point.worldTransform.getTranslation();
      _updateNodes(true);
    }
  }

  // Update nodes when tapping or moving
  void _updateNodes(bool isTapping) {
    if (!isTapping) {
      // Tapping
      // Add the pizza dough
      arkitController.remove('dough');
      doughNode = _loadDough(current['anchor'].center);
      arkitController.add(doughNode!,
          parentNodeName: current['anchor'].nodeName);

      // Sauce
      if (pageIndex > 0) {
        if (sauceNode != null) {
          arkitController.remove(sauceNode!.name);
        }
        if (selectedSauce != "") {
          sauceNode = _loadSauce(current['anchor'].center);
          arkitController.add(sauceNode!,
              parentNodeName: current['anchor'].nodeName);
        }
      }
      // Cheese
      if (pageIndex > 1) {
        if (cheeseNode != null) {
          arkitController.remove(cheeseNode!.name);
        }

        if (selectedCheese != "") {
          cheeseNode = _loadCheese(current['anchor'].center);
          arkitController.add(cheeseNode!,
              parentNodeName: current['anchor'].nodeName);
        }
      }
    } else {
      // Plane detected
      if (doughNode != null) {
        arkitController.remove(doughNode!.name);
      }
      doughNode = _loadDough(current['tapPosition']);
      arkitController.add(doughNode!);

      // Sauce
      if (pageIndex > 0) {
        if (sauceNode != null) {
          arkitController.remove(sauceNode!.name);
        }
        if (selectedSauce != "") {
          sauceNode = _loadSauce(current['tapPosition']);
          arkitController.add(sauceNode!);
        }
      }
      // Cheese
      if (pageIndex > 1) {
        if (cheeseNode != null) {
          arkitController.remove(cheeseNode!.name);
        }

        if (selectedCheese != "") {
          cheeseNode = _loadCheese(current['tapPosition']);
          arkitController.add(cheeseNode!);
        }
      }
    }
  }

  ARKitGltfNode _loadDough(vector.Vector3 position) {
    // remove coach overlay
    arkitController.removeCoachingOverlay();

    // check path
    rootBundle.load('assets/models/dough.glb');

    // Add the pizza dough with the updated scale
    return ARKitGltfNode(
      light: ARKitLight(
        type: ARKitLightType.ambient,
        color: Colors.white,
        intensity: 500,
      ),
      name: 'dough',
      assetType: AssetType.flutterAsset,
      url: 'assets/models/dough.glb',
      scale: vector.Vector3.all(selectedScaleValue),
      position: position,
    );
  }

  ARKitGltfNode _loadSauce(vector.Vector3 position) {
    final String saucePath = (pizzaSauces.firstWhere(
      (sauce) => sauce['name'] == selectedSauce,
      orElse: () => pizzaSauces[0],
    ))['path'];

    // check path
    rootBundle.load(saucePath);

    // Add the pizza sauce
    return ARKitGltfNode(
      name: 'sauce',
      assetType: AssetType.flutterAsset,
      url: saucePath,
      scale: vector.Vector3.all(selectedScaleValue),
      position: vector.Vector3(
        position.x,
        position.y + 0.0001,
        position.z,
      ),
    );
  }

  ARKitGltfNode _loadCheese(vector.Vector3 position) {
    final String cheesePath = (pizzaCheeses.firstWhere(
      (cheese) => cheese['name'] == selectedCheese,
      orElse: () => pizzaCheeses[0],
    ))['path'];

    // check path
    rootBundle.load(cheesePath);

    // Add the pizza cheese
    return ARKitGltfNode(
      name: 'cheese',
      assetType: AssetType.flutterAsset,
      url: cheesePath,
      scale: vector.Vector3.all(selectedScaleValue),
      position: vector.Vector3(
        position.x,
        position.y + 0.0002,
        position.z,
      ),
    );
  }
}
