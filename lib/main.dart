import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:userapp/controller/root_controller.dart';

import 'firebase_options.dart';
import 'package:get/get.dart';
import './page/all.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    GetMaterialApp(
      initialRoute: '/',
      initialBinding: BindingsBuilder((){
        Get.put(RootController());
      }),
      getPages: [
        GetPage(name: '/', page: () => const Home()),
        GetPage(name: '/stores', page: () => StoreListNavigation()),
        GetPage(name: '/mypage', page: () => MyPage()),
        GetPage(name: '/order', page: () => OrderPage()),
      ],
    )
  );
}