import 'package:flutter/material.dart';
import 'wishList.dart';
import 'chat1.dart';
import 'myPage.dart';
import 'home.dart';
import 'find_found3.dart';
import 'find_found4.dart';
import '../services/post_service.dart';


String timeAgoFromNow(String isoDate) {
  final dateTime = DateTime.parse(isoDate).toLocal();
  final now = DateTime.now();
  final difference = now.difference(dateTime);

  if (difference.inMinutes < 1) return '방금 전';
  if (difference.inMinutes < 60) return '${difference.inMinutes}분 전';
  if (difference.inHours < 24) return '${difference.inHours}시간 전';
  if (difference.inDays < 7) return '${difference.inDays}일 전';
  return '${dateTime.year}.${dateTime.month}.${dateTime.day}';
}


class FindFound1 extends StatefulWidget {
  @override
  State<FindFound1> createState() => _FindFound1State();
}

class _FindFound1State extends State<FindFound1> {
  final PostService _postService = PostService();
  List<Map<String, dynamic>> _openApiItems = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  Future<void> _loadItems() async {
    final items = await _postService.getOpenApiLostItems();
    setState(() {
      _openApiItems = items;
      _loading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          '게시판',
          style: TextStyle(
            color: Color(0xFF212121),
            fontSize: 24,
            fontFamily: 'Pretendard Variable',
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Wishlist()),
                );
              },
              icon: const Icon(Icons.favorite,color: Color(0xFFAEAEAE))),
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications,color: Color(0xFFAEAEAE))),
        ],
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Divider(
            height: 1,
            thickness: 1,
            color: Color(0xFFDDDDDD),
          ),
        ),
      ),

      // 게시글 리스트
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _openApiItems.length,
        itemBuilder: (context, index) {
          final item = _openApiItems[index];
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 123,
                      height: 123,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${item['name']} 주인 찾아요',
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '찾아요/찾았어요',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            '${item['company']} · ${timeAgoFromNow(item['regDate'])}',
                            style: TextStyle(
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



      //플로팅 액션 버튼
    floatingActionButton: FloatingActionButton(
    onPressed: () {
    showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
    return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
    ListTile(
    title: const Text('찾아요'),
    onTap: () {
    Navigator.pop(context);
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => FindFound3()),
    );
    },
    ),
    ListTile(
    title: const Text('찾았어요'),
    onTap: () {
    Navigator.pop(context);
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => FindFound4()),
    );
    },
    ),
    ],
    );
    },
    );
    },
    backgroundColor: const Color(0xFFB5FFFF),
    child: const Icon(Icons.add, color: Colors.white),
    ),

    //하단 네비게이션 바
    bottomNavigationBar: BottomNavigationBar(
    currentIndex: 1,
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Color(0xFFB5FFFF),
    unselectedItemColor: Colors.grey,
    onTap: (index) {
    if(index == 0){
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Home()),
    );
    }
    else if (index == 1){
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => FindFound1()),
    );
    }
    else if (index == 2){
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Chat1()),
    );
    }else if (index == 3){
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Mypage()),
    );
    }
    },
    items: const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
    BottomNavigationBarItem(icon: Icon(Icons.article), label: '게시판'),
    BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: '채팅'),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: '마이페이지'),
    ],
    ),
    );
  }
}