import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:userapp/controllers/root_controller.dart';
import 'package:userapp/controllers/store_controller.dart';
import 'package:userapp/models/menu.dart';
import 'package:userapp/models/store.dart';
import 'package:userapp/utils/utility.dart';
import 'package:userapp/widgets/custom_back_button.dart';
import 'package:userapp/widgets/shopping_basket_button.dart';

class StorePage extends StatelessWidget {
  StorePage({Key? key}) : super(key: key);
  final Store store = Get.arguments;

  final storeController = Get.put(StoreController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: ShoppingBasketButton(),
        body: Center(
          child:
              FutureBuilder<List<QueryDocumentSnapshot<Map<String, dynamic>>>?>(
            future: storeController.fetchMenus(store),
            builder: (c, s) {
              if (s.hasData) {
                List<Menu> menuList = [];
                for (var doc in s.data!) {
                  menuList.add(Menu.fromDoc(doc));
                }
                return MenuListView(
                  menuList: menuList,
                  store: store,
                );
              } else if (s.hasError) {
                Get.defaultDialog(
                  title: '연결 오류',
                  middleText: '서버에서 데이터를 받아오지 못함',
                  barrierDismissible: true,
                );
                return Container();
              } else {
                return Scaffold(
                  appBar: AppBar(
                    title: Text(
                      store.name,
                      style: TextStyle(color: Colors.black),
                    ),
                    backgroundColor: Colors.white,
                    leading: CustomBackButton(
                      color: Colors.black,
                    ),
                  ),
                  body: Center(
                    child: SizedBox(
                      width: 45,
                      height: 45,
                      child: CircularProgressIndicator(),
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class MenuListView extends StatelessWidget {
  MenuListView({
    Key? key,
    required this.menuList,
    required this.store,
  }) : super(key: key);

  final List<Menu> menuList;
  final Store store;

  final controller = Get.find<StoreController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StoreController>(
      builder: (_) {
        return CustomScrollView(
          controller: _.scrollController,
          slivers: [
            SliverAppBar(
              title: _.onTriggerOffset
                  ? Text(
                      store.name,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    )
                  : null,
              centerTitle: true,
              leading: CustomBackButton(
                color: _.onTriggerOffset ? Colors.black : Colors.white,
              ),
              actions: [
                SizedBox(
                  child: _.onTriggerOffset ? FavoriteButton() : null,
                ),
              ],
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              expandedHeight: _.triggerOffset,
              pinned: true,
              elevation: 0,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  color: Colors.redAccent,
                  child: Center(child: Text('대표사진 준비중')),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            child: Text(
                              store.name,
                              style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 25,
                                  letterSpacing: 1.3),
                            ),
                          ),
                          FavoriteButton(),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (c, i) {
                  return Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 2, color: Color(0xffdddddd)))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Text(
                            menuList[i].name,
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Text(
                            '${Utility.intToStringWithFormat(menuList[i].price)}원',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
                childCount: menuList.length,
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                height: 1000,
              ),
            ),
          ],
        );
      },
    );
  }
}

class FavoriteButton extends StatelessWidget {
  FavoriteButton({
    Key? key,
  }) : super(key: key);

  final rootController = Get.find<RootController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RootController>(
      builder: (_) {
        return IconButton(
          onPressed: () {
            if (!_.isActive) {
              if (!_.isPushed) {
                _showToast(context, _.isPushed);
                _.setIsPushed();
              } else {
                _showToast(context, _.isPushed);
                _.setIsPushed();
              }
            }
          },
          icon: Icon(
            !_.isPushed ? Icons.favorite_border : Icons.favorite,
            color: Colors.black,
          ),
        );
      },
    );
  }

  void _showToast(BuildContext context, bool isPushed) async {
    if (!rootController.isActive) {
      rootController.setIsActive();
      OverlayEntry entry = OverlayEntry(
        builder: (context) => Toast(),
      );
      Overlay.of(context)!.insert(entry);
      await Future.delayed(Duration(milliseconds: 300));
      rootController.setVisible();
      await Future.delayed(Duration(seconds: 2));
      rootController.setVisible();
      await Future.delayed(Duration(milliseconds: 300));
      entry.remove();
      rootController.setIsActive();
    }
  }
}

class Toast extends StatelessWidget {
  Toast({Key? key}) : super(key: key);

  final rootController = Get.find<RootController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Opacity(
          opacity: 0.7,
          child: Padding(
            padding: EdgeInsets.only(bottom: 120),
            child: Material(
              color: Colors.transparent,
              child: GetBuilder<RootController>(
                builder: (_) {
                  return AnimatedOpacity(
                    opacity: _.visible ? 1.0 : 0.0,
                    duration: Duration(milliseconds: 300),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        _.isPushed ? '찜 목록에 추가되었습니다.' : '찜 목록에서 삭제되었습니다.',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.normal
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
