import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:userapp/controllers/shopping_basket_controller.dart';
import 'package:userapp/controllers/toast_controller.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';

import './utils/theme.dart' as style;

import 'package:userapp/controllers/root_controller.dart';
import 'pages/home.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    GetMaterialApp(
      theme: style.theme,
      home: Home(),
      initialBinding: BindingsBuilder((){
        Get.put(RootController());
        Get.put(ShoppingBasketController());
        Get.lazyPut(() => ToastController(), fenix: true);
      }),
    )
  );
}