// pizza_item_list.dart
import 'package:bitz/components/pizza_item.dart';
import 'package:flutter/material.dart';

class PizzaItemList extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  final Function isItemSelected;
  final Function updateFunction;

  const PizzaItemList({
    Key? key,
    required this.items,
    required this.isItemSelected,
    required this.updateFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 16),
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: items.map((item) {
          bool isSelected = isItemSelected(item);

          return GestureDetector(
            onTap: () {
              updateFunction(item);
            },
            child: PizzaItem(
              isSelected: isSelected,
              imagePath: item['imagePath']?.toString() ?? '',
              name: item['name']?.toString() ?? '',
            ),
          );
        }).toList(),
      ),
    );
  }
}
