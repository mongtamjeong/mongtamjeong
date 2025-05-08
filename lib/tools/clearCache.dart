import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';
import '../services/Post_service.dart'; // 실제 경로로 변경

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final service = PostService();

  print('🧹 캐시 삭제 시작...');
  await service.clearLostItemsCache();
  print('✅ 캐시 삭제 완료');

  print('🔁 캐시 초기화 후 데이터 재로딩...');
  final refreshedItems = await service.getOpenApiLostItems(); // ✅ 기존 함수 재활용
  print('📦 새로 불러온 항목 수: ${refreshedItems.length}');

  // 콘솔에 항목 요약 출력
  for (var item in refreshedItems.take(3)) {
    print('▶ ${item['name']} / ${item['company']} / ${item['detail'] ?? '내용없음'}');
  }

  print('🎉 작업 완료');
}
