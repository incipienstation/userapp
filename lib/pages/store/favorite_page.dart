import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:userapp/controllers/root_controller.dart';
import 'package:userapp/controllers/shopping_basket_controller.dart';
import 'package:userapp/widgets/bottom_navigation_bar.dart';
import 'package:get/get.dart';
import 'package:userapp/widgets/custom_list_tile.dart';
import 'package:userapp/widgets/custom_progress_indicator.dart';
import 'package:userapp/widgets/shopping_basket_button.dart';
import '../home.dart';
import 'package:userapp/models/user.dart' as user_class;

class FavoritePage extends StatelessWidget {
  FavoritePage({Key? key}) : super(key: key);

  final rootController = Get.find<RootController>();
  final shoppingBasketController = Get.find<ShoppingBasketController>();

  @override
  Widget build(BuildContext context) {
    rootController.fetchUser();

    return WillPopScope(
      onWillPop: () {
        Get.off(() => Home(), transition: Transition.noTransition);
        return Future(() => false);
      },
      child: SafeArea(
        child: Scaffold(
          floatingActionButton: GetBuilder<ShoppingBasketController>(
            builder: (_) => ShoppingBasketButton(display: _.isNotEmpty()),
          ),
          appBar: AppBar(
            title: Text('찜'),
          ),
          body: GetBuilder<RootController>(
            builder: (_) {
              return rootController.userExists
                  ? StreamBuilder<QuerySnapshot>(
                stream: rootController.userStream,
                builder: (c, s) {
                  if (s.hasData) {
                    user_class.User user = user_class.User.fromDoc(
                        s.data!.docs[0]
                        as DocumentSnapshot<Map<String, dynamic>>);
                    return CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: Container(
                            padding: EdgeInsets.all(4),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text('찜한 가게', style: TextStyle(fontSize: 20),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: Text('${user.favoriteStoreIdList.length}개', style: TextStyle(color: Colors.grey),),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                                (c, i) {
                              var stores = rootController.stores
                                  .where((element) => user
                                  .favoriteStoreIdList
                                  .contains(element.reference.id)
                                  ? true
                                  : false)
                                  .toList();
                              return CustomListTile(
                                  listViewIndex: i, stores: stores);
                            },
                            childCount: s.data!
                                .docs[0]['favoriteStoreIdList'].length,
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Center(child: CustomProgressIndicator());
                  }
                },
              )
                  : Center(
                child: Text('로그인 필요',
                    style: TextStyle(
                        fontSize: 40, fontWeight: FontWeight.bold)),
              );
            },
          ),
          bottomNavigationBar: CustomBottomNavigationBar(
            currentIndex: 3,
          ),
        ),
      ),
    );
  }
}
