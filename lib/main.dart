import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
//import 'services/api_service.dart';         // fetchAllLostItems
import 'services/firestore_service.dart';   // ✅ saveToFirestore
import 'screens/start.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'screens/find_found1.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();  // Flutter 비동기 초기화
  await Firebase.initializeApp();

  //final items = await fetchAllLostItems();   // API로 데이터 전체 가져오기
  //await saveToFirestore(items);              // Firestore에 저장

  await FlutterNaverMap().init( //네이버 지도 연동 초기화
      clientId: 'q1502jevt7',
      onAuthFailed: (ex) => switch (ex) {
        NQuotaExceededException(:final message) =>
            print("사용량 초과 (message: $message)"),
        NUnauthorizedClientException() ||
        NClientUnspecifiedException() ||
        NAnotherAuthFailedException() =>
            print("인증 실패: $ex"),
      });

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
      home: FindFound1(),
    );
  }
}
