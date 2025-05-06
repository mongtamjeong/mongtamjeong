import 'package:flutter/widgets.dart'; // MaterialApp이 필요 없는 경우
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/api_service.dart';
import '../services/firestore_service.dart';
import '../firebase_options.dart';

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
  WidgetsFlutterBinding.ensureInitialized(); // ✅ 반드시 먼저 호출

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await signInAsAdmin();
  print('📦 데이터 동기화 시작');
  final items = await fetchAllLostItems();  // 여기서 날짜 필터도 적용됨
  print('✅ 가져온 항목 수: ${items.length}');

  await saveToFirestoreInBatches(items);
}
