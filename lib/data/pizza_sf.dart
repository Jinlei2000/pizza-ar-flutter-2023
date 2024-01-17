// pizza_sf.dart
import 'package:bitz/types/pizza_order.dart';
import 'package:bitz/utils/constants.dart';
import 'shared_prefs.dart';

class PizzaSF extends SharedPrefs {
  // PIZZA ORDER
  final String pizzaOrderKey = Pizza.ordersKey;

  Future<void> addPizzaOrder(List<PizzaOrder> pizzaOrders) async {
    final List<String> pizzaOrdersString =
        pizzaOrders.map((e) => e.toJson().toString()).toList();

    await setStringList(pizzaOrderKey, pizzaOrdersString);
  }

  Future<List<PizzaOrder>> getPizzaOrders() async {
    List<PizzaOrder> orders = [];

    // final List<String> pizzaOrdersString = await getStringList(pizzaOrderKey);



    return [];
  }
}
