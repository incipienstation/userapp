import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:userapp/controllers/root_controller.dart';
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
          floatingActionButton: ShoppingBasketButton(),
          appBar: AppBar(
            backgroundColor: Color(0xff555555),
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
                          return ListView.builder(
                              itemCount:
                                  s.data!.docs[0]['favoriteStoreIdList'].length,
                              itemBuilder: (_, j) {
                                var stores = rootController.stores
                                    .where((element) => user.favoriteStoreIdList
                                            .contains(element.reference.id)
                                        ? true
                                        : false)
                                    .toList();
                                return CustomListTile(
                                    listViewIndex: j, stores: stores);
                              });
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
