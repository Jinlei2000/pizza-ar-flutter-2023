// constants.dart
import 'package:bitz/utils/colors.dart';

class Pizza {
  // Pizza Sizes
  static const List<Map<String, dynamic>> sizes = [
    {'size': 'S', 'price': 5, 'scale': 0.4},
    {'size': 'M', 'price': 10, 'scale': 0.6},
    {'size': 'L', 'price': 15, 'scale': 0.8},
  ];

  // Pizza Sauces
  static const List<Map<String, dynamic>> sauces = [
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
  static const List<Map<String, dynamic>> cheeses = [
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

  // Pizza Toppings Vegetables
  static const List<Map<String, dynamic>> vegetable = [
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

  // Pizza Toppings Meat
  static const List<Map<String, dynamic>> meat = [
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
}
