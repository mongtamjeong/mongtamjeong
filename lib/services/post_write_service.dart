import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

class PostWriteService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> uploadLostPost({
    required String name,
    required String kind,
    required String place,
    required String description,
    required String reward,
    required String imageUrl,
  }) async {
    final currentUser = _auth.currentUser;
    if (currentUser == null) {
      throw Exception('로그인한 사용자만 글을 올릴 수 있습니다.');
    }

    final String postId = const Uuid().v4();
    final DateTime now = DateTime.now();

    final postData = {
      'id': postId,
      'type': 'lost', // 고정
      'name': name,
      'kind': kind,
      'place': place,
      'description': description,
      'reward': reward,
      'imageUrl': imageUrl,
      'regDate': now.toIso8601String(),
      'registerarId': currentUser.uid,
      'status': '찾는중',
    };

    await _firestore.collection('lost_posts').doc(postId).set(postData);
  }

  Future<void> uploadFoundPost({
    required String name,
    required String kind,
    required String place,
    required String description,
    required String reward,
    required String imageUrl,
  }) async {
    final currentUser = _auth.currentUser;
    if (currentUser == null) {
      throw Exception('로그인한 사용자만 글을 올릴 수 있습니다.');
    }

    final String postId = const Uuid().v4();
    final DateTime now = DateTime.now();

    final postData = {
      'id': postId,
      'type': 'found', // 고정
      'name': name,
      'kind': kind,
      'place': place,
      'description': description,
      'reward': reward,
      'imageUrl': imageUrl,
      'regDate': now.toIso8601String(),
      'registerarId': currentUser.uid,
      'status': '찾는중',
    };

    await _firestore.collection('found_posts').doc(postId).set(postData);
  }
}
