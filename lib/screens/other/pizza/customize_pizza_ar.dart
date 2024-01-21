import 'package:bitz/components/bottom_actions.dart';
import 'package:bitz/components/custom_app_bar.dart';
import 'package:bitz/components/pizza_Item_list.dart';
import 'package:bitz/providers/cart_model.dart';
import 'package:bitz/screens/other/pizza/overview_order.dart';
import 'package:bitz/types/order_item.dart';
import 'package:bitz/utils/colors.dart';
import 'package:bitz/utils/constants.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/services.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class CustomizePizzaArPage extends StatefulWidget {
  const CustomizePizzaArPage({Key? key}) : super(key: key);

  @override
  State<CustomizePizzaArPage> createState() => _CustomizePizzaArPageState();
}

class _CustomizePizzaArPageState extends State<CustomizePizzaArPage> {
  Map<String, dynamic> selected = {
    'size': Pizza.sizes[0],
    'sauce': null,
    'cheese': null,
    'toppings': null,
    'scale': Pizza.sizes[0]['scale'],
  };
  Map<String, double> currentPrices = {
    'size': Pizza.sizes[0]['price'].toDouble(),
    'sauce': 0,
    'cheese': 0,
    'toppings': 0
  };
  int pageIndex = 0;
  int _tabTextIndexSelected = 0;
  bool toggleToppings = false;
  final List<String> _toggleList = ["Vegetable", "Meat"];
  bool showPopup = true;

