import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:userapp/controllers/menu_controller.dart';
import 'package:userapp/controllers/shopping_basket_controller.dart';
import 'package:userapp/models/menu.dart';
import 'package:userapp/models/order.dart';
import 'package:userapp/models/store.dart';
import 'package:userapp/utils/utility.dart';
import 'package:userapp/widgets/custom_close_button.dart';
import 'package:userapp/widgets/custom_elevated_button.dart';

class MenuPage extends StatelessWidget {
  final Store store;
  final Menu menu;

  MenuPage({
    Key? key,
    required this.store,
    required this.menu,
  }) : super(key: key);

  final menuController = Get.put(MenuController());
  final shoppingBasketController = Get.find<ShoppingBasketController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MenuController>(
      builder: (_) {
        return WillPopScope(
          onWillPop: () {
            Get.delete<MenuController>();
            return Future.value(true);
          },
          child: Scaffold(
            appBar: AppBar(
              leading: CustomCloseButton(
                color: Colors.black,
                onPressed: () {
                  Get.delete<MenuController>();
                  Get.back();
                },
              ),
              backgroundColor: Colors.white,
              title: Text(
                menu.name,
                style: TextStyle(color: Colors.black),
              ),
            ),
            body: CustomScrollView(
              controller: ModalScrollController.of(context),
              slivers: [
                SliverToBoxAdapter(
                  child: Container(
                    height: 80,
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 2, color: Color(0xffdddddd)))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.all(20),
                          child: Text(
                            '가격',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: Text(
                            '${Utility.intToStringWithFormat(menu.price)}원',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  width: 2, color: Color(0xffdddddd)))),
                      child: Text(
                        '옵션${index + 1}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    childCount: 8,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    height: 100,
                    // decoration: BoxDecoration(
                    //   border: Border(
                    //     bottom: BorderSide(width: 2, color: Color(0xffdddddd)),
                    //   ),
                    // ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: Text(
                            '수량',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(20),
                          width: 150,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                  width: 1, color: Color(0xffdddddd))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () {
                                  if (_.quantity > 1) {
                                    _.setQuantity(false);
                                  }
                                },
                                icon: Icon(
                                  Icons.remove,
                                  color: _.quantity == 1 ? Colors.grey : null,
                                ),
                                padding: EdgeInsets.zero,
                              ),
                              Text(
                                '${_.quantity}개',
                                style: TextStyle(letterSpacing: 1.3),
                              ),
                              IconButton(
                                onPressed: () {
                                  if (_.quantity < 10) {
                                    _.setQuantity(true);
                                  }
                                },
                                icon: Icon(
                                  Icons.add,
                                  color: _.quantity == 10 ? Colors.grey : null,
                                ),
                                padding: EdgeInsets.zero,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            bottomNavigationBar: Container(
              height: 110,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(width: 2, color: Color(0xffdddddd)))),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(
                      '최소주문금액 ${Utility.intToStringWithFormat(store.minDeliveryAmount)}원',
                      style: TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 14),
                    ),
                  ),
                  CustomElevatedButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${Utility.intToStringWithFormat(menu.price * _.quantity)}원',
                          style: TextStyle(color: Colors.transparent),
                        ),
                        Text(
                          '${_.quantity}개 담기',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.3,
                          ),
                        ),
                        Text(
                          '${Utility.intToStringWithFormat(menu.price * _.quantity)}원',
                        ),
                      ],
                    ),
                    pageRoute: () {
                      if (shoppingBasketController.isNotEmpty() && shoppingBasketController.store?.id != store.id) {
                        Get.defaultDialog(
                          titleStyle: TextStyle(
                            fontSize: 0,
                          ),
                          titlePadding: EdgeInsets.all(2),
                          content: Container(
                            padding: EdgeInsets.fromLTRB(30, 20, 30, 0),
                            child: Column(
                              children: [
                                Text('새로운 가게에서 주문하시겠어요?', style: TextStyle(fontWeight: FontWeight.bold),),
                                SizedBox(height: 10,),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text('장바구니에는 같은 가게의 메뉴만 담을 수 있습니다.', style: TextStyle(fontSize: 15),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        child: Text('아니요', style: TextStyle(fontWeight: FontWeight.bold)),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          shoppingBasketController.setStore(store);
                                          shoppingBasketController.orderList.clear();
                                          shoppingBasketController.addOrder(Order(store: store, menu: menu, quantity: _.quantity));
                                          Get.back();
                                          Get.back();
                                        },
                                        child: Text('네', style: TextStyle(fontWeight: FontWeight.bold)),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      } else {
                        if (!shoppingBasketController.isNotEmpty()) {
                          shoppingBasketController.setStore(store);
                        }

                        bool menuExists = false;
                        if (shoppingBasketController.orderList.isNotEmpty) {
                          for (Order order in shoppingBasketController.orderList) {
                            if (menu.id == order.menu.id) {
                              menuExists = true;
                              order.quantity += _.quantity;
                              break;
                            }
                          }
                        }
                        if (!menuExists) {
                          shoppingBasketController.addOrder(Order(store: store, menu: menu, quantity: _.quantity));
                        }

                        Get.delete<MenuController>();
                        Get.back();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
