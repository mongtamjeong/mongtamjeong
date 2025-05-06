import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screens/start.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'screens/myPage.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();        // Flutter 비동기 초기화
  await Firebase.initializeApp();
  // ✅ 네이버 지도 초기화 (Client ID 입력 필요)
  await NaverMapSdk.instance.initialize(
    clientId: 'zkpjnvruhk',
  );
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
      home: Mypage(),
    );
  }
}
