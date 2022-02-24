import 'package:flutter/material.dart';
import 'package:userapp/widgets/custom_back_button.dart';

class CustomProgressIndicator extends StatefulWidget {
  const CustomProgressIndicator({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomProgressIndicator> createState() =>
      _CustomProgressIndicatorState();
}

class _CustomProgressIndicatorState extends State<CustomProgressIndicator> {
  bool timeOver = false;

  _setTimer() async {
    await Future.delayed(Duration(seconds: 5));
    if (mounted) {
      setState(() {
        timeOver = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _setTimer();
  }

  @override
  Widget build(BuildContext context) {
    return !timeOver
        ? SizedBox(
            width: 45,
            height: 45,
            child: CircularProgressIndicator(),
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('뒤로가기'),
              CustomBackButton(
                color: Colors.black,
              ),
            ],
          );
  }
}
