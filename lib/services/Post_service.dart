//게시물 업로드 (찾아요, 찾았어요 글 업로드)
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

class PostService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // 게시글 업로드 (type: 'lost' 또는 'found')
  Future<void> uploadPost({
    required String type, // 'lost' 또는 'found'
    required String kind,
    required String name,
    required String place,
  }) async {
    final currentUser = _auth.currentUser;
    if (currentUser == null) {
      throw Exception('로그인한 사용자만 글을 올릴 수 있습니다.');
    }

    final String postId = const Uuid().v4();
    final String registerarId = currentUser.uid;
    final DateTime now = DateTime.now();

    final postData = {
      'id': postId,
      'kind': kind,
      'name': name,
      'place': place,
      'regDate': now.toIso8601String(),
      'registerarId': registerarId,
      'status': '찾는중',
    };

    await _firestore.collection(type == 'lost' ? 'lost_posts' : 'found_posts')
        .doc(postId)
        .set(postData);
  }

  // 전체 게시글 가져오기 (lost + found)
  Future<List<Map<String, dynamic>>> getAllPosts() async {
    final lostSnapshot = await _firestore.collection('lost_posts').get();
    final foundSnapshot = await _firestore.collection('found_posts').get();

    final allPosts = [
      ...lostSnapshot.docs.map((doc) => doc.data()),
      ...foundSnapshot.docs.map((doc) => doc.data()),
    ];

    return allPosts;
  }

  // 공공데이터: lostItems 컬렉션에서 company, regDate, name만 가져오기
  Future<List<Map<String, dynamic>>> getOpenApiLostItems() async {
    final snapshot = await _firestore.collection('lostItems').get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      return {
        'company': data['company'],
        'regDate': data['regDate'],
        'name': data['name'],
      };
    }).toList();
  }
}