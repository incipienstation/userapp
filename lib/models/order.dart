import 'menu.dart';
import 'store.dart';

class Order {
  final Store store;
  final Menu menu;
  int quantity;

  Order({
    required this.store,
    required this.menu,
    required this.quantity,
  });
}
