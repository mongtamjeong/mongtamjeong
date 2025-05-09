import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  final _chatroomRef = FirebaseFirestore.instance.collection('chatroom');
  final _auth = FirebaseAuth.instance;

  /// 채팅방 생성 또는 기존 채팅방 반환
  Future<String> createOrGetChatRoom(String otherUid) async {
    final currentUid = _auth.currentUser!.uid;

    // 기존 채팅방 존재 여부 확인
    final existing = await _chatroomRef
        .where('participants', arrayContains: currentUid)
        .get();

    for (final doc in existing.docs) {
      final participants = List<String>.from(doc['participants']);
      if (participants.contains(otherUid)) {
        return doc.id; // 기존 방 ID 반환
      }
    }

    // 없으면 새로 생성
    final newDoc = await _chatroomRef.add({
      'createdAt': Timestamp.now(),
      'participants': [currentUid, otherUid],
    });

    return newDoc.id;
  }

  /// 로그인 사용자가 참여 중인 채팅방 목록 스트림 반환
  Stream<QuerySnapshot> getUserChatRooms() {
    final currentUid = _auth.currentUser!.uid;
    return _chatroomRef
        .where('participants', arrayContains: currentUid)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  /// 특정 채팅방에 메시지 저장
  Future<void> sendMessage({
    required String chatroomId,
    required String text,
  }) async {
    final currentUid = _auth.currentUser!.uid;

    final messageRef = _chatroomRef
        .doc(chatroomId)
        .collection('messages')
        .doc();

    await messageRef.set({
      'sender': currentUid,
      'text': text,
      'timestamp': Timestamp.now(),
    });

    // 👉 채팅방 문서의 마지막 메시지 필드 업데이트
    await _chatroomRef.doc(chatroomId).update({
      'lastMessage': text,
      'lastMessageAt': Timestamp.now(),
    });
  }


  /// 채팅 메시지 실시간 스트림
  Stream<QuerySnapshot> getMessages(String chatroomId) {
    return _chatroomRef
        .doc(chatroomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
