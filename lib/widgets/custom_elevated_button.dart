import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final Widget child;
  final pageRoute;

  const CustomElevatedButton({Key? key, required this.child, this.pageRoute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.redAccent,
              minimumSize: Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)
              ),
          ),
          onPressed: pageRoute,
          child: child,
      ),
    );
  }
}