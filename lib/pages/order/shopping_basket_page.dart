import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:userapp/controllers/shopping_basket_controller.dart';
import 'package:userapp/utils/utility.dart';
import 'package:userapp/widgets/custom_close_button.dart';

class ShoppingBasketPage extends StatelessWidget {
  ShoppingBasketPage({Key? key}) : super(key: key);

  final shoppingBasketController = Get.find<ShoppingBasketController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShoppingBasketController>(builder: (_) {
      return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text(
                '장바구니',
                style: TextStyle(color: Colors.black),
              ),
              leading: CustomCloseButton(),
              backgroundColor: Colors.white,
              iconTheme: IconThemeData(color: Colors.black),
            ),
            body: _.isNotEmpty()
                ? CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Container(
                          padding: EdgeInsets.all(20),
                          child: Text(
                            _.store!.name,
                            style: TextStyle(fontSize: 18, letterSpacing: 1.4),
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                          child: Divider(thickness: 1, height: 1)),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return Column(
                              children: [
                                Container(
                                  child: index != 0
                                      ? Divider(
                                          thickness: 1,
                                          indent: 10,
                                          endIndent: 10,
                                          height: 14,
                                        )
                                      : null,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: 100,
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              _.orderList[index].menu.name,
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              '${Utility.intToStringWithFormat(_.orderList[index].menu.price * _.orderList[index].quantity)}원',
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: IconButton(
                                            onPressed: () {
                                              _.removeOrderAt(index);
                                            },
                                            icon: Icon(
                                              Icons.close,
                                              color: Colors.grey,
                                            ),
                                            padding: EdgeInsets.zero,
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.all(10),
                                          width: 118,
                                          height: 40,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              border: Border.all(
                                                  width: 1,
                                                  color: Color(0xffdddddd))),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  if (_.orderList[index]
                                                          .quantity >
                                                      1) {
                                                    _.setQuantity(index, false);
                                                  }
                                                },
                                                icon: Icon(
                                                  Icons.remove,
                                                  color: _.orderList[index]
                                                              .quantity ==
                                                          1
                                                      ? Colors.grey
                                                      : null,
                                                ),
                                                padding: EdgeInsets.zero,
                                              ),
                                              Text(
                                                '${_.orderList[index].quantity}',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  if (_.orderList[index]
                                                          .quantity <
                                                      99) {
                                                    _.setQuantity(index, true);
                                                  }
                                                },
                                                icon: Icon(
                                                  Icons.add,
                                                  color: _.orderList[index]
                                                              .quantity ==
                                                          99
                                                      ? Colors.grey
                                                      : null,
                                                ),
                                                padding: EdgeInsets.zero,
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                          childCount: _.orderList.length,
                        ),
                      ),
                      SliverToBoxAdapter(
                          child: Divider(thickness: 1, height: 11)),
                      SliverToBoxAdapter(
                        child: Container(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('총 주문금액'),
                                    Text('${Utility.intToStringWithFormat(_.getTotalAmount())}원')
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                : Center(
                    child: Text('터엉~', style: TextStyle(fontSize: 70),),
                  )),
      );
    });
  }
}
