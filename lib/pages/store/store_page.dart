import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:userapp/controllers/store_controller.dart';
import 'package:userapp/controllers/toast_controller.dart';
import 'package:userapp/models/menu.dart';
import 'package:userapp/models/store.dart';
import 'package:userapp/pages/auth/login_page.dart';
import 'package:userapp/pages/menu/menu_page.dart';
import 'package:userapp/utils/utility.dart';
import 'package:userapp/widgets/custom_back_button.dart';
import 'package:userapp/widgets/custom_progress_indicator.dart';
import 'package:userapp/widgets/shopping_basket_button.dart';
import 'package:userapp/widgets/toast_message.dart';

final auth = FirebaseAuth.instance;

class StorePage extends StatelessWidget {
  StorePage({Key? key}) : super(key: key);
  final String storeDocId = Get.arguments;

  @override
  Widget build(BuildContext context) {
    final storeController = Get.put(StoreController(storeDocId: storeDocId));

    return SafeArea(
      child: Scaffold(
        floatingActionButton: ShoppingBasketButton(display: true),
        body: Center(
          child: FutureBuilder(
            future: Future.wait([
              storeController.fetchStore(storeDocId),
              storeController.fetchMenus(storeDocId),
            ]),
            builder: (c, AsyncSnapshot<List<bool>> snapshot) {
              if (snapshot.hasData && snapshot.data![1]) {
                print('DB upload success');
                return MenuListView(
                  menuList: storeController.menuList,
                  store: storeController.store,
                );
              } else {
                print('DB upload fail');
                return CustomProgressIndicator();
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
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              expandedHeight: _.triggerOffset,
              pinned: true,
              elevation: 0,
              actions: _.onTriggerOffset
                  ? [
                      FavoriteButton(
                        store: store,
                        omitNumber: true,
                      ),
                    ]
                  : null,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  color: Colors.redAccent,
                  child: Center(child: Text('대표사진 준비중')),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(width: 2, color: Color(0xffdddddd))),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              store.name,
                              style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 25,
                                  letterSpacing: 1.3),
                            ),
                          ),
                          FavoriteButton(
                            store: store,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          _buildMetaDataTile('최소주문금액',
                              '${Utility.intToStringWithFormat(store.minDeliveryAmount)}원'),
                          _buildMetaDataTile('배달요금', '미정'),
                          _buildMetaDataTile('가게위치', store.address),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (c, i) {
                  return InkWell(
                    onTap: () => showMaterialModalBottomSheet(
                      closeProgressThreshold: 0.3,
                      context: context,
                      builder: (context) => MenuPage(
                        store: store,
                        menu: menuList[i],
                      ),
                    ),
                    child: Container(
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

  Padding _buildMetaDataTile(String text1, String text2) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            width: 100,
            child: Text(
              text1,
              style: TextStyle(
                  color: Colors.black54, fontWeight: FontWeight.normal),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              text2,
              style: TextStyle(fontWeight: FontWeight.normal),
            ),
          )
        ],
      ),
    );
  }
}

class FavoriteButton extends StatelessWidget {
  final Store store;
  final bool omitNumber;

  FavoriteButton({
    Key? key,
    required this.store,
    this.omitNumber = false,
  }) : super(key: key);

  final storeController = Get.find<StoreController>();
  final toastController = Get.find<ToastController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StoreController>(
      builder: (_) {
        return GestureDetector(
          onTap: () async {
            if (!toastController.isActive) {
              if (auth.currentUser == null) {
                await Toast.showToast(context, message: '로그인 후 사용 가능한 기능입니다.');
                Get.defaultDialog(
                  titleStyle: TextStyle(
                    fontSize: 0,
                  ),
                  titlePadding: EdgeInsets.all(2),
                  middleText: '로그인 하시겠습니까?',
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        Get.off(() => LoginPage());
                      },
                      child: Text('확인'),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text('취소'),
                    ),
                  ],
                );
              } else {
                if (!_.isFavorite) {
                  _.setFavorite();
                  Toast.showToast(context,
                      message:
                          !_.isFavorite ? '찜 목록에 추가되었습니다.' : '찜 목록에서 삭제되었습니다.');
                  _.setIsFavorite();
                } else {
                  _.setFavorite();
                  Toast.showToast(context,
                      message:
                          !_.isFavorite ? '찜 목록에 추가되었습니다.' : '찜 목록에서 삭제되었습니다.');
                  _.setIsFavorite();
                }
              }
            }
          },
          behavior: HitTestBehavior.translucent,
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: omitNumber
                  ? [
                      Icon(
                        !_.isFavorite ? Icons.favorite_border : Icons.favorite,
                        color: !_.isFavorite ? Colors.black : Colors.redAccent,
                      ),
                    ]
                  : [
                      Icon(
                        !_.isFavorite ? Icons.favorite_border : Icons.favorite,
                        color: !_.isFavorite ? Colors.black : Colors.redAccent,
                      ),
                      Text('${_.favoriteUidList.length}'),
                    ],
            ),
          ),
        );
      },
    );
  }
}
