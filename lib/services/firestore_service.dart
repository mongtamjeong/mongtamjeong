import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> saveToFirestoreInBatches(List<Map<String, dynamic>> items, {int batchSize = 200}) async {
  final firestore = FirebaseFirestore.instance;
  final collection = firestore.collection('lostItems');

  int successCount = 0;
  int failCount = 0;

  for (int i = 0; i < items.length; i += batchSize) {
    final batch = firestore.batch();

    final chunk = items.sublist(i, (i + batchSize > items.length) ? items.length : i + batchSize);

    for (final item in chunk) {
      final id = item['id']?.toString().trim();
      if (id == null || id.isEmpty) {
        print('❌ [스킵] ID 누락: $item');
        continue;
      }

      final docRef = collection.doc(id);
      batch.set(docRef, item);
    }

    try {
      await batch.commit(); // 🔁 한 번에 저장
      successCount += chunk.length;
      print('✅ Batch 저장 완료: $i ~ ${i + chunk.length - 1}');
    } catch (e) {
      failCount += chunk.length;
      print('❌ Batch 저장 실패: $e');
    }

    // 🔄 Firestore 쓰기 제한 회피용 딜레이
    await Future.delayed(const Duration(milliseconds: 500));
  }

  print('📊 저장 완료: 성공 $successCount개, 실패 $failCount개');
}
