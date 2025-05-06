import 'package:flutter/material.dart';

/// 1. Post 데이터 모델 클래스
class Post {
  final String title;
  final String location;
  final DateTime timestamp;
  final String imageUrl;

  Post({
    required this.title,
    required this.location,
    required this.timestamp,
    required this.imageUrl,
  });
}

/// 2. 내가 쓴 글 페이지
class Mypost extends StatefulWidget {
  const Mypost({super.key});

  @override
  State<Mypost> createState() => _MypostState();
}

class _MypostState extends State<Mypost> {
  // 3. 더미 글 목록 (추후 Firebase 데이터로 대체)
  final List<Post> userPosts = [
    Post(
      title: '내건가..',
      location: '어디어디',
      timestamp: DateTime.now().subtract(const Duration(minutes: 10)),
      imageUrl: '', // 이미지 URL 없으면 회색 박스로 대체됨
    ),
    Post(
      title: '지갑을 잃어버렸어요',
      location: '인하대학교 후문',
      timestamp: DateTime.now().subtract(const Duration(hours: 1, minutes: 25)),
      imageUrl: '',
    ),
    Post(
      title: '에어팟 분실했습니다',
      location: '60주년기념관 앞',
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
      imageUrl: '',
    ),
  ];

  // 4. 시간 표시 포맷
  String formatTimeAgo(DateTime timestamp) {
    final diff = DateTime.now().difference(timestamp);
    if (diff.inMinutes < 60) {
      return '${diff.inMinutes}분 전';
    } else if (diff.inHours < 24) {
      return '${diff.inHours}시간 전';
    } else {
      return '${diff.inDays}일 전';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          '내가 쓴 글',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Divider(
            height: 1,
            thickness: 1,
            color: Color(0xFFDDDDDD),
          ),
        ),
      ),

      // 5. 게시글 리스트
      body: ListView.builder(
        itemCount: userPosts.length,
        itemBuilder: (context, index) {
          final post = userPosts[index];
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 이미지 (없으면 회색박스)
                    Container(
                      width: 123,
                      height: 123,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                        image: post.imageUrl.isNotEmpty
                            ? DecorationImage(
                          image: NetworkImage(post.imageUrl),
                          fit: BoxFit.cover,
                        )
                            : null,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            post.title,
                            style: const TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${post.location} · ${formatTimeAgo(post.timestamp)}',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                height: 1,
                thickness: 1,
                color: Color(0xFFDDDDDD),
                indent: 16,
                endIndent: 16,
              ),
            ],
          );
        },
      ),
    );
  }
}
