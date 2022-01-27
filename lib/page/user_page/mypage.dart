import 'package:flutter/material.dart';

class MyPage extends StatelessWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.greenAccent,
      child: Center(
        child: Text('마이페이지', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),),
      ),
    );
  }
}
