import 'package:flutter/material.dart';

class MyPage extends StatelessWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff555555),
      ),
      body: Center(
        child: Text('마이페이지', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),),
      ),
    );
  }
}
