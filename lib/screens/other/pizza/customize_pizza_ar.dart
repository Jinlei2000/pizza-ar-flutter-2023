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
  Map<String, dynamic> selected = {
    'size': {'size': 'S', 'price': 5, 'scale': 0.4},
    'sauce': null,
    'cheese': null,
    'toppings': null,
    'scale': 0.4,
  };
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
      'imagePath': 'assets/images/ingredients/tomato.png',
      'path': 'assets/models/tomato.glb'
    },
    {
      'name': 'Pepper',
      'price': 1,
      'imagePath': 'assets/images/ingredients/pepper.png',
      'path': 'assets/models/pepper.glb'
    },
    {
      'name': 'Onion',
      'price': 1,
      'imagePath': 'assets/images/ingredients/onion.png',
      'path': 'assets/models/onion.glb'
    },
    {
      'name': 'Mushroom',
      'price': 1,
      'imagePath': 'assets/images/ingredients/mushroom.png',
      'path': 'assets/models/mushroom.glb'
    },
    {
      'name': 'Olive',
      'price': 1,
      'imagePath': 'assets/images/ingredients/olive.png',
      'path': 'assets/models/olive.glb'
    },
  ];
  final List<Map<String, dynamic>> pizzaMeat = [
    {
      'name': 'Pepperoni',
      'price': 2,
      'imagePath': 'assets/images/ingredients/pepperoni.png',
      'path': 'assets/models/pepperoni.glb'
    },
    {
      'name': 'Ham',
      'price': 2,
      'imagePath': 'assets/images/ingredients/ham.png',
      'path': 'assets/models/ham.glb'
    },
    {
      'name': 'Chicken',
      'price': 2,
      'imagePath': 'assets/images/ingredients/chicken.png',
      'path': 'assets/models/chicken.glb'
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
  List<ARKitGltfNode> toppingsNodes = [];

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
          selected['sauce'] = null;
          currentPrices['sauce'] = 0;
          if (sauceNode != null) arkitController.remove(sauceNode!.name);
        } else if (pageIndex == 2) {
          // remove cheese and reset price
          selected['cheese'] = null;
          currentPrices['cheese'] = 0;
          if (cheeseNode != null) arkitController.remove(cheeseNode!.name);
        } else if (pageIndex == 3) {
          // remove toppings and reset price
          selected['toppings'] = null;
          currentPrices['toppings'] = 0;
          for (var topping in toppingsNodes) {
            arkitController.remove(topping.name);
          }
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
        bool isSelected = selected['size']['size'] == size['size'];

        return GestureDetector(
          onTap: () {
            if (!isSelected) {
              _updateSize(size);
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
        bool isSelected = selected['sauce']?['name'] == sauce['name'];

        return GestureDetector(
          onTap: () {
            if (!isSelected) {
              _updateSauce(sauce);
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
        bool isSelected = selected['cheese']?['name'] == cheese['name'];

        return GestureDetector(
          onTap: () {
            if (!isSelected) {
              _updateCheese(cheese);
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
      crossAxisAlignment: CrossAxisAlignment.start,
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
        // Vegetable
        if (_tabTextIndexSelected == 0)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: pizzaVegetable.map((topping) {
                bool isSelected =
                    selected['toppings']?.contains(topping['name']) ?? false;

                return GestureDetector(
                  onTap: () {
                    _updateToppings(topping, isSelected);
                  },
                  child: PizzaItem(
                    isSelected: isSelected,
                    imagePath: topping['imagePath'].toString(),
                    name: topping['name'].toString(),
                  ),
                );
              }).toList(),
            ),
          ),
        // Meat
        if (_tabTextIndexSelected == 1)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: pizzaMeat.map((topping) {
              bool isSelected =
                  selected['toppings']?.contains(topping['name']) ?? false;

              return GestureDetector(
                onTap: () {
                  _updateToppings(topping, isSelected);
                },
                child: PizzaItem(
                  isSelected: isSelected,
                  imagePath: topping['imagePath'].toString(),
                  name: topping['name'].toString(),
                ),
              );
            }).toList(),
          ),
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

  // Update Size
  void _updateSize(item) {
    setState(() {
      // Update selected size
      selected['size'] = item;
      // Update total price
      currentPrices['size'] = item['price'].toDouble();
    });

    // Update scale of the dough
    selected['scale'] = item['scale'];
    doughNode!.scale = vector.Vector3.all(selected['scale']);
  }

  // Update Sauce
  void _updateSauce(item) {
    setState(() {
      // Update selected sauce
      // selectedSauce = item['name'].toString();
      selected['sauce'] = item;
      // Update total price
      currentPrices['sauce'] = item['price'].toDouble();
    });

    // Remove sauce if exists
    if (sauceNode != null) {
      arkitController.remove(sauceNode!.name);
    }

    // Add sauce on plane anchor or tap position
    if (current['anchor'] != null) {
      sauceNode = _loadSauce(current['anchor'].center, item['path']);
      arkitController.add(sauceNode!,
          parentNodeName: current['anchor'].nodeName);
    } else {
      sauceNode = _loadSauce(current['tapPosition'], item['path']);
      arkitController.add(sauceNode!);
    }
  }

  // Update Cheese
  void _updateCheese(item) {
    setState(() {
      // Update selected cheese
      // selectedCheese = item['name'].toString();
      selected['cheese'] = item;
      // Update total price
      currentPrices['cheese'] = item['price'].toDouble();
    });

    // Remove cheese if exists
    if (cheeseNode != null) {
      arkitController.remove(cheeseNode!.name);
    }

    // Add cheese on plane anchor or tap position
    if (current['anchor'] != null) {
      cheeseNode = _loadCheese(current['anchor'].center, item['path']);
      arkitController.add(cheeseNode!,
          parentNodeName: current['anchor'].nodeName);
    } else {
      cheeseNode = _loadCheese(current['tapPosition'], item['path']);
      arkitController.add(cheeseNode!);
    }
  }

  // Update Toppings
  void _updateToppings(item, bool isSelected) {
    if (selected['toppings'] == null) {
      selected['toppings'] = [];
    }

    // Select or deselect topping and update total price
    if (!isSelected) {
      setState(() {
        selected['toppings'].add(item['name'].toString());
        currentPrices['toppings'] = currentPrices['toppings']! + item['price'];
      });
    } else {
      setState(() {
        selected['toppings'].remove(item['name'].toString());
        currentPrices['toppings'] = currentPrices['toppings']! - item['price'];
      });
    }

    // Remove toppings if exists
    if (toppingsNodes.isNotEmpty) {
      for (var topping in toppingsNodes) {
        arkitController.remove(topping.name);
      }
      toppingsNodes.clear();
    }

    // Add toppings on plane anchor or tap position
    if (current['anchor'] != null) {
      for (var i = 0; i < selected['toppings']!.length; i++) {
        final item = [...pizzaVegetable, ...pizzaMeat].firstWhere(
          (topping) => topping['name'] == selected['toppings']![i],
        );
        toppingsNodes.add(_loadTopping(
          current['anchor'].center,
          item['path'],
          i * 0.0001,
        ));
        arkitController.add(toppingsNodes[i],
            parentNodeName: current['anchor'].nodeName);
      }
    } else {
      for (var i = 0; i < selected['toppings']!.length; i++) {
        final item = [...pizzaVegetable, ...pizzaMeat].firstWhere(
          (topping) => topping['name'] == selected['toppings']![i],
        );
        toppingsNodes.add(_loadTopping(
          current['tapPosition'],
          item['path'],
          i * 0.0001,
        ));
        arkitController.add(toppingsNodes[i]);
      }
    }
  }

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
      doughNode =
          _loadDough(current['anchor'].center, 'assets/models/dough.glb');
      arkitController.add(doughNode!,
          parentNodeName: current['anchor'].nodeName);

      // Sauce
      if (pageIndex > 0) {
        if (sauceNode != null) {
          arkitController.remove(sauceNode!.name);
        }
        // if (selectedSauce != "") {
        if (selected['sauce'] != null) {
          sauceNode = _loadSauce(
              current['anchor'].center,
              pizzaSauces.firstWhere(
                      // (sauce) => sauce['name'] == selectedSauce)['path']);
                      (sauce) => sauce['name'] == selected['sauce']['name'])[
                  'path']);
          arkitController.add(sauceNode!,
              parentNodeName: current['anchor'].nodeName);
        }
      }
      // Cheese
      if (pageIndex > 1) {
        if (cheeseNode != null) {
          arkitController.remove(cheeseNode!.name);
        }

        // if (selectedCheese != "") {
        if (selected['cheese'] != null) {
          cheeseNode = _loadCheese(
              current['anchor'].center,
              pizzaCheeses.firstWhere(
                      // (cheese) => cheese['name'] == selectedCheese)['path']);
                      (cheese) => cheese['name'] == selected['cheese']['name'])[
                  'path']);
          arkitController.add(cheeseNode!,
              parentNodeName: current['anchor'].nodeName);
        }
      }
    } else {
      // Plane detected
      if (doughNode != null) {
        arkitController.remove(doughNode!.name);
      }
      doughNode = _loadDough(current['tapPosition'], 'assets/models/dough.glb');
      arkitController.add(doughNode!);

      // Sauce
      if (pageIndex > 0) {
        if (sauceNode != null) {
          arkitController.remove(sauceNode!.name);
        }
        // if (selectedSauce != "") {
        if (selected['sauce'] != null) {
          sauceNode = _loadSauce(current['tapPosition'], pizzaSauces.firstWhere(
              // (sauce) => sauce['name'] == selectedSauce)['path']);
              (sauce) => sauce['name'] == selected['sauce']['name'])['path']);
          arkitController.add(sauceNode!);
        }
      }
      // Cheese
      if (pageIndex > 1) {
        if (cheeseNode != null) {
          arkitController.remove(cheeseNode!.name);
        }

        // if (selectedCheese != "") {
        if (selected['cheese'] != null) {
          cheeseNode = _loadCheese(
              current['tapPosition'],
              pizzaCheeses.firstWhere(
                      // (cheese) => cheese['name'] == selectedCheese)['path']);
                      (cheese) => cheese['name'] == selected['cheese']['name'])[
                  'path']);
          arkitController.add(cheeseNode!);
        }
      }
    }
  }

  ARKitGltfNode _loadDough(vector.Vector3 position, String url) {
    // remove coach overlay
    arkitController.removeCoachingOverlay();

    // Check path
    rootBundle.load(url);

    // Add the pizza dough with the updated scale
    return ARKitGltfNode(
      // light: ARKitLight(
      //   type: ARKitLightType.ambient,
      //   color: Colors.white,
      //   intensity: 500,
      // ),
      name: 'dough',
      assetType: AssetType.flutterAsset,
      url: url,
      // scale: vector.Vector3.all(selectedScaleValue),
      scale: vector.Vector3.all(selected['scale']),
      position: position,
    );
  }

  ARKitGltfNode _loadSauce(vector.Vector3 position, String url) {
    // Check path
    rootBundle.load(url);

    // Add the pizza sauce
    return ARKitGltfNode(
      name: 'sauce',
      assetType: AssetType.flutterAsset,
      url: url,
      // scale: vector.Vector3.all(selectedScaleValue),
      scale: vector.Vector3.all(selected['scale']),
      position: vector.Vector3(
        position.x,
        position.y + 0.0001,
        position.z,
      ),
    );
  }

  ARKitGltfNode _loadCheese(vector.Vector3 position, String url) {
    // Check path
    rootBundle.load(url);

    // Add the pizza cheese
    return ARKitGltfNode(
      name: 'cheese',
      assetType: AssetType.flutterAsset,
      url: url,
      // scale: vector.Vector3.all(selectedScaleValue),
      scale: vector.Vector3.all(selected['scale']),
      position: vector.Vector3(
        position.x,
        position.y + 0.0002,
        position.z,
      ),
    );
  }

  ARKitGltfNode _loadTopping(vector.Vector3 position, String url, yPosition) {
    // Check path
    rootBundle.load(url);

    // Add the pizza topping
    return ARKitGltfNode(
      name: 'topping',
      assetType: AssetType.flutterAsset,
      url: url,
      // scale: vector.Vector3.all(selectedScaleValue),
      scale: vector.Vector3.all(selected['scale']),
      position: vector.Vector3(
        position.x,
        position.y + 0.0003 + yPosition + 0.0001,
        position.z,
      ),
    );
  }
}
