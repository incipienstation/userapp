import 'package:flutter/material.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepPurpleAccent,
      child: Center(
        child: Text('주문내역', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),),
      ),
    );
  }
}
