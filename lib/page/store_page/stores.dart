import 'package:flutter/material.dart';

class StoreListNavigation extends StatelessWidget {
  StoreListNavigation({Key? key}) : super(key: key);

  final categoryNum = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('카테고리'),),
      body: PageView.builder(itemBuilder: (_, i){
        return Container(
          color: Colors.green,
          child: Center(
            child: Text('${i + 1}번째 페이지', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),),
          ),
        );
      }, itemCount: categoryNum,),
    );
  }
}
