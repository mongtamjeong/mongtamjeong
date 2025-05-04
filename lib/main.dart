import 'package:flutter/material.dart';
import 'screens/start.dart';
import 'screens/item_information_user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '몽탐정',
      debugShowCheckedModeBanner: false,
      home: ItemInformationUser(),
    );
  }
}
