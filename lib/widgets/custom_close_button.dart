import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomCloseButton extends StatelessWidget {
  /// Creates a Material Design close button.
  const CustomCloseButton({ Key? key, this.color, this.onPressed }) : super(key: key);

  /// The color to use for the icon.
  ///
  /// Defaults to the [IconThemeData.color] specified in the ambient [IconTheme],
  /// which usually matches the ambient [Theme]'s [ThemeData.iconTheme].
  final Color? color;

  /// An override callback to perform instead of the default behavior which is
  /// to pop the [Navigator].
  ///
  /// It can, for instance, be used to pop the platform's navigation stack
  /// via [SystemNavigator] instead of Flutter's [Navigator] in add-to-app
  /// situations.
  ///
  /// Defaults to null.
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.close),
      color: color,
      onPressed: () {
        if (onPressed != null) {
          onPressed!();
        } else {
          Get.back();
        }
      },
    );
  }
}
