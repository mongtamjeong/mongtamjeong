import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
    required String description,
    required String imageUrl,
    required String reward,
  }) async {
    final currentUser = _auth.currentUser;
    if (currentUser == null) {
      throw Exception('로그인한 사용자만 글을 올릴 수 있습니다.');
    }

    final String postId = const Uuid().v4();
    final String registerarId = currentUser.uid;
    final DateTime now = DateTime.now();
    final userDoc = await _firestore.collection('users').doc(registerarId).get();
    final nickname = userDoc.data()?['nickname'] ?? '이름없음';
    final profileImage = userDoc.data()?['profileImage'] ?? '';

    final postData = {
      'id': postId,
      'kind': kind,
      'name': name,
      'place': place,
      'regDate': now.toIso8601String(),
      'registerarId': registerarId,
      'description': description,
      'nickname': nickname,
      'imageUrl': imageUrl,
      'profileImage': profileImage,
      'reward': reward,
      'status': '찾는중',
    };

    await _firestore.collection(type == 'lost' ? 'lost_posts' : 'found_posts')
        .doc(postId)
        .set(postData);

    // ✅ 업로드 후 캐시 삭제
    await clearLostItemsCache();
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

  // 공공데이터: lostItems 컬렉션에서 company, regDate, name만 가져오기 (캐시 적용)
  Future<List<Map<String, dynamic>>> getOpenApiLostItems() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedData = prefs.getString('cached_lost_items');

    if (cachedData != null) {
      final List<dynamic> decoded = jsonDecode(cachedData);
      return decoded.map((e) => Map<String, dynamic>.from(e)).toList();
    }

    final snapshot = await _firestore.collection('lostItems').get();

    final items = snapshot.docs.map((doc) {
      final data = doc.data();
      return {
        'id': data['id'],
        'company': data['company'],
        'regDate': data['regDate'],
        'name': data['name'],
        'detail': data['detail'],
        'place': data['place'],
        'kind': data['kind']
      };
    }).toList();

    await prefs.setString('cached_lost_items', jsonEncode(items));
    return items;
  }

  // 캐시 초기화
  Future<void> clearLostItemsCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('cached_lost_items');
  }
}