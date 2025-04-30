import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('홈 화면')),
      body: Center(child: Text('분실물 리스트가 여기에 나타납니다')),
    );
  }
}
