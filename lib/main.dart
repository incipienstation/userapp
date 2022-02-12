import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';

import 'package:userapp/controller/root_controller.dart';

import 'package:userapp/page/auth/join_page.dart';
import 'page/home.dart';

import './utils/theme.dart' as style;


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    GetMaterialApp(
      theme: style.theme,
      home: JoinPage(),
      initialBinding: BindingsBuilder((){
        Get.put(RootController());
      }),
    )
  );
}