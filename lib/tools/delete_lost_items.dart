import 'package:flutter/widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../firebase_options.dart';

Future<void> deleteAllDocumentsInCollection(String collectionName) async {
  final collection = FirebaseFirestore.instance.collection(collectionName);

  Future<void> deleteAllDocumentsInCollection(String collectionName) async {
    final collection = FirebaseFirestore.instance.collection(collectionName);
    int deletedTotal = 0;

    while (true) {
      final snapshot = await collection.limit(500).get();
      final count = snapshot.docs.length;
      if (count == 0) break;

      for (final doc in snapshot.docs) {
        await doc.reference.delete();
        deletedTotal++;
        print('🗑️ 삭제됨: ${doc.id}');
      }

      print('🔁 현재까지 삭제된 문서 수: $deletedTotal');

      // 과부하 방지 및 연결 유지
      await Future.delayed(Duration(milliseconds: 500));
    }

    print('✅ 모든 문서 삭제 완료 (총 $deletedTotal개)');
  }
}

Future<void> signInAsAdmin() async {
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: 'jujun564@naver.com',      // 🔁 여기에 관리자 이메일
        password: 'gmlwn523'             // 🔁 여기에 관리자 비밀번호
    );
    print('✅ Firebase 로그인 성공');
  } catch (e) {
    print('❌ 로그인 실패: $e');
    rethrow;
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await signInAsAdmin(); // ✅ 먼저 로그인
  print('🧨 lostItems 컬렉션 문서 삭제 시작');
  await deleteAllDocumentsInCollection('lostItems');
}
