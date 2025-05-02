import 'package:flutter/material.dart';

class Wishlist extends StatelessWidget {
  const Wishlist({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('찜 목록',
        style: TextStyle(fontWeight: FontWeight.bold),),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Divider(
            height: 1,
            thickness: 1,
            color: Color(0xFFDDDDDD), // 연한 회색
          ),
        ),
      ),
    );
  }
}
