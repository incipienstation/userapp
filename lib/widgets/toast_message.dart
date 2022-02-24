import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:userapp/controllers/toast_controller.dart';

class Toast extends StatelessWidget {
  final String message;

  Toast({
    Key? key,
    required this.message,
  }) : super(key: key);

  final controller = Get.find<ToastController>();

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
              child: GetBuilder<ToastController>(
                builder: (_) {
                  return AnimatedOpacity(
                    opacity: _.visible ? 1.0 : 0.0,
                    duration: Duration(milliseconds: 300),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 20,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        message,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
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

  static Future<void> showToast(BuildContext context, {required String message}) async {
    final _ = Get.find<ToastController>();

    if (!_.isActive) {
      _.setIsActive();
      OverlayEntry entry = OverlayEntry(
        builder: (context) => Toast(message: message),
      );
      Overlay.of(context)!.insert(entry);
      await Future.delayed(Duration(milliseconds: 300));
      _.setVisible();
      await Future.delayed(Duration(seconds: 2));
      _.setVisible();
      await Future.delayed(Duration(milliseconds: 300));
      entry.remove();
      _.setIsActive();
    }
  }
}