  // Pages
  final List<Map<String, dynamic>> pages = [
    {'index': 0, 'title': 'Size'},
    {'index': 1, 'title': 'Sauce'},
    {'index': 2, 'title': 'Cheese'},
    {'index': 3, 'title': 'Toppings'},
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
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 16, right: 16, top: 24),
                      child: BottomActions(
                        price:
                            '€ ${currentPrices.values.reduce((a, b) => a + b)}',
                        nextButtonTitle: 'Next',
                        nextButtonOnPressed: () {
                          if (pageIndex == 3) {
                            // Add pizza to the order list (Provider)
                            final cartModel =
                                Provider.of<CartModel>(context, listen: false);

                            cartModel.addPizza(OrderItem(
                              id: cartModel.count + 1,
                              size: selected['size'],
                              sauce: selected['sauce'],
                              cheese: selected['cheese'],
                              toppings: selected['toppings'],
                              quantity: 1,
                              price:
                                  currentPrices.values.reduce((a, b) => a + b),
                              totalPrice:
                                  currentPrices.values.reduce((a, b) => a + b),
                            ));

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
                    )
                  ],
                ),
              ),
            ),
          ),
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
      // remove all pizza in the order list (Provider)
      final cartModel = Provider.of<CartModel>(context, listen: false);
      cartModel.removeAllPizzas();

      // Go back to the previous screen
      Navigator.pop(context);
    }
  }

  // Select Pizza Size
  Widget _buildPizzaSize() {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 16),
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: Pizza.sizes.map((size) {
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
                color: isSelected
                    ? MyColors.pizzaItemSelected
                    : MyColors.pizzaItem,
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
      ),
    );
  }

  // Select Pizza Sauces
  Widget _buildPizzaSauces() {
    return PizzaItemList(
        items: Pizza.sauces,
        isItemSelected: (item) => selected['sauce']?['name'] == item['name'],
        updateFunction: _updateSauce);
  }

  // Select Pizza Cheeses
  Widget _buildPizzaCheeses() {
    return PizzaItemList(
        items: Pizza.cheeses,
        isItemSelected: (item) => selected['cheese']?['name'] == item['name'],
        updateFunction: _updateCheese);
  }

  // Select Pizza Toppings
  Widget _buildPizzaToppings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Toggle
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: FlutterToggleTab(
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
        ),

        // Toppings
        const SizedBox(height: 16),
        if (_tabTextIndexSelected == 0)
          PizzaItemList(
            items: Pizza.vegetable,
            isItemSelected: (item) =>
                selected['toppings'] != null &&
                selected['toppings']!
                    .any((element) => element['name'] == item['name']),
            updateFunction: (topping) => _updateToppings(
                topping,
                selected['toppings'] != null &&
                    selected['toppings']!
                        .any((element) => element['name'] == topping['name'])),
          ),
        if (_tabTextIndexSelected == 1)
          PizzaItemList(
            items: Pizza.meat,
            isItemSelected: (item) =>
                selected['toppings'] != null &&
                selected['toppings']!
                    .any((element) => element['name'] == item['name']),
            updateFunction: (topping) => _updateToppings(
                topping,
                selected['toppings'] != null &&
                    selected['toppings']!
                        .any((element) => element['name'] == topping['name'])),
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
    if (doughNode != null) {
      doughNode!.scale = vector.Vector3.all(selected['scale']);
    }
  }

  // Update Sauce
  void _updateSauce(item) {
    setState(() {
      // Update selected sauce
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
        selected['toppings'].add(item);
        currentPrices['toppings'] = currentPrices['toppings']! + item['price'];
      });
    } else {
      setState(() {
        selected['toppings'].remove(item);
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
        final item = [...Pizza.vegetable, ...Pizza.meat].firstWhere(
          (topping) => topping['name'] == selected['toppings']![i]['name'],
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
        final item = [...Pizza.vegetable, ...Pizza.meat].firstWhere(
          (topping) => topping['name'] == selected['toppings']![i]['name'],
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

    // add light
    arkitController.add(ARKitNode(
      light: ARKitLight(
        type: ARKitLightType.ambient,
        color: Colors.white,
        intensity: 750,
      ),
    ));
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
    void addNode(dynamic node, String parentNodeName) {
      arkitController.add(node, parentNodeName: parentNodeName);
    }

    void removeNode(String nodeName) {
      arkitController.remove(nodeName);
    }

    void addDoughNode(vector.Vector3 position, String parentNodeName) {
      removeNode(doughNode?.name ?? '');
      doughNode = _loadDough(position, 'assets/models/dough.glb');
      addNode(doughNode!, parentNodeName);
    }

    void addSauceNode(
        vector.Vector3 position, String sauceName, String parentNodeName) {
      removeNode(sauceNode?.name ?? '');
      if (selected['sauce'] != null) {
        sauceNode = _loadSauce(
            position,
            Pizza.sauces.firstWhere(
                (sauce) => sauce['name'] == selected['sauce']['name'])['path']);
        addNode(sauceNode!, parentNodeName);
      }
    }

    void addCheeseNode(
        vector.Vector3 position, String cheeseName, String parentNodeName) {
      removeNode(cheeseNode?.name ?? '');
      if (selected['cheese'] != null) {
        cheeseNode = _loadCheese(
            position,
            Pizza.cheeses.firstWhere((cheese) =>
                cheese['name'] == selected['cheese']['name'])['path']);
        addNode(cheeseNode!, parentNodeName);
      }
    }

    void addToppingsNodes(vector.Vector3 position, String parentNodeName) {
      if (toppingsNodes.isNotEmpty) {
        for (var topping in toppingsNodes) {
          removeNode(topping.name);
        }
        toppingsNodes.clear();
      }

      if (selected['toppings'] != null) {
        for (var i = 0; i < selected['toppings']!.length; i++) {
          final item = [...Pizza.vegetable, ...Pizza.meat].firstWhere(
            (topping) => topping['name'] == selected['toppings']![i]['name'],
          );
          toppingsNodes.add(_loadTopping(
            position,
            item['path'],
            i * 0.0001,
          ));
          addNode(toppingsNodes[i], parentNodeName);
        }
      }
    }

    // Update nodes
    void updateNodes(vector.Vector3 position, String parentNodeName) {
      addDoughNode(position, parentNodeName);

      if (pageIndex > 0 && selected['sauce'] != null) {
        addSauceNode(position, selected['sauce']['name'], parentNodeName);
      }
      if (pageIndex > 1 && selected['cheese'] != null) {
        addCheeseNode(position, selected['cheese']['name'], parentNodeName);
      }
      if (pageIndex > 2 && selected['toppings'] != null) {
        addToppingsNodes(position, parentNodeName);
      }
    }

    if (!isTapping) {
      // Tapping
      updateNodes(current['anchor'].center, current['anchor'].nodeName);
    } else {
      // Plane detected
      updateNodes(current['tapPosition'], '');
    }
  }

  ARKitGltfNode _loadDough(vector.Vector3 position, String url) {
    // remove coach overlay
    arkitController.removeCoachingOverlay();

    // Check path
    rootBundle.load(url);

    // Add the pizza dough with the updated scale
    return ARKitGltfNode(
      name: 'dough',
      assetType: AssetType.flutterAsset,
      url: url,
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
      scale: vector.Vector3.all(selected['scale']),
      position: vector.Vector3(
        position.x,
        position.y + 0.0003 + yPosition + 0.0001,
        position.z,
      ),
    );
  }
}
