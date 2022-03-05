import 'package:get/get.dart';

import '../models/order.dart';
import '../models/store.dart';

class ShoppingBasketController extends GetxController {
  Store? store;
  List<Order> orderList = [];

  bool isNotEmpty() {
    return store != null;
  }

  addOrder(Order order) {
    orderList.add(order);
  }

  setStore(Store store) {
    this.store = store;
    update();
  }

  removeStore() {
    store = null;
    update();
  }

  removeOrderAt(int index) {
    orderList.removeAt(index);
    if (orderList.isEmpty) {
      store = null;
    }
    update();
  }

  setQuantity(int index, bool plus) {
    if (plus) {
      orderList[index].quantity++;
    } else {
      orderList[index].quantity--;
    }
    update();
  }

  int getTotalAmount() {
    int totalAmount = 0;

    for (Order order in orderList) {
      totalAmount += order.menu.price * order.quantity;
    }

    return totalAmount;
  }
}