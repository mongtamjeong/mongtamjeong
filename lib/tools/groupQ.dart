import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart'; // MaterialApp이 필요 없는 경우
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';

Future<void> groupByKind() async {
  final firestore = FirebaseFirestore.instance;

  try {
    final snapshot = await firestore.collection('lostItems').get();

    final kindCount = <String, int>{};

    for (final doc in snapshot.docs) {
      final kind = doc.data()['kind']?.toString().trim();
      if (kind == null || kind.isEmpty) continue;

      kindCount.update(kind, (value) => value + 1, ifAbsent: () => 1);
    }

    print('🎯 kind별 분류 결과 (${kindCount.length}종류):');
    for (final entry in kindCount.entries) {
      print('- ${entry.key}: ${entry.value}개');
    }
  } catch (e) {
    print('❌ Firestore 조회 실패: $e');
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // ✅ 반드시 먼저 호출

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await groupByKind();
}
